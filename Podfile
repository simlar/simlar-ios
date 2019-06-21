

source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'
inhibit_all_warnings!

target 'Simlar' do
  pod 'libPhoneNumber-iOS'
  pod 'CocoaLumberjack', '3.5.3'

  target "SimlarTests" do
    inherit! :search_paths
  end
end

post_install do | installer |
	require 'fileutils'
	FileUtils.cp_r('Pods/Target Support Files/Pods-Simlar/Pods-Simlar-acknowledgements.plist', 'Simlar/Settings.bundle/PodsAcknowledgements.plist', :remove_destination => true)
end
