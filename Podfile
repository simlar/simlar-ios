source 'https://github.com/CocoaPods/Specs.git'

platform :ios, "8.0"

link_with ["Simlar", "SimlarTests"]

pod 'libPhoneNumber-iOS',     '~> 0.7'
pod 'CocoaLumberjack'

post_install do | installer |
	require 'fileutils'
	FileUtils.cp_r('Pods/Target Support Files/Pods/Pods-acknowledgements.plist', 'Simlar/Settings.bundle/PodsAcknowledgements.plist', :remove_destination => true)
end
