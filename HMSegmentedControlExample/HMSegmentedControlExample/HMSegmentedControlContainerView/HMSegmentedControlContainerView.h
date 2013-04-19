//
//  HMSegmentedControlContainerView.h
//  HMSegmentedControlExample
//
//  Created by Thongchai Kolyutsakul on 4/19/13.
//  Copyright (c) 2013 Thongchai Kolyutsakul. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMSegmentedControl;

@interface HMSegmentedControlContainerView : UIView

@property (nonatomic, weak) HMSegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, readwrite) CGFloat minimumSegmentWidth; // default is 32.0

- (id)initWithHMSegmentedControl:(HMSegmentedControl*)control;

- (void)scrollToSelectedSegmentIndexAnimated:(BOOL)animated;
- (void)scrollToSegmentIndex:(int)index animated:(BOOL)animated;

@end
