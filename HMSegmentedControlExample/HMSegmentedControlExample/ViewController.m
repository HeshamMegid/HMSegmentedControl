//
//  ViewController.m
//  HMSegmentedControlExample
//
//  Created by Hesham Abd-Elmegid on 23/12/12.
//  Copyright (c) 2012 Hesham Abd-Elmegid. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat yDelta;
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
        yDelta = 20.0f;
    } else {
        yDelta = 0.0f;
    }
    
    // Minimum code required to use the segmented control with the default styling.
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Trending", @"News", @"Library"]];
    segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    [segmentedControl setFrame:CGRectMake(0, 0 + yDelta, 320, 40)];
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:segmentedControl];
    
    
    // Segmented control with scrolling
    HMSegmentedControl *segmentedControl1 = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"One Thousand"]];
    segmentedControl1.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    segmentedControl1.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl1.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
	segmentedControl1.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleDynamic;
    segmentedControl1.scrollEnabled = YES;
    segmentedControl1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    [segmentedControl1 setFrame:CGRectMake(0, 40 + yDelta, 320, 40)];
    [segmentedControl1 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl1];
    
    // Segmented control with images
    HMSegmentedControl *segmentedControl2 = [[HMSegmentedControl alloc] initWithSectionImages:@[[UIImage imageNamed:@"1"], [UIImage imageNamed:@"2"], [UIImage imageNamed:@"3"], [UIImage imageNamed:@"4"]] sectionSelectedImages:@[[UIImage imageNamed:@"1-selected"], [UIImage imageNamed:@"2-selected"], [UIImage imageNamed:@"3-selected"], [UIImage imageNamed:@"4-selected"]]];
    [segmentedControl2 setSelectionIndicatorHeight:4.0f];
    [segmentedControl2 setFrame:CGRectMake(0, 100 + yDelta, 320, 50)];
    [segmentedControl2 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [segmentedControl2 setBackgroundColor:[UIColor clearColor]];
    [segmentedControl2 setSelectionIndicatorLocation:HMSegmentedControlSelectionIndicatorLocationDown];
    [segmentedControl2 setSelectionStyle:HMSegmentedControlSelectionStyleTextWidthStripe];
    [self.view addSubview:segmentedControl2];

    
    // Segmented control with more customization and indexChangeBlock
    HMSegmentedControl *segmentedControl3 = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"One", @"Two", @"Three", @"4", @"Five"]];
    [segmentedControl3 setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"Selected index %i (via block)", index);
    }];
    [segmentedControl3 setSelectionIndicatorHeight:4.0f];
    [segmentedControl3 setBackgroundColor:[UIColor colorWithRed:0.1 green:0.4 blue:0.8 alpha:1]];
    [segmentedControl3 setTextColor:[UIColor whiteColor]];
    [segmentedControl3 setSelectedTextColor:[UIColor whiteColor]];
    [segmentedControl3 setSelectionIndicatorColor:[UIColor colorWithRed:0.5 green:0.8 blue:1 alpha:1]];
    [segmentedControl3 setSelectionStyle:HMSegmentedControlSelectionStyleBox];
    [segmentedControl3 setSelectedSegmentIndex:HMSegmentedControlNoSegment];
    [segmentedControl3 setSelectionIndicatorLocation:HMSegmentedControlSelectionIndicatorLocationDown];
    [segmentedControl3 setFrame:CGRectMake(0, 160 + yDelta, 320, 50)];
    [segmentedControl3 setTag:2];
    [self.view addSubview:segmentedControl3];
    
    
    // Tying up the segmented control to a scroll view
    self.segmentedControl4 = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 240 + yDelta, 320, 50)];
    [self.segmentedControl4 setSectionTitles:@[@"Worldwide", @"Local", @"Headlines"]];
    [self.segmentedControl4 setSelectedSegmentIndex:1];
    [self.segmentedControl4 setBackgroundColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1]];
    [self.segmentedControl4 setTextColor:[UIColor whiteColor]];
    [self.segmentedControl4 setSelectedTextColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1]];
    [self.segmentedControl4 setSelectionIndicatorColor:[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1]];
    [self.segmentedControl4 setSelectionStyle:HMSegmentedControlSelectionStyleBox];
    [self.segmentedControl4 setSelectionIndicatorLocation:HMSegmentedControlSelectionIndicatorLocationUp];
    [self.segmentedControl4 setTag:3];
    
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl4 setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(320 * index, 0, 320, 200) animated:YES];
    }];
    
    [self.view addSubview:self.segmentedControl4];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 290 + yDelta, 320, 210)];
    [self.scrollView setBackgroundColor:[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1]];
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setContentSize:CGSizeMake(960, 200)];
    [self.scrollView scrollRectToVisible:CGRectMake(320, 0, 320, 200) animated:NO];
    [self.scrollView setDelegate:self];
    [self.view addSubview:self.scrollView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 210)];
    [self setApperanceForLabel:label1];
    [label1 setText:@"Worldwide"];
    [self.scrollView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(320, 0, 320, 210)];
    [self setApperanceForLabel:label2];
    [label2 setText:@"Local"];
    [self.scrollView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(640, 0, 320, 210)];
    [self setApperanceForLabel:label3];
    [label3 setText:@"Headlines"];
    [self.scrollView addSubview:label3];
}

- (void)setApperanceForLabel:(UILabel *)label {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    [label setBackgroundColor:color];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont systemFontOfSize:21.0f]];
    [label setTextAlignment:NSTextAlignmentCenter];
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
	NSLog(@"Selected index %i (via UIControlEventValueChanged)", segmentedControl.selectedSegmentIndex);
}

- (void)uisegmentedControlChangedValue:(UISegmentedControl *)segmentedControl {
	NSLog(@"Selected index %i", segmentedControl.selectedSegmentIndex);
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl4 setSelectedSegmentIndex:page animated:YES];
}

@end
