HMSegmentedControl
===

[![Pod Version](http://img.shields.io/cocoapods/v/HMSegmentedControl@hons82.svg?style=flat)](http://cocoadocs.org/docsets/HMSegmentedControl@hons82/)
[![Pod Platform](http://img.shields.io/cocoapods/p/HMSegmentedControl@hons82.svg?style=flat)](http://cocoadocs.org/docsets/HMSegmentedControl@hons82/)
[![Pod License](http://img.shields.io/cocoapods/l/HMSegmentedControl@hons82.svg?style=flat)](http://opensource.org/licenses/MIT)

A drop-in replacement for UISegmentedControl mimicking the style of the segmented control used in Google Currents and various other Google products.

# In this fork
- Possibility to add separator lines (customizable color) 
- Fix for Image-tabs not beeing selectable

# Features
- Supports both text and images
- Support horizontal scrolling
- Font and all colors are customizable
- Supports selection indicator both on top and bottom
- Supports blocks
- Works with ARC and iOS >= 5

# Installation

### CocoaPods
The easiest way of installing HMSegmentedControl is via [CocoaPods](http://cocoapods.org/). 

```
pod 'HMSegmentedControl', '~> 1.3.0'
```
this fork:
```
pod 'HMSegmentedControl@hons82', '~> 1.3.1'
```

### Old-fashioned way

- Add `HMSegmentedControl.h` and `HMSegmentedControl.m` to your project.
- Add `QuartzCore.framework` to your linked frameworks.
- `#import "HMSegmentedControl.h"` where you want to add the control.

# Usage

The code below will create a segmented control with the default looks:

```  objective-c
HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"One", @"Two", @"Three"]];
segmentedControl.frame = CGRectMake(10, 10, 300, 60);
[segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
[self.view addSubview:segmentedControl];
```

Included is a demo project showing how to fully customise the control.

![HMSegmentedControl](https://raw.github.com/HeshamMegid/HMSegmentedControl/master/Screenshot.png)

# Change log
* v1.3.0
	* Introducing horizontal scrolling via `scrollEnabled` property. Check example project
	* Adds XIB/Storyboard support
	* Fixes deprecations when building with iOS 7 SDK
	* Updates example project to support iOS 7
	* Code refactoring and cleanup
* v1.2.0
	* Added new selection indicator style: HMSelectionIndicatorBox
	* Added ability to set text colour for selected segment (thanks to [@jmkr](https://github.com/jmkr))
	* Segment titles are now added in a separate CATextLayer, and images are drawn in a separate CALayer
	* Calls to index change block/selector now happen before the animation starts
	* Lots of code refactoring and clean up
* v1.1.0 (merged pull request from [@jacksonpan](https://github.com/jacksonpan))
  * Added image support
  * Support for changing selection indicator position
* v1.0.0
	* Initial release
  
# Apps using HMSegmentedControl

If you are using HMSegmentedControl in your app or know of an app that uses it, please add it to [this list](https://github.com/HeshamMegid/HMSegmentedControl/wiki/Apps-using-HMSegmentedControl).
  

# License

HMSegmentedControl is licensed under the terms of the MIT License. Please see the [LICENSE](LICENSE.md) file for full details.

If this code was helpful, I would love to hear from you.

[@HeshamMegid](http://twitter.com/HeshamMegid)   
[http://hesh.am](http://hesh.am)
