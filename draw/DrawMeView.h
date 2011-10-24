//
//  DrawMeView.h
//  draw
//
//  Created by Jason Gregori on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 
 Whatever you put in this view will be drawn on the screen and saved when you hit save.
 You can either draw using DrawRect, add subviews, or both. up to you.
 
 */

@interface DrawMeView : UIView
@property (nonatomic, readonly) UIColor *colorToPutBehindThisViewForContrast;
@end
