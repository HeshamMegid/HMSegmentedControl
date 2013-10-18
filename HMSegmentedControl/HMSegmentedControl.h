//
//  HMSegmentedControl.h
//  HMSegmentedControl
//
//  Created by Hesham Abd-Elmegid on 23/12/12.
//  Copyright (c) 2012 Hesham Abd-Elmegid. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^IndexChangeBlock)(NSInteger index);

typedef enum {
    HMSegmentedControlTypeText,
    HMSegmentedControlTypeImages
} HMSegmentedControlType;

typedef enum {
    HMSegmentedControlSelectionStyleTextWidthStripe, // Indicator width will only be as big as the text width
    HMSegmentedControlSelectionStyleFullWidthStripe, // Indicator width will fill the whole segment
    HMSegmentedControlSelectionStyleBox
} HMSegmentedControlSelectionStyle;

typedef enum {
    HMSegmentedControlSelectionIndicatorLocationUp,
    HMSegmentedControlSelectionIndicatorLocationDown
} HMSegmentedControlSelectionIndicatorLocation;

enum {
    HMSegmentedControlNoSegment = -1   // segment index for no selected segment
};

@interface HMSegmentedControl : UIControl

@property (nonatomic, strong) NSArray *sectionTitles;
@property (nonatomic, strong) NSArray *sectionImages;
@property (nonatomic, strong) NSArray *sectionSelectedImages;

@property (nonatomic, copy) IndexChangeBlock indexChangeBlock; // you can also use addTarget:action:forControlEvents:

@property (nonatomic, strong) UIFont *font; // default is [UIFont fontWithName:@"STHeitiSC-Light" size:18.0f]
@property (nonatomic, strong) UIColor *textColor; // default is [UIColor blackColor]
@property (nonatomic, strong) UIColor *selectedTextColor; // default is [UIColor blackColor]
@property (nonatomic, strong) UIColor *backgroundColor; // default is [UIColor whiteColor]
@property (nonatomic, strong) UIColor *selectionIndicatorColor; // default is R:52, G:181, B:229

/*
 Specifies the style of the selection indicator.
 
 Default is `HMSegmentedControlSelectionStyleTextWidthStripe`
 */
@property (nonatomic, assign) HMSegmentedControlSelectionStyle selectionStyle;

/*
 Specifies the location of the selection indicator.
 
 Default is `HMSegmentedControlSelectionIndicatorLocationUp`
 */
@property (nonatomic, assign) HMSegmentedControlSelectionIndicatorLocation selectionIndicatorLocation;
@property (nonatomic, assign) HMSegmentedControlType type;

/*
 Default is NO. Set to YES to allow for adding more tabs than the screen width could fit.
 
 When set to YES, segment width will be automatically set to the width of the biggest segment's text or image,
 otherwise it will be equal to the width of the control's frame divided by the number of segments.
 */
@property(nonatomic, getter = isScrollEnabled) BOOL scrollEnabled;

@property (nonatomic, assign) NSInteger selectedSegmentIndex;
@property (nonatomic, readwrite) CGFloat selectionIndicatorHeight; // default is 5.0
@property (nonatomic, readwrite) UIEdgeInsets segmentEdgeInset; // default is UIEdgeInsetsMake(0, 5, 0, 5)

- (id)initWithSectionTitles:(NSArray *)sectiontitles;
- (id)initWithSectionImages:(NSArray *)sectionImages sectionSelectedImages:(NSArray *)sectionSelectedImages;
- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setIndexChangeBlock:(IndexChangeBlock)indexChangeBlock;

@end
