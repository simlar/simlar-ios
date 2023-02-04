simlar-ios
==========

[![Build Status](https://github.com/simlar/simlar-ios/workflows/simlar-ios-ci/badge.svg?branch=master)](https://github.com/simlar/simlar-ios/actions)

[Simlar](https://www.simlar.org) is a cross platform VoIP App aiming to make ZRTP encrypted calls easy.

<div id="screenshots" align="center">
<img src="https://www.simlar.org/press/screenshots/iOS/address_book.png" alt="Screenshot address book" text-align="center" width="200">
<img src="https://www.simlar.org/press/screenshots/iOS/ongoing_call.png" alt="Screenshot call" text-align="center" width="200">
</div>

### Pods ###
simlar-ios uses [CocoaPods](https://cocoapods.org/) to manage its dependencies. Download them with:
```
pod install
```

In order to update libs handled by CocoaPods run:
```
pod update
```

### Xcode ###
After downloading dependencies, simply import simlar-ios in XCode.

### liblinphone ###
Simlar heavily depends on [liblinphone](http://www.linphone.org/).
Since version 4.2 it is available as Pod.
However if you would like to compile it yourself, you should start with compiling [linphone-sdk](https://gitlab.linphone.org/BC/public/linphone-sdk) for iOS.
Please follow the build instructions there.
Once you have managed to compile linphone-iphone on your system, here is a script for checking out, applying Simlar patches, compile and integrate liblinphone into simlar-ios.
```
./bootstrap-liblinphone.sh origin/master
```

### Post quantum encryption ###
Simlar uses post quantum encryption since version 2.6 as liblinphone supports it since version 5.2.
However the liblinphone artifacts published in the maven repository do not support it.
So you have to build lt yourself.
