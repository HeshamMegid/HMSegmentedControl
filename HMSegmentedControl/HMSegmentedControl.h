//
//  HMSegmentedControl.h
//  HMSegmentedControl
//
//  Created by Hesham Abd-Elmegid on 23/12/12.
//  Copyright (c) 2012 Hesham Abd-Elmegid. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMSegmentedControl;

typedef void (^IndexChangeBlock)(NSInteger index);
typedef NSAttributedString *(^HMTitleFormatterBlock)(HMSegmentedControl *segmentedControl, NSString *title, BOOL selected);

typedef enum {
    HMSegmentedControlSelectionStyleTextWidthStripe, // Indicator width will only be as big as the text width
    HMSegmentedControlSelectionStyleFullWidthStripe, // Indicator width will fill the whole segment
    HMSegmentedControlSelectionStyleBox, // A rectangle that covers the whole segment
    HMSegmentedControlSelectionStyleArrow // An arrow in the middle of the segment pointing up or down depending on `HMSegmentedControlSelectionIndicatorLocation`
} HMSegmentedControlSelectionStyle;

typedef enum {
    HMSegmentedControlSelectionIndicatorLocationUp,
    HMSegmentedControlSelectionIndicatorLocationDown,
	HMSegmentedControlSelectionIndicatorLocationNone // No selection indicator
} HMSegmentedControlSelectionIndicatorLocation;

typedef enum {
    HMSegmentedControlSegmentWidthStyleFixed, // Segment width is fixed
    HMSegmentedControlSegmentWidthStyleDynamic, // Segment width will only be as big as the text width (including inset)
} HMSegmentedControlSegmentWidthStyle;

enum {
    HMSegmentedControlNoSegment = -1   // Segment index for no selected segment
};

typedef enum {
    HMSegmentedControlTypeText,
    HMSegmentedControlTypeImages,
	HMSegmentedControlTypeTextImages
} HMSegmentedControlType;

@interface HMSegmentedControl : UIControl

/* 
 * Array of `NSString` objects
 */
@property (nonatomic, strong) NSArray *sectionTitles;
@property (nonatomic, strong) NSArray *sectionImages;
@property (nonatomic, strong) NSArray *sectionSelectedImages;

/*
 Provide a block to be executed when selected index is changed.
 
 Alternativly, you could use `addTarget:action:forControlEvents:`
 */
@property (nonatomic, copy) IndexChangeBlock indexChangeBlock;

/*
 * This block is used to apply custom text styling to titles when set.
 *
 * When this block is provided, no additional styling is applied to the `NSAttributedString` object returned from this block.
 */
@property (nonatomic, copy) HMTitleFormatterBlock titleFormatter;

/*
 Text attributes to apply to item title texts.
 
 The eventual text attributes applied to titles are comprised of this dictionary and the values in `font` and
 `textColor` properties. The attributes specified in this dictionary (if present) take precedence over `font` and 
 `textColor` properties.
 */
@property (nonatomic, strong) NSDictionary *titleTextAttributes;

/*
 Text attributes to apply to selected item title text.
 
 The eventual text attributes applied to selected title are defined by eventual title text attributes overriden by
 `selectedTextColor` property value, overriden by the values in this dictionary, so that you only need to specify what
 sets the selected title apart from a title in the default state.
 */
@property (nonatomic, strong) NSDictionary *selectedTitleTextAttributes;

/*
 Font for segments names when segmented control type is `HMSegmentedControlTypeText`
 
 Default is [UIFont fontWithName:@"STHeitiSC-Light" size:18.0f]
 */
@property (nonatomic, strong) UIFont *font;

/*
 Text color for segments names when segmented control type is `HMSegmentedControlTypeText`
 
 Default is [UIColor blackColor]
 */
@property (nonatomic, strong) UIColor *textColor;

/* 
 Text color for selected segment name when segmented control type is `HMSegmentedControlTypeText`
 
 Default is [UIColor blackColor]
 */
@property (nonatomic, strong) UIColor *selectedTextColor;

/*
 Segmented control background color.
 
 Default is [UIColor whiteColor]
 */
@property (nonatomic, strong) UIColor *backgroundColor;

/*
 Color for the selection indicator stripe/box
 
 Default is R:52, G:181, B:229
 */
@property (nonatomic, strong) UIColor *selectionIndicatorColor;

/*
 Opacity for the seletion inficator box.
 
 Default is 0.2
 */
@property (nonatomic) CGFloat selectionIndicatorBoxOpacity;

/*
 Specifies the style of the control
 
 Default is `HMSegmentedControlTypeText`
 */
@property (nonatomic, assign) HMSegmentedControlType type;

/*
 Specifies the style of the selection indicator.
 
 Default is `HMSegmentedControlSelectionStyleTextWidthStripe`
 */
@property (nonatomic, assign) HMSegmentedControlSelectionStyle selectionStyle;

/*
 Specifies the style of the segment's width.
 
 Default is `HMSegmentedControlSegmentWidthStyleFixed`
 */
@property (nonatomic, assign) HMSegmentedControlSegmentWidthStyle segmentWidthStyle;

/*
 Specifies the location of the selection indicator.
 
 Default is `HMSegmentedControlSelectionIndicatorLocationUp`
 */
@property (nonatomic, assign) HMSegmentedControlSelectionIndicatorLocation selectionIndicatorLocation;

/*
 Default is NO. Set to YES to allow for adding more tabs than the screen width could fit.
 
 When set to YES, segment width will be automatically set to the width of the biggest segment's text or image,
 otherwise it will be equal to the width of the control's frame divided by the number of segments.
 
 As of v 1.4 this is no longer needed. The control will manage scrolling automatically based on tabs sizes.
 */
@property(nonatomic, getter = isScrollEnabled) BOOL scrollEnabled DEPRECATED_ATTRIBUTE;

/*
 Default is YES. Set to NO to deny scrolling by dragging the scrollView by the user.
 */
@property(nonatomic, getter = isUserDraggable) BOOL userDraggable;

/*
 Default is YES. Set to NO to deny any touch events by the user.
 */
@property(nonatomic, getter = isTouchEnabled) BOOL touchEnabled;


/*
 Index of the currently selected segment.
 */
@property (nonatomic, assign) NSInteger selectedSegmentIndex;

/*
 Height of the selection indicator. Only effective when `HMSegmentedControlSelectionStyle` is either `HMSegmentedControlSelectionStyleTextWidthStripe` or `HMSegmentedControlSelectionStyleFullWidthStripe`.
 
 Default is 5.0
 */
@property (nonatomic, readwrite) CGFloat selectionIndicatorHeight;

/*
 Edge insets for the selection indicator.
 NOTE: This does not affect the bounding box of HMSegmentedControlSelectionStyleBox
 
 When HMSegmentedControlSelectionIndicatorLocationUp is selected, bottom edge insets are not used
 
 When HMSegmentedControlSelectionIndicatorLocationDown is selected, top edge insets are not used
 
 Defaults are top: 0.0f
             left: 0.0f
           bottom: 0.0f
            right: 0.0f
 */
@property (nonatomic, readwrite) UIEdgeInsets selectionIndicatorEdgeInsets;

/*
 Inset left and right edges of segments. Only effective when `scrollEnabled` is set to YES.
 
 Default is UIEdgeInsetsMake(0, 5, 0, 5)
 */
@property (nonatomic, readwrite) UIEdgeInsets segmentEdgeInset;

/*
 Default is YES. Set to NO to disable animation during user selection.
 */
@property (nonatomic) BOOL shouldAnimateUserSelection;

- (id)initWithSectionTitles:(NSArray *)sectiontitles;
- (id)initWithSectionImages:(NSArray *)sectionImages sectionSelectedImages:(NSArray *)sectionSelectedImages;
- (instancetype)initWithSectionImages:(NSArray *)sectionImages sectionSelectedImages:(NSArray *)sectionSelectedImages titlesForSections:(NSArray *)sectiontitles;
- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setIndexChangeBlock:(IndexChangeBlock)indexChangeBlock;

@end
