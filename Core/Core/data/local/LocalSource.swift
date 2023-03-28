import Foundation
import CoreData
import UIKit

class LocalSource: LocalSourceProtocol {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let momdName = Constants.databaseName
        guard let modelURL = Bundle(for: type(of: self)).url(forResource: momdName, withExtension:"momd") else {
                fatalError("Error loading model from bundle")
        }
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let container = NSPersistentContainer(name: momdName, managedObjectModel: mom)
        
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        
        return container
    }()
    
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
    
    func getAllFavorite(completion: @escaping(_ favorites: [ItemGameEntity]) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.tableName)
            do {
                let results = try taskContext.fetch(fetchRequest)
                var favorites: [ItemGameEntity] = []
                for result in results {
                    let member = ItemGameEntity(
                        id: result.value(forKeyPath: Constants.gameId) as! Int,
                        name: result.value(forKeyPath: Constants.name) as! String,
                        released: result.value(forKeyPath: Constants.released) as! String,
                        backgroundImage: result.value(forKeyPath: Constants.backgroundImage) as! String,
                        rating: result.value(forKeyPath: Constants.rating) as! Double
                    )
                    favorites.append(member)
                }
                completion(favorites)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func getFavoriteById(_ id: Int, completion: @escaping(_ favorite: ItemGameEntity?) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.tableName)
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "\(Constants.gameId) == \(id)")
            do {
                if let result = try taskContext.fetch(fetchRequest).first{
                    let member = ItemGameEntity(
                        id: result.value(forKeyPath: Constants.gameId) as! Int,
                        name: result.value(forKeyPath: Constants.name) as! String,
                        released: result.value(forKeyPath: Constants.released) as! String,
                        backgroundImage: result.value(forKeyPath: Constants.backgroundImage) as! String,
                        rating: result.value(forKeyPath: Constants.rating) as! Double
                    )
                    completion(member)
                } else {
                    completion(nil)
                }
            } catch let error as NSError {
                completion(nil)
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }
    
    func createFavorite(
        _ gameId: Int,
        _ name: String,
        _ released: String,
        _ backgroundImage: String,
        _ rating: Double,
        completion: @escaping(_ isSuccess: Bool) -> Void
    ) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            if let entity = NSEntityDescription.entity(forEntityName: Constants.tableName, in: taskContext) {
                let member = NSManagedObject(entity: entity, insertInto: taskContext)
                self.getMaxId { id in
                    member.setValue(id+1, forKeyPath: Constants.id)
                    member.setValue(name, forKeyPath: Constants.name)
                    member.setValue(released, forKeyPath: Constants.released)
                    member.setValue(backgroundImage, forKeyPath: Constants.backgroundImage)
                    member.setValue(rating, forKeyPath: Constants.rating)
                    member.setValue(gameId, forKeyPath: Constants.gameId)
                    
                    do {
                        try taskContext.save()
                        completion(true)
                    } catch let error as NSError {
                        completion(false)
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                }
            }
        }
    }
    
    func getMaxId(completion: @escaping(_ maxId: Int) -> Void) {
        let taskContext = newTaskContext()
        taskContext.performAndWait {
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.tableName)
            let sortDescriptor = NSSortDescriptor(key: Constants.id, ascending: false)
            fetchRequest.sortDescriptors = [sortDescriptor]
            fetchRequest.fetchLimit = 1
            do {
                let lastMember = try taskContext.fetch(fetchRequest)
                if let member = lastMember.first, let position = member.value(forKeyPath: Constants.id) as? Int{
                    completion(position)
                } else {
                    completion(0)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteFavorite(_ id: Int, completion: @escaping(_ isSuccess: Bool) -> Void) {
        let taskContext = newTaskContext()
        taskContext.perform {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.tableName)
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(format: "\(Constants.gameId) == \(id)")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            batchDeleteRequest.resultType = .resultTypeCount
            if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                if batchDeleteResult.result != nil {
                    completion(true)
                } else {
                    completion(false)
                }
            }
        }
    }
}
