source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.1'
use_frameworks!

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ARCHS'] = 'arm64'
      config.build_settings['VALID_ARCHS'] = 'arm64'
    end
  end
end

target 'DHCamSystem' do
    pod 'Alamofire'
  	pod 'EAIntroView'
    pod 'Firebase/Core'
    pod 'Firebase/Messaging'
  	pod 'IQKeyboardManagerSwift'
    pod 'PopupDialog'
    pod 'ReachabilitySwift'
  	pod 'SnapKit'
  	pod 'SVProgressHUD'
  	pod 'Toaster'
    pod 'LCOpenSDK'
    pod 'ZXingObjC', '~> 3.2.1'
end
