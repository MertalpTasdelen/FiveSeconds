platform :ios, '9.0'

target 'FiveSeconds' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!


  # Pods for FiveSeconds
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/Database'
  pod 'SVProgressHUD'
  pod 'ChameleonFramework/Swift', :git => 'https://github.com/ViccAlexander/Chameleon.git'
  pod 'SwiftyJSON', '~> 4.0'


end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
        end
    end
end
