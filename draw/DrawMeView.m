//
//  DrawMeView.m
//  draw
//
//  Created by Jason Gregori on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DrawMeView.h"

@implementation DrawMeView

- (id)initWithFrame:(CGRect)frame
{
    // **** set size to the size you want, we won't change it later
    frame.size = CGSizeMake(76, 58);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = NO;
    }
    return self;
}

- (UIColor *)colorToPutBehindThisViewForContrast {
    return [UIColor darkGrayColor];
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    // one pixel for transparency
    // two pixels for white
    [[UIColor whiteColor] set];
    UIBezierPath *p = [UIBezierPath bezierPathWithRect:CGRectMake(2, 2, 72, 54)];
    p.lineWidth = 2;
    [p stroke];
}

@end
