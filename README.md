HMSegmentedControl
==================

A drop-in replacement for UISegmentedControl mimicking the style of the segmented control used in Google Currents.

Usage
-----
Included is a demo project showing how to use the control.

To use in your own project, first import HMSegmentedControl.m and HMSegmentedControl.h into your project, then add QuartzCore to your linked libraries.

```  objective-c
HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"One", @"Two", @"Three"]];
[segmentedControl setFrame:CGRectMake(10, 10, 300, 60)];
[segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
[segmentedControl setTag:1];
[self.view addSubview:segmentedControl];`
```

License
--------
Feel free to do whatever you want with this code.

If this code was helpful, I would love to hear from you.

[@HeshamMegid](http://twitter.com/HeshamMegid)   
[http://hesh.am](http://hesh.am)
