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

@property (nonatomic, strong) CALayer *selectionIndicatorStripLayer;
@property (nonatomic, strong) CALayer *selectionIndicatorBoxLayer;
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
        self.type = HMSegmentedControlTypeText;
    }
    
    return self;
}

- (id)initWithSectionImages:(NSArray*)sectionImages sectionSelectedImages:(NSArray*)sectionSelectedImages
{
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        self.sectionImages = sectionImages;
        self.sectionSelectedImages = sectionSelectedImages;
        [self setDefaults];
        self.type = HMSegmentedControlTypeImages;
    }
    
    return self;
}

- (void)setDefaults {
    self.font = [UIFont fontWithName:@"STHeitiSC-Light" size:18.0f];
    self.textColor = [UIColor blackColor];
    self.selectedTextColor = [UIColor blackColor];
    self.backgroundColor = [UIColor whiteColor];
    self.opaque = NO;
    self.selectionIndicatorColor = [UIColor colorWithRed:52.0f/255.0f green:181.0f/255.0f blue:229.0f/255.0f alpha:1.0f];
    
    self.selectedSegmentIndex = 0;
    self.segmentEdgeInset = UIEdgeInsetsMake(0, 5, 0, 5);
    self.height = 32.0f;
    self.selectionIndicatorHeight = 5.0f;
    self.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStrip;
    self.selectionLocation = HMSegmentedControlSelectionLocationUp;
    self.type = HMSegmentedControlTypeText;
    
    self.selectionIndicatorStripLayer = [CALayer layer];
    
    self.selectionIndicatorBoxLayer = [CALayer layer];
    self.selectionIndicatorBoxLayer.opacity = 0.2;
    self.selectionIndicatorBoxLayer.borderWidth = 1.0f;
}

#pragma mark - Drawing

- (void)drawRect:(CGRect)rect {    
    [self.backgroundColor setFill];
    UIRectFill([self bounds]);
    
    self.selectionIndicatorStripLayer.backgroundColor = self.selectionIndicatorColor.CGColor;
    self.selectionIndicatorBoxLayer.backgroundColor = self.selectionIndicatorColor.CGColor;
    self.selectionIndicatorBoxLayer.borderColor = self.selectionIndicatorColor.CGColor;
    
    // Remove all sublayers to avoid drawing images over existing ones
    self.layer.sublayers = nil;
    
    if (self.type == HMSegmentedControlTypeText) {
        [self.sectionTitles enumerateObjectsUsingBlock:^(id titleString, NSUInteger idx, BOOL *stop) {
            CGFloat stringHeight = roundf([titleString sizeWithFont:self.font].height);
            CGFloat y = roundf(((self.height - self.selectionIndicatorHeight) / 2) + (self.selectionIndicatorHeight - stringHeight / 2));
            CGRect rect = CGRectMake(self.segmentWidth * idx, y, self.segmentWidth, stringHeight);

            CATextLayer *titleLayer = [CATextLayer layer];
            // Note: text inside the CATextLayer will appear blurry unless the rect values around rounded
            titleLayer.frame = rect;
            [titleLayer setFont:(__bridge CFTypeRef)(self.font.fontName)];
            [titleLayer setFontSize:self.font.pointSize];
            [titleLayer setAlignmentMode:kCAAlignmentCenter];
            [titleLayer setString:titleString];
            
            if (self.selectedSegmentIndex == idx)
                [titleLayer setForegroundColor:self.selectedTextColor.CGColor];
            else
                [titleLayer setForegroundColor:self.textColor.CGColor];
            
            [titleLayer setContentsScale:[[UIScreen mainScreen] scale]];
            [self.layer addSublayer:titleLayer];
        }];
    } else if (self.type == HMSegmentedControlTypeImages) {
        [self.sectionImages enumerateObjectsUsingBlock:^(id iconImage, NSUInteger idx, BOOL *stop) {
            UIImage *icon = iconImage;
            CGFloat imageWidth = icon.size.width;
            CGFloat imageHeight = icon.size.height;
            CGFloat y = ((self.height - self.selectionIndicatorHeight) / 2) + (self.selectionIndicatorHeight - imageHeight / 2);
            CGFloat x = self.segmentWidth * idx + (self.segmentWidth - imageWidth)/2.0f;
            CGRect rect = CGRectMake(x, y, imageWidth, imageHeight);
            
            CALayer *imageLayer = [CALayer layer];
            [imageLayer setFrame:rect];
                        
            if (self.selectedSegmentIndex == idx) {
                if (self.sectionSelectedImages) {
                    UIImage *highlightIcon = [self.sectionSelectedImages objectAtIndex:idx];
                    imageLayer.contents = (id)highlightIcon.CGImage;
                } else {
                    imageLayer.contents = (id)icon.CGImage;
                }
            } else {
                imageLayer.contents = (id)icon.CGImage;
            }
            
            [self.layer addSublayer:imageLayer];
        }];
    }
    
    // Add the selection indicators
    if (self.selectedSegmentIndex != HMSegmentedControlNoSegment && !self.selectionIndicatorStripLayer.superlayer) {
        self.selectionIndicatorStripLayer.frame = [self frameForSelectionIndicator];
        [self.layer addSublayer:self.selectionIndicatorStripLayer];
        
        if (self.selectionStyle == HMSegmentedControlSelectionStyleBox && !self.selectionIndicatorBoxLayer.superlayer) {
            self.selectionIndicatorBoxLayer.frame = [self frameForFillerSelectionIndicator];
            [self.layer insertSublayer:self.selectionIndicatorBoxLayer atIndex:0];
        }
    }
}

- (CGRect)frameForSelectionIndicator {
    CGFloat indicatorYOffset = 0.0f;
        
    if (self.selectionLocation == HMSegmentedControlSelectionLocationDown)
        indicatorYOffset = self.bounds.size.height - self.selectionIndicatorHeight;
    
    CGFloat sectionWidth = 0.0f;

    if (self.type == HMSegmentedControlTypeText) {
        CGFloat stringWidth = [[self.sectionTitles objectAtIndex:self.selectedSegmentIndex] sizeWithFont:self.font].width;
        sectionWidth = stringWidth;
    } else if (self.type == HMSegmentedControlTypeImages) {
        UIImage *sectionImage = [self.sectionImages objectAtIndex:self.selectedSegmentIndex];
        CGFloat imageWidth = sectionImage.size.width;
        sectionWidth = imageWidth;
    }
    
    if (self.selectionStyle == HMSegmentedControlSelectionStyleTextWidthStrip && sectionWidth <= self.segmentWidth) {
        CGFloat widthToEndOfSelectedSegment = (self.segmentWidth * self.selectedSegmentIndex) + self.segmentWidth;
        CGFloat widthToStartOfSelectedIndex = (self.segmentWidth * self.selectedSegmentIndex);
        
        CGFloat x = ((widthToEndOfSelectedSegment - widthToStartOfSelectedIndex) / 2) + (widthToStartOfSelectedIndex - sectionWidth / 2);
        return CGRectMake(x, indicatorYOffset, sectionWidth, self.selectionIndicatorHeight);
    } else {
        return CGRectMake(self.segmentWidth * self.selectedSegmentIndex, indicatorYOffset, self.segmentWidth, self.selectionIndicatorHeight);
    }
}

- (CGRect)frameForFillerSelectionIndicator {
    return CGRectMake(self.segmentWidth * self.selectedSegmentIndex, 0, self.segmentWidth, self.height);
}

- (void)updateSegmentsRects {
    // If there's no frame set, calculate the width of the control based on the number of segments and their size
    if (CGRectIsEmpty(self.frame)) {
        self.segmentWidth = 0;
        
        if (self.type == HMSegmentedControlTypeText) {
            for (NSString *titleString in self.sectionTitles) {
                CGFloat stringWidth = [titleString sizeWithFont:self.font].width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
                self.segmentWidth = MAX(stringWidth, self.segmentWidth);
            }
            self.bounds = CGRectMake(0, 0, self.segmentWidth * self.sectionTitles.count, self.height);
        } else if (self.type == HMSegmentedControlTypeImages) {
            for (UIImage *sectionImage in self.sectionImages) {
                CGFloat imageWidth = sectionImage.size.width + self.segmentEdgeInset.left + self.segmentEdgeInset.right;
                self.segmentWidth = MAX(imageWidth, self.segmentWidth);
            }
            self.bounds = CGRectMake(0, 0, self.segmentWidth * self.sectionImages.count, self.height);
        }
    } else {
        if (self.type == HMSegmentedControlTypeText)
            self.segmentWidth = self.frame.size.width / self.sectionTitles.count;
        else if (self.type == HMSegmentedControlTypeImages)
            self.segmentWidth = self.frame.size.width / self.sectionImages.count;
        
        self.segmentWidth = roundf(self.segmentWidth);
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
        [self.selectionIndicatorStripLayer removeFromSuperlayer];
        [self.selectionIndicatorBoxLayer removeFromSuperlayer];
    } else {
        if (animated) {
            
            /* 
             If the selected segment layer is not added to the super layer, that means no
             index is currently selected, so add the layer then move it to the new 
             segment index without animating.
             */
            if ([self.selectionIndicatorStripLayer superlayer] == nil) {
                [self.layer addSublayer:self.selectionIndicatorStripLayer];
                
                if (self.selectionStyle == HMSegmentedControlSelectionStyleBox && [self.selectionIndicatorBoxLayer superlayer] == nil)
                    [self.layer insertSublayer:self.selectionIndicatorBoxLayer atIndex:0];
                
                [self setSelectedSegmentIndex:index animated:NO notify:YES];
                return;
            }
            
            if (notify)
                [self notifyForSegmentChangeToIndex:index];
            
            // Restore CALayer animations
            self.selectionIndicatorStripLayer.actions = nil;
            self.selectionIndicatorBoxLayer.actions = nil;
            
            // Animate to new position
            [CATransaction begin];
            [CATransaction setAnimationDuration:0.15f];
            [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
            self.selectionIndicatorStripLayer.frame = [self frameForSelectionIndicator];
            self.selectionIndicatorBoxLayer.frame = [self frameForFillerSelectionIndicator];
            [CATransaction commit];
        } else {
            // Disable CALayer animations
            NSMutableDictionary *newActions = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"position", [NSNull null], @"bounds", nil];
            self.selectionIndicatorStripLayer.actions = newActions;
            self.selectionIndicatorStripLayer.frame = [self frameForSelectionIndicator];
            
            self.selectionIndicatorBoxLayer.actions = newActions;
            self.selectionIndicatorBoxLayer.frame = [self frameForFillerSelectionIndicator];
            
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
    
    if (self.type == HMSegmentedControlTypeText && self.sectionTitles)
        [self updateSegmentsRects];
    else if(self.type == HMSegmentedControlTypeImages && self.sectionImages)
        [self updateSegmentsRects];
    
    [self setNeedsDisplay];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    
    if (self.type == HMSegmentedControlTypeText && self.sectionTitles)
        [self updateSegmentsRects];
    else if(self.type == HMSegmentedControlTypeImages && self.sectionImages)
        [self updateSegmentsRects];
    
    [self setNeedsDisplay];
}

@end
