source 'https://cdn.cocoapods.org/'
source 'https://gitlab.linphone.org/BC/public/podspec.git'

platform :ios, '10.0'
inhibit_all_warnings!

$PODFILE_PATH = 'liblinphone'

target 'Simlar' do
  use_frameworks!

  pod 'libPhoneNumber-iOS'
  pod 'CocoaLumberjack', '3.7.0'
  if File.exist?($PODFILE_PATH)
    pod 'linphone-sdk', :path => $PODFILE_PATH
  else
    pod 'linphone-sdk', '4.4.32'
  end

  target 'SimlarTests' do
    inherit! :search_paths
  end
end

post_install do | installer |
  require 'fileutils'
  FileUtils.cp_r('Pods/Target Support Files/Pods-Simlar/Pods-Simlar-acknowledgements.plist', 'Simlar/Settings.bundle/PodsAcknowledgements.plist', :remove_destination => true)
end
