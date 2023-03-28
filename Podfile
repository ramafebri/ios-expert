# Uncomment the next line to define a global platform for your project
platform:ios, '16.0'
 
use_frameworks!
workspace 'Modularization'

target 'ios-expert' do
  # Comment the next line if you don't want to use dynamic frameworks
  # use_frameworks!

  # Pods for ios-expert
  pod 'Alamofire'
  pod 'Cleanse'
  pod 'AlertToast'
end

target 'Core' do
  project 'Core/Core'
  pod 'Alamofire'
  pod 'Cleanse'
end

target 'Favorite' do
  project 'Favorite/Favorite'
end

target 'Detail' do
  project 'Detail/Detail'
  pod 'AlertToast'
end
