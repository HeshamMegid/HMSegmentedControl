HMSegmentedControl
===

[![Pod Version](http://img.shields.io/cocoapods/v/HMSegmentedControl.svg?style=flat)](http://cocoadocs.org/docsets/HMSegmentedControl)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Pod Platform](http://img.shields.io/cocoapods/p/HMSegmentedControl.svg?style=flat)](http://cocoadocs.org/docsets/HMSegmentedControl)
[![Pod License](http://img.shields.io/cocoapods/l/HMSegmentedControl.svg?style=flat)](http://opensource.org/licenses/MIT)

A highly customizable drop-in replacement for UISegmentedControl, used by more than 22,000 apps, including TikTok, PayPal, Imgur and Bleacher Report.

<div align="center">
<img src="https://raw.githubusercontent.com/HeshamMegid/HMSegmentedControl/master/Screenshots/6.PNG" width="70%">
<br /><br />
<img src="https://raw.githubusercontent.com/HeshamMegid/HMSegmentedControl/master/Screenshots/8.jpeg" width="70%">
<br /><br />
<img src="https://raw.githubusercontent.com/HeshamMegid/HMSegmentedControl/master/Screenshots/7.PNG" width="70%">
</div>


# Features

- 📸 Supports both text and images
- ↕️ Multiple sizing and selection styles
- 📜 Horizontal scrolling for an infinite number of segments
- ⚙️ Advanced title styling with text attributes for font, color, kerning, shadow, etc
- 🖥 Compatible with both Swift and Objective-C
- 📱 Updated for Xcode 11, iOS 13 and Swift 5. Supports all the way back to iOS 7!

# Installation

```
pod 'HMSegmentedControl'
```

Installation via Carthage is also supported..

# Usage

The code below will create a segmented control with the default looks:

```swift
let segmentedControl = HMSegmentedControl(sectionTitles: [
    "Trending",
    "News",
    "Library"
])

segmentedControl.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
view.addSubview(segmentedControl)
```

Included is a demo project showing how to fully customize HMSegmentedControl.

# Possible Styles

<div align="center">
<img src="https://raw.githubusercontent.com/HeshamMegid/HMSegmentedControl/master/Screenshots/1.png" width="70%">
<br /><br />
<img src="https://raw.githubusercontent.com/HeshamMegid/HMSegmentedControl/master/Screenshots/2.png" width="70%">
<br /><br />
<img src="https://raw.githubusercontent.com/HeshamMegid/HMSegmentedControl/master/Screenshots/3.png" width="70%">
<br /><br />
<img src="https://raw.githubusercontent.com/HeshamMegid/HMSegmentedControl/master/Screenshots/4.png" width="70%">
<br /><br />
<img src="https://raw.githubusercontent.com/HeshamMegid/HMSegmentedControl/master/Screenshots/5.png" width="70%">
</div>

# Apps Using HMSegmentedControl

If you are using HMSegmentedControl in your app or know of an app that uses it, please add it to [this list](https://github.com/HeshamMegid/HMSegmentedControl/wiki/Apps-using-HMSegmentedControl).

# Need Help?
  
If you need help with HMSegmentedControl, or with iOS/Swift development in general, check out [swiftmentor.io](https://swiftmentor.io)

# License

HMSegmentedControl is licensed under the terms of the MIT License. Please see the [LICENSE](LICENSE.md) file for full details.

If this code was helpful, I would love to hear from you.

[@HeshamMegid](http://twitter.com/HeshamMegid)   
[http://hesh.am](http://hesh.am)
