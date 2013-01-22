HMSegmentedControl
==================

A drop-in replacement for UISegmentedControl mimicking the style of the segmented control used in Google Currents.

Usage
-----
Included is a demo project showing how to use the control.

To use in your own project, first import HMSegmentedControl.m and HMSegmentedControl.h into your project, then add QuartzCore to your linked libraries.

The code below will create a segmented control with the default looks:

```  objective-c
HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"One", @"Two", @"Three"]];
[segmentedControl setFrame:CGRectMake(10, 10, 300, 60)];
[segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
[self.view addSubview:segmentedControl];
```

![HMSegmentedControl](https://raw.github.com/HeshamMegid/HMSegmentedControl/master/Screenshot.png)

License
--------
HMSegmentedControl is licensed under the terms of the MIT License. Please see the LICENSE file for full details.

If this code was helpful, I would love to hear from you.

[@HeshamMegid](http://twitter.com/HeshamMegid)   
[http://hesh.am](http://hesh.am)
