platform :ios, '13.0'
use_frameworks!
inhibit_all_warnings!

target 'To-DoDemo' do
  
  #Database
  pod 'RealmSwift'

  #Auth
  pod 'FirebaseAuth'
  pod 'GoogleSignIn'

  #Network
  pod 'Moya'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
