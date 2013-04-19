//
//  HMSegmentedControlContainerView.m
//  HMSegmentedControlExample
//
//  Created by Hlung on 4/19/13.
//  Copyright (c) 2013 Hesham Abd-Elmegid. All rights reserved.
//

#import "HMSegmentedControlContainerView.h"
#import "HMSegmentedControl.h"

@implementation HMSegmentedControlContainerView

- (id)initWithHMSegmentedControl:(HMSegmentedControl*)control
{
    self = [super initWithFrame:control.frame];
    if (self) {
        // Initialization code
        self.segmentedControl = control;
        self.segmentedControl.frame = control.bounds;
        self.scrollView = [[UIScrollView alloc] initWithFrame:control.bounds];
        [self.scrollView addSubview:self.segmentedControl];
        [self addSubview:self.scrollView];
        [self setDefaultValues];
        
        // scroll to changed index
        [self.segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];

        // scroll to initial index
        [self layoutSubviews];
        [self.segmentedControl addObserver:self
                                forKeyPath:@"selectedSegmentIndex"
                                   options:NSKeyValueObservingOptionInitial
                                   context:nil];
    }
    return self;
}

- (void)setDefaultValues {
    self.minimumSegmentWidth = 100.0f;
    self.backgroundColor = self.segmentedControl.backgroundColor;
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.scrollEnabled = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if ([self segmentedControlNeedsScrolling]) {
        self.scrollView.scrollEnabled = YES;
        [self adjustViewToSize:CGSizeMake([self totalSegmentedControlWidth], self.frame.size.height)];
        [self.scrollView flashScrollIndicators];
    }
    else {
		self.scrollView.scrollEnabled = NO;
        [self adjustViewToSize:self.frame.size];
	}
}

- (void)observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void*)context {
    if (object == self.segmentedControl && [keyPath isEqual:@"selectedSegmentIndex"]) {
        [self scrollToSelectedSegmentIndexAnimated:NO];
    }
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    [self scrollToSelectedSegmentIndexAnimated:YES];
}

- (void)scrollToSelectedSegmentIndexAnimated:(BOOL)animated {
    [self scrollToSegmentIndex:self.segmentedControl.selectedSegmentIndex animated:animated];
}
- (void)scrollToSegmentIndex:(int)index animated:(BOOL)animated {
    CGRect rect = [self rectForSegmentIndex:index];
    [self.scrollView scrollRectToVisible:rect animated:animated];
}

- (CGRect)rectForSegmentIndex:(int)index {
    return CGRectMake(self.minimumSegmentWidth*index, 0, self.minimumSegmentWidth, self.frame.size.height);
}

- (void)adjustViewToSize:(CGSize)size {
    self.scrollView.contentSize = size;
    self.segmentedControl.frame = CGRectMake(0, 0, size.width, size.height);
}

- (CGFloat)totalSegmentedControlWidth {
    return self.segmentedControl.sectionTitles.count * self.minimumSegmentWidth;
}

- (BOOL)segmentedControlNeedsScrolling {
    if ([self totalSegmentedControlWidth] > self.frame.size.width) {
        return YES;
    }
    return NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
