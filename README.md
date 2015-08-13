simlar-ios
==========

[Simlar](https://www.simlar.org) is a cross platform VoIP App aiming to make ZRTP encrypted calls easy.

<div id="screenshots" align="center">
<img src="https://www.simlar.org/press/screenshots/iOS/address_book.png" alt="Screenshot address book" text-align="center" width="200">
<img src="https://www.simlar.org/press/screenshots/iOS/ongoing_call.png" alt="Screenshot call" text-align="center" width="200">
</div>

### Compile ###
Simply check out and import simlar-ios in XCode.
In order to make it easy to start hacking on simlar-ios, a pre-compiled libliblinphoe is checked in.

### Pods ###
simlar-ios uses [CocoaPods](https://cocoapods.org/) e.g. for CocoaLumberjack and libPhoneNumber-iOS.
In order to update libs handled by CocoaPods run:
```
pod update
```

### liblinphone ###
Simlar heavily depends on [liblinphone](http://www.linphone.org/).
If you would like to compile it yourself, you should start with compiling [linphone-iphone](https://github.com/BelledonneCommunications/linphone-iphone).
Please follow the build instructions there.
Once you have managed to compile linphone-iphone on your system, here is a script for checking out, applying Simlar patches, compile and integrate liblinphone into simlar-ios.
```
./bootstrap-liblinphone.sh origin/master
```
