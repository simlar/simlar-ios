source 'https://cdn.cocoapods.org/'
source 'https://gitlab.linphone.org/BC/public/podspec.git'

platform :ios, '12.0'
inhibit_all_warnings!

$PODFILE_PATH = 'liblinphone'

target 'Simlar' do
  use_frameworks!

  pod 'libPhoneNumber-iOS', git: 'https://github.com/iziz/libPhoneNumber-iOS', tag: '1.1'
  pod 'CocoaLumberjack', '3.8.5'
  if File.exist?($PODFILE_PATH)
    pod 'linphone-sdk', :path => $PODFILE_PATH
  else
    pod 'linphone-sdk', '5.3.5'
  end

  target 'SimlarTests' do
    inherit! :search_paths
  end
end

install! 'cocoapods', :disable_input_output_paths => true

post_install do | installer |
  require 'fileutils'
  FileUtils.cp_r('Pods/Target Support Files/Pods-Simlar/Pods-Simlar-acknowledgements.plist', 'Simlar/Settings.bundle/PodsAcknowledgements.plist', :remove_destination => true)

  installer.pods_project.targets.each do | target |
    target.build_configurations.each do | config |
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
