source 'https://github.com/CocoaPods/Specs.git'

platform :ios, "8.0"

link_with ["Simlar", "SimlarTests"]

pod 'libPhoneNumber-iOS'
pod 'CocoaLumberjack',        '>= 2.0.0-beta1'

post_install do | installer |
	require 'fileutils'
	FileUtils.cp_r('Pods/Target Support Files/Pods/Pods-acknowledgements.plist', 'Simlar/Settings.bundle/PodsAcknowledgements.plist', :remove_destination => true)
end
