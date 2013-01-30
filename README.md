HMSegmentedControl
==================

A drop-in replacement for UISegmentedControl mimicking the style of the segmented control used in Google Currents.

# Features
- Supports both text and images
- Font and all colors are customizable
- Supports selection indicator both on top and bottom
- Supports blocks
- Works with ARC and iOS >= 5

# Installation

## CocoaPods
The easiest way of installing HMSegmentedControl is via [CocoaPods](http://cocoapods.org/). 

```
pod 'HMSegmentedControl', '~> 1.1.0'
```

## Cocoa-whaa?

If you haven't heard about [CocoaPods](http://cocoapods.org/) (seriously, where were you?!), it's a dependency manager for Xcode projects that provides very simple
installation of libraries. Here's how to get started.

Install CocoaPods if not already available:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```

Change to the directory of your Xcode project, and Create and Edit your Podfile and add HMSegmentedControl:

``` bash
$ cd /path/to/MyProject
$ touch Podfile
$ edit Podfile
platform :ios, '5.0' 
pod 'HMSegmentedControl', '~> 1.0.0'
```

Install into your project:

``` bash
$ pod install
```

Open your project in Xcode from the .xcworkspace file (not the usual project file)

``` bash
$ open MyProject.xcworkspace
```

## Old-fashioned way

- Add `HMSegmentedControl.h` and `HMSegmentedControl.m` to your project.
- Add `QuartzCore.framework` to your linked frameworks.
- `#import "HMSegmentedControl.h"` where you want to add the control.

# Usage

The code below will create a segmented control with the default looks:

```  objective-c
HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"One", @"Two", @"Three"]];
[segmentedControl setFrame:CGRectMake(10, 10, 300, 60)];
[segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
[self.view addSubview:segmentedControl];
```

Included is a demo project showing how to fully customise the control.

![HMSegmentedControl](https://raw.github.com/HeshamMegid/HMSegmentedControl/master/Screenshot.png)

# Change log
- v1.1.0 (merged pull request from [jacksonpan](https://github.com/jacksonpan))
  - Added image support
  - Support for changing selection indicator position

# License

HMSegmentedControl is licensed under the terms of the MIT License. Please see the LICENSE file for full details.

If this code was helpful, I would love to hear from you.

[@HeshamMegid](http://twitter.com/HeshamMegid)   
[http://hesh.am](http://hesh.am)
