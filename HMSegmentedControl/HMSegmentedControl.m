//
//  HMSegmentedControl.m
//  HMSegmentedControlExample
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
    }
    
    return self;
}

- (void)setDefaults {
    self.font = [UIFont fontWithName:@"STHeitiSC-Light" size:18.0f];
    self.textColor = [UIColor blackColor];
    self.backgroundColor = [UIColor whiteColor];
    self.selectionIndicatorColor = [UIColor colorWithRed:52.0f/255.0f green:181.0f/255.0f blue:229.0f/255.0f alpha:1.0f];
    
    self.selectedIndex = 0;
    self.segmentEdgeInset = UIEdgeInsetsMake(0, 5, 0, 5);
    self.height = 32.0f;
    self.selectionIndicatorHeight = 5.0f;
    self.selectionIndicatorMode = HMSelectionIndicatorResizesToStringWidth;
    
    self.selectedSegmentLayer = [CALayer layer];
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    [self.backgroundColor set];
    UIRectFill([self bounds]);
    
    [self.textColor set];
    
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
        
        self.selectedSegmentLayer.frame = [self frameForSelectionIndicator];
        self.selectedSegmentLayer.backgroundColor = self.selectionIndicatorColor.CGColor;
        [self.layer addSublayer:self.selectedSegmentLayer];

    }];
}

- (CGRect)frameForSelectionIndicator {
    CGFloat stringWidth = [[self.sectionTitles objectAtIndex:self.selectedIndex] sizeWithFont:self.font].width;
    
    if (self.selectionIndicatorMode == HMSelectionIndicatorResizesToStringWidth) {
        CGFloat widthTillEndOfSelectedIndex = (self.segmentWidth * self.selectedIndex) + self.segmentWidth;
        CGFloat widthTillBeforeSelectedIndex = (self.segmentWidth * self.selectedIndex);
        
        CGFloat x = ((widthTillEndOfSelectedIndex - widthTillBeforeSelectedIndex) / 2) + (widthTillBeforeSelectedIndex - stringWidth / 2);
        return CGRectMake(x, 0.0, stringWidth, self.selectionIndicatorHeight);
    } else {
        return CGRectMake(self.segmentWidth * self.selectedIndex, 0.0, self.segmentWidth, self.selectionIndicatorHeight);
    }
}

- (void)updateSegmentsRects {
    // If there's no frame set, calculate the width of the control based on the number of segments and their size
    if (CGRectIsEmpty(self.frame)) {
        self.segmentWidth = 0;
        
        for (NSString *titleString in self.sectionTitles) {
            CGFloat stringWidth = [titleString sizeWithFont:self.font].width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
            self.segmentWidth = MAX(stringWidth, self.segmentWidth);
        }
        
        self.bounds = CGRectMake(0, 0, self.segmentWidth * self.sectionTitles.count, self.height);
    } else {
        self.segmentWidth = self.frame.size.width / self.sectionTitles.count;
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
        
        if (segment != self.selectedIndex) {
            [self setSelectedIndex:segment animated:YES];
        }
    }
}

#pragma mark -

- (void)setSelectedIndex:(NSInteger)index {
    [self setSelectedIndex:index animated:NO];
}

- (void)setSelectedIndex:(NSUInteger)index animated:(BOOL)animated {
    _selectedIndex = index;

    if (animated) {
        // Restore CALayer animations
        self.selectedSegmentLayer.actions = nil;
        
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.15f];
        [CATransaction setCompletionBlock:^{
            if (self.superview)
                [self sendActionsForControlEvents:UIControlEventValueChanged];
            
            if (self.indexChangeBlock)
                self.indexChangeBlock(index);
        }];
        self.selectedSegmentLayer.frame = [self frameForSelectionIndicator];
        [CATransaction commit];
    } else {
        // Disable CALayer animations
        NSMutableDictionary *newActions = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"position", [NSNull null], @"bounds", nil];
        self.selectedSegmentLayer.actions = newActions;
        
        self.selectedSegmentLayer.frame = [self frameForSelectionIndicator];
        
        if (self.superview)
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        
        if (self.indexChangeBlock)
            self.indexChangeBlock(index);

    }    
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    if (self.sectionTitles)
        [self updateSegmentsRects];
    
    [self setNeedsDisplay];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    if (self.sectionTitles)
        [self updateSegmentsRects];
    
    [self setNeedsDisplay];
}

@end
