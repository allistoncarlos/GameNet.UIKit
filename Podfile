# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'GameNet.UIKit' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GameNet.UIKit
  pod 'Alamofire', '~> 5.5'
  pod 'Swinject'
  pod 'SwinjectStoryboard'
  pod 'SDWebImage'
  pod 'SwiftyFORM'
  pod 'SwiftLint'
  
  target 'GameNetTests' do
      inherit! :search_paths
      # Pods for testing
      
      pod 'OHHTTPStubs/Swift'
    end

  post_install do |installer|
    installer.pods_project.targets.each do |target|
     target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
     end
    end
   end
end
