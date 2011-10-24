//
//  ViewController.m
//  draw
//
//  Created by Jason Gregori on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "DrawMeView.h"

@implementation ViewController

#pragma mark - View lifecycle

- (void)loadView {
    [super loadView];
    
    DrawMeView *v = [DrawMeView new];
    self.view.backgroundColor = v.colorToPutBehindThisViewForContrast;
    
    CGSize size = v.frame.size;
    v.frame = (CGRect) { CGPointMake(floor((self.view.bounds.size.width - size.width)/2.0), floor((self.view.bounds.size.height - size.height)/2.0)), size };
    [self.view addSubview:v];
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    b.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin
                          | UIViewAutoresizingFlexibleTopMargin
                          | UIViewAutoresizingFlexibleRightMargin);
    [b setTitle:@"Save" forState:UIControlStateNormal];
    [b sizeToFit];
    size = b.bounds.size;
    b.frame = (CGRect) { CGPointMake(floor((self.view.bounds.size.width - size.width)/2.0), self.view.bounds.size.height - size.height - 20), size };
    [self.view addSubview:b];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
