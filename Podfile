source 'https://github.com/CocoaPods/Specs.git'
source "https://gitlab.linphone.org/BC/public/podspec.git"

platform :ios, '9.0'
inhibit_all_warnings!

target 'Simlar' do
  use_frameworks!

  pod 'libPhoneNumber-iOS'
  pod 'CocoaLumberjack', '3.5.3'
  if ENV['PODFILE_PATH'].nil?
    pod 'linphone-sdk', '4.2'
  else
    pod 'linphone-sdk', :path => ENV['PODFILE_PATH']
  end

  target "SimlarTests" do
    inherit! :search_paths
  end
end

post_install do | installer |
  require 'fileutils'
  FileUtils.cp_r('Pods/Target Support Files/Pods-Simlar/Pods-Simlar-acknowledgements.plist', 'Simlar/Settings.bundle/PodsAcknowledgements.plist', :remove_destination => true)
end
