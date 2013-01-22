//
//  ViewController.m
//  HMSegmentedControlExample
//
//  Created by Hesham Abd-Elmegid on 23/12/12.
//  Copyright (c) 2012 Hesham Abd-Elmegid. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Minimum code required to use the segmented control with the default styling.
    HMSegmentedControl *segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"Library", @"Trending", @"News"]];
    [segmentedControl setFrame:CGRectMake(10, 10, 300, 60)];
    [segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];

    HMSegmentedControl *segmentedControl2 = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"One", @"Two", @"Three", @"4", @"Five"]];
    [segmentedControl2 setIndexChangeBlock:^(NSInteger index) {
        NSLog(@"Selected index %i (via block)", index);
    }];
    [segmentedControl2 setSelectionIndicatorHeight:4.0f];
    [segmentedControl2 setBackgroundColor:[UIColor colorWithRed:0.1 green:0.4 blue:0.8 alpha:1]];
    [segmentedControl2 setTextColor:[UIColor whiteColor]];
    [segmentedControl2 setSelectionIndicatorColor:[UIColor colorWithRed:0.5 green:0.8 blue:1 alpha:1]];
    [segmentedControl2 setSelectionIndicatorStyle:HMSelectionIndicatorFillsSegment];
    [segmentedControl2 setSelectedSegmentIndex:HMSegmentedControlNoSegment];
    [segmentedControl2 setSegmentEdgeInset:UIEdgeInsetsMake(0, 6, 0, 6)];
    [segmentedControl2 setCenter:CGPointMake(160, 120)];
    [segmentedControl2 setTag:2];
    [self.view addSubview:segmentedControl2];
    
    self.segmentedControl3 = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(0, 200, 320, 50)];
    [self.segmentedControl3 setSectionTitles:@[@"Worldwide", @"Local", @"Headlines"]];
    [self.segmentedControl3 setSelectedSegmentIndex:1];
    [self.segmentedControl3 setBackgroundColor:[UIColor colorWithRed:0.1 green:0.2 blue:0.3 alpha:1]];
    [self.segmentedControl3 setTextColor:[UIColor whiteColor]];
    [self.segmentedControl3 setSelectionIndicatorColor:[UIColor redColor]];
    [self.segmentedControl3 setTag:3];
    [self.segmentedControl3 setIndexChangeBlock:^(NSInteger index) {
        [self.scrollView scrollRectToVisible:CGRectMake(320 * index, 0, 320, 200) animated:YES];
    }];
    
    [self.view addSubview:self.segmentedControl3];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 250, 320, 200)];
    [self.scrollView setBackgroundColor:[UIColor colorWithRed:0.1 green:0.2 blue:0.34 alpha:1]];
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(960, 200)];
    [self.scrollView scrollRectToVisible:CGRectMake(320, 0, 320, 200) animated:NO];
    [self.scrollView setDelegate:self];
    [self.view addSubview:self.scrollView];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 320, 30)];
    [self setApperanceForLabel:label1];
    [label1 setText:@"Worldwide"];
    [self.scrollView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(320, 50, 320, 30)];
    [self setApperanceForLabel:label2];
    [label2 setText:@"Local"];
    [self.scrollView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(640, 50, 320, 30)];
    [self setApperanceForLabel:label3];
    [label3 setText:@"Headlines"];
    [self.scrollView addSubview:label3];
}

- (void)setApperanceForLabel:(UILabel *)label {
    [label setBackgroundColor:[UIColor colorWithRed:0.1 green:0.2 blue:0.34 alpha:1]];
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
    
    [self.segmentedControl3 setSelectedSegmentIndex:page animated:YES];
}

@end
