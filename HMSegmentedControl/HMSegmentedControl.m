//
//  HMSegmentedControl.m
//  HMSegmentedControl
//
//  Created by Hesham Abd-Elmegid on 23/12/12.
//  Copyright (c) 2012 Hesham Abd-Elmegid. All rights reserved.
//

#import "HMSegmentedControl.h"
#import <QuartzCore/QuartzCore.h>

@interface HMSegmentedControl ()

@property (nonatomic, strong) CALayer *selectedSegmentLayer;
@property (nonatomic, readwrite) CGFloat segmentWidth;

@end

@implementation HMSegmentedControl

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setDefaults];
    }
    
    return self;
}

- (id)initWithSectionTitles:(NSArray *)sectiontitles {
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        self.sectionTitles = sectiontitles;
        [self setDefaults];
        self.selectionIndicatorSectionType = HMSelectionIndicatorSectionTitles;
    }
    
    return self;
}

- (id)initWithSectionIcons:(NSArray*)sectionIcons highlight:(NSArray*)sectionHighlightIcons
{
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        self.sectionIcons = sectionIcons;
        self.sectionHighlightIcons = sectionHighlightIcons;
        [self setDefaults];
        self.selectionIndicatorSectionType = HMSelectionIndicatorSectionIcons;
    }
    
    return self;
}

- (void)setDefaults {
    self.font = [UIFont fontWithName:@"STHeitiSC-Light" size:18.0f];
    self.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor whiteColor];
    self.opaque = NO;
    self.selectionIndicatorColor = [UIColor colorWithRed:52.0f/255.0f green:181.0f/255.0f blue:229.0f/255.0f alpha:1.0f];
    
    self.selectedSegmentIndex = 0;
    self.segmentEdgeInset = UIEdgeInsetsMake(0, 5, 0, 5);
    self.height = 32.0f;
    self.selectionIndicatorHeight = 5.0f;
    self.selectionIndicatorStyle = HMSelectionIndicatorResizesToSectionWidth;
    self.selectionIndicatorLocation = HMSelectionIndicatorLocationUp;
    self.selectionIndicatorSectionType = HMSelectionIndicatorSectionTitles;
    
    self.selectedSegmentLayer = [CALayer layer];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    // Below is a work in progress for a new style for the selected segment
    //    CALayer *selectedSegmentFillerLayer = [[CALayer alloc] init];
    //    selectedSegmentFillerLayer.frame = CGRectMake(self.segmentWidth * self.selectedIndex, 0.0, self.segmentWidth, self.frame.size.height);
    //    selectedSegmentFillerLayer.opacity = 0.2;
    //    selectedSegmentFillerLayer.borderWidth = 1.0f;
    //    selectedSegmentFillerLayer.backgroundColor = self.selectionIndicatorColor.CGColor;
    //    selectedSegmentFillerLayer.borderColor = self.selectionIndicatorColor.CGColor;
    //    [self.layer addSublayer:selectedSegmentFillerLayer];
    
    [self.backgroundColor setFill];
    UIRectFill([self bounds]);
    
    [self.textColor set];
    
    if(self.selectionIndicatorSectionType == HMSelectionIndicatorSectionTitles)
    {
        [self.sectionTitles enumerateObjectsUsingBlock:^(id titleString, NSUInteger idx, BOOL *stop) {
            CGFloat stringHeight = [titleString sizeWithFont:self.font].height;
            CGFloat y = ((self.height - self.selectionIndicatorHeight) / 2) + (self.selectionIndicatorHeight - stringHeight / 2);
            CGRect rect = CGRectMake(self.segmentWidth * idx, y, self.segmentWidth, stringHeight);
            
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 60000
            [titleString drawInRect:rect
                           withFont:self.font
                      lineBreakMode:UILineBreakModeClip
                          alignment:UITextAlignmentCenter];
#else
            [titleString drawInRect:rect
                           withFont:self.font
                      lineBreakMode:NSLineBreakByClipping
                          alignment:NSTextAlignmentCenter];
#endif
            
            self.selectedSegmentLayer.backgroundColor = self.selectionIndicatorColor.CGColor;
            
            if (self.selectedSegmentIndex != HMSegmentedControlNoSegment) {
                self.selectedSegmentLayer.frame = [self frameForSelectionIndicator];
                [self.layer addSublayer:self.selectedSegmentLayer];
            }
        }];
    }
    else if(self.selectionIndicatorSectionType == HMSelectionIndicatorSectionIcons)
    {
        [self.sectionIcons enumerateObjectsUsingBlock:^(id iconImage, NSUInteger idx, BOOL *stop) {
            UIImage* icon = iconImage;
            CGFloat imageWidth = icon.size.width;
            CGFloat imageHeight = icon.size.height;
            CGFloat y = ((self.height - self.selectionIndicatorHeight) / 2) + (self.selectionIndicatorHeight - imageHeight / 2);
            CGFloat x = self.segmentWidth * idx + (self.segmentWidth - imageWidth)/2.0f;
            CGRect rect = CGRectMake(x, y, imageWidth, imageHeight);
            
            if(self.selectedSegmentIndex == idx)
            {
                if(self.sectionHighlightIcons)
                {
                    UIImage* highlightIcon = [self.sectionHighlightIcons objectAtIndex:idx];
                    [highlightIcon drawInRect:rect];
                }
                else
                {
                    [icon drawInRect:rect];
                }
            }
            else
            {
                [icon drawInRect:rect];
            }
            
            self.selectedSegmentLayer.backgroundColor = self.selectionIndicatorColor.CGColor;
            
            if (self.selectedSegmentIndex != HMSegmentedControlNoSegment) {
                self.selectedSegmentLayer.frame = [self frameForSelectionIndicator];
                [self.layer addSublayer:self.selectedSegmentLayer];
            }
        }];
    }
}

- (CGRect)frameForSelectionIndicator {
    CGFloat indicatorOffY;
    if(self.selectionIndicatorLocation == HMSelectionIndicatorLocationUp)
    {
        indicatorOffY = 0.0;
    }
    else
    {
        CGRect bounds = self.bounds;
        indicatorOffY = bounds.size.height - self.selectionIndicatorHeight;
    }
    
    CGFloat sectionWidth = 0.0f;
    if(self.selectionIndicatorSectionType == HMSelectionIndicatorSectionTitles)
    {
        CGFloat stringWidth = [[self.sectionTitles objectAtIndex:self.selectedSegmentIndex] sizeWithFont:self.font].width;
        sectionWidth = stringWidth;
    }
    else if(self.selectionIndicatorSectionType == HMSelectionIndicatorSectionIcons)
    {
        UIImage* icon = [self.sectionIcons objectAtIndex:self.selectedSegmentIndex];
        CGFloat imageWidth = icon.size.width;
        sectionWidth = imageWidth;
    }
    
    if (self.selectionIndicatorStyle == HMSelectionIndicatorResizesToSectionWidth && sectionWidth <= self.segmentWidth) {
        CGFloat widthToEndOfSelectedSegment = (self.segmentWidth * self.selectedSegmentIndex) + self.segmentWidth;
        CGFloat widthToStartOfSelectedIndex = (self.segmentWidth * self.selectedSegmentIndex);
        
        CGFloat x = ((widthToEndOfSelectedSegment - widthToStartOfSelectedIndex) / 2) + (widthToStartOfSelectedIndex - sectionWidth / 2);
        return CGRectMake(x, indicatorOffY, sectionWidth, self.selectionIndicatorHeight);
    } else {
        return CGRectMake(self.segmentWidth * self.selectedSegmentIndex, indicatorOffY, self.segmentWidth, self.selectionIndicatorHeight);
    }
}

- (void)updateSegmentsRects {
    // If there's no frame set, calculate the width of the control based on the number of segments and their size
    if (CGRectIsEmpty(self.frame)) {
        self.segmentWidth = 0;
        
        if(self.selectionIndicatorSectionType == HMSelectionIndicatorSectionTitles)
        {
            for (NSString *titleString in self.sectionTitles) {
                CGFloat stringWidth = [titleString sizeWithFont:self.font].width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
                self.segmentWidth = MAX(stringWidth, self.segmentWidth);
            }
            self.bounds = CGRectMake(0, 0, self.segmentWidth * self.sectionTitles.count, self.height);
        }
        else if(self.selectionIndicatorSectionType == HMSelectionIndicatorSectionIcons)
        {
            for (UIImage *iconImage in self.sectionIcons) {
                CGFloat imageWidth = iconImage.size.width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
                self.segmentWidth = MAX(imageWidth, self.segmentWidth);
            }
            self.bounds = CGRectMake(0, 0, self.segmentWidth * self.sectionIcons.count, self.height);
        }
        
    } else {
        if(self.selectionIndicatorSectionType == HMSelectionIndicatorSectionTitles)
        {
            self.segmentWidth = self.frame.size.width / self.sectionTitles.count;
        }
        else if(self.selectionIndicatorSectionType == HMSelectionIndicatorSectionIcons)
        {
            self.segmentWidth = self.frame.size.width / self.sectionIcons.count;
        }
        self.height = self.frame.size.height;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    // Control is being removed
    if (newSuperview == nil)
        return;
    
    [self updateSegmentsRects];
}

#pragma mark - Touch

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    
    if (CGRectContainsPoint(self.bounds, touchLocation)) {
        NSInteger segment = touchLocation.x / self.segmentWidth;
        
        if (segment != self.selectedSegmentIndex) {
            [self setSelectedSegmentIndex:segment animated:YES notify:YES];
        }
    }
}

#pragma mark -

- (void)setSelectedSegmentIndex:(NSInteger)index {
    [self setSelectedSegmentIndex:index animated:NO notify:NO];
}

- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated {
    [self setSelectedSegmentIndex:index animated:animated notify:NO];
}

- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated notify:(BOOL)notify {
    _selectedSegmentIndex = index;
    [self setNeedsDisplay];
    
    if (index == HMSegmentedControlNoSegment) {
        [self.selectedSegmentLayer removeFromSuperlayer];
    } else {
        if (animated) {
            
            // If the selected segment layer is not added to the super layer, that means no
            // index is currently selected, so add the layer then move it to the new selected
            // segment index without animating.
            if ([self.selectedSegmentLayer superlayer] == nil) {
                [self.layer addSublayer:self.selectedSegmentLayer];
                [self setSelectedSegmentIndex:index animated:NO notify:YES];
                return;
            }
            
            // Restore CALayer animations
            self.selectedSegmentLayer.actions = nil;
            
            // Animate to new position
            [CATransaction begin];
            [CATransaction setAnimationDuration:0.15f];
            [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
            
            if (notify) {
                [CATransaction setCompletionBlock:^{
                    [self notifyForSegmentChangeToIndex:index];
                }];
            }
            
            self.selectedSegmentLayer.frame = [self frameForSelectionIndicator];
            [CATransaction commit];
        } else {
            // Disable CALayer animations
            NSMutableDictionary *newActions = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"position", [NSNull null], @"bounds", nil];
            self.selectedSegmentLayer.actions = newActions;
            self.selectedSegmentLayer.frame = [self frameForSelectionIndicator];
            
            if (notify)
                [self notifyForSegmentChangeToIndex:index];
        }
    }
}

- (void)notifyForSegmentChangeToIndex:(NSInteger)index {
    if (self.superview)
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    
    if (self.indexChangeBlock)
        self.indexChangeBlock(index);
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    if(self.selectionIndicatorSectionType == HMSelectionIndicatorSectionTitles)
    {
        if (self.sectionTitles)
            [self updateSegmentsRects];
    }
    else if(self.selectionIndicatorSectionType == HMSelectionIndicatorSectionIcons)
    {
        if (self.sectionIcons)
            [self updateSegmentsRects];
    }
    
    [self setNeedsDisplay];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    if(self.selectionIndicatorSectionType == HMSelectionIndicatorSectionTitles)
    {
        if (self.sectionTitles)
            [self updateSegmentsRects];
    }
    else if(self.selectionIndicatorSectionType == HMSelectionIndicatorSectionIcons)
    {
        if (self.sectionIcons)
            [self updateSegmentsRects];
    }
    
    [self setNeedsDisplay];
}

@end
