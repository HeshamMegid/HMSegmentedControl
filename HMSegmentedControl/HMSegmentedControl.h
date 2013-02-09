//
//  HMSegmentedControl.h
//  HMSegmentedControl
//
//  Created by Hesham Abd-Elmegid on 23/12/12.
//  Copyright (c) 2012 Hesham Abd-Elmegid. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^IndexChangeBlock)(NSInteger index);

enum HMSelectionIndicatorStyle {
    HMSelectionIndicatorResizesToSectionWidth = 0, // Indicator width will only be as big as the text width
    HMSelectionIndicatorFillsSegment = 1 // Indicator width will fill the whole segment
};

enum {
    HMSegmentedControlNoSegment = -1   // segment index for no selected segment
};

enum HMSelectionIndicatorLocation {
    HMSelectionIndicatorLocationUp = 0,
    HMSelectionIndicatorLocationDown
};

enum HMSelectionIndicatorSectionType{
    HMSelectionIndicatorSectionTitles = 0,
    HMSelectionIndicatorSectionIcons = 1
};

@interface HMSegmentedControl : UIControl

@property (nonatomic, strong) NSArray *sectionTitles;

@property (nonatomic, strong) NSArray *sectionIcons;
@property (nonatomic, strong) NSArray *sectionHighlightIcons;

@property (nonatomic, copy) IndexChangeBlock indexChangeBlock; // you can also use addTarget:action:forControlEvents:

@property (nonatomic, strong) UIFont *font; // default is [UIFont fontWithName:@"STHeitiSC-Light" size:18.0f]
@property (nonatomic, strong) UIColor *textColor; // default is [UIColor blackColor]
@property (nonatomic, strong) UIColor *selectedTextColor; // default is [UIColor blackColor]
@property (nonatomic, strong) UIColor *backgroundColor; // default is [UIColor whiteColor]
@property (nonatomic, strong) UIColor *selectionIndicatorColor; // default is R:52, G:181, B:229
@property (nonatomic, strong) UIColor *selectionLayerColor; // default is R:52, G:181, B:229
@property (nonatomic, assign) enum HMSelectionIndicatorStyle selectionIndicatorStyle; // Default is HMSelectionIndicatorResizesToSectionWidth
@property (nonatomic, assign) enum HMSelectionIndicatorLocation selectionIndicatorLocation; // Default is HMSelectionIndicatorLocationUpr
@property (nonatomic, assign) enum HMSelectionIndicatorSectionType selectionIndicatorSectionType;

@property (nonatomic, assign) NSInteger selectedSegmentIndex;
@property (nonatomic, readwrite) CGFloat height; // default is 32.0
@property (nonatomic, readwrite) CGFloat selectionIndicatorHeight; // default is 5.0
@property (nonatomic, readwrite) UIEdgeInsets segmentEdgeInset; // default is UIEdgeInsetsMake(0, 5, 0, 5)

- (id)initWithSectionTitles:(NSArray *)sectiontitles;
- (id)initWithSectionIcons:(NSArray*)sectionIcons highlight:(NSArray*)sectionHighlightIcons;
- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setIndexChangeBlock:(IndexChangeBlock)indexChangeBlock;

@end
