//
//  HMSegmentedControl.h
//  HMSegmentedControl
//
//  Created by Hesham Abd-Elmegid on 23/12/12.
//  Copyright (c) 2012 Hesham Abd-Elmegid. All rights reserved.
//

#import <UIKit/UIKit.h>

enum HMSelectionIndicatorMode {
    HMSelectionIndicatorResizesToStringWidth = 0, // Indicator width will only be as big as the text width
    HMSelectionIndicatorFillsSegment = 1 // Indicator width will fill the whole segment
};

@interface HMSegmentedControl : UIControl

@property (nonatomic, strong) NSArray *sectionTitles;
@property (nonatomic, copy) void (^indexChangeBlock)(NSUInteger index); // you can also use addTarget:action:forControlEvents:

@property (nonatomic, strong) UIFont *font; // default is [UIFont fontWithName:@"Avenir-Light" size:19.0f]
@property (nonatomic, strong) UIColor *textColor; // default is [UIColor blackColor]
@property (nonatomic, strong) UIColor *backgroundColor; // default is [UIColor whiteColor]
@property (nonatomic, strong) UIColor *selectionIndicatorColor; // default is 52, 181, 229
@property (nonatomic, assign) enum HMSelectionIndicatorMode selectionIndicatorMode; // Default is HMSelectionIndicatorResizesToStringWidth

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, readwrite) CGFloat height; // default is 32.0
@property (nonatomic, readwrite) CGFloat selectionIndicatorHeight; // default is 5.0
@property (nonatomic, readwrite) UIEdgeInsets segmentEdgeInset; // default is UIEdgeInsetsMake(0, 5, 0, 5)

- (id)initWithSectionTitles:(NSArray *)sectiontitles;
- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated;

@end
