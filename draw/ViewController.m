//
//  ViewController.m
//  draw
//
//  Created by Jason Gregori on 10/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "DrawMeView.h"

#import <QuartzCore/QuartzCore.h>
#import <pwd.h>

@interface ViewController ()
@property (nonatomic, weak) DrawMeView *__drawMeView;
@end

@implementation ViewController
@synthesize __drawMeView;

#pragma mark - View lifecycle

- (void)loadView {
    [super loadView];
    
    DrawMeView *v = [DrawMeView new];
    self.view.backgroundColor = v.colorToPutBehindThisViewForContrast;
    
    CGSize size = v.frame.size;
    v.frame = (CGRect) { CGPointMake(floor((self.view.bounds.size.width - size.width)/2.0), floor((self.view.bounds.size.height - size.height)/2.0)), size };
    self.__drawMeView = v;
    [self.view addSubview:v];
    
    UIButton *b = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    b.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin
                          | UIViewAutoresizingFlexibleTopMargin
                          | UIViewAutoresizingFlexibleRightMargin);
    [b addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [b setTitle:@"Save" forState:UIControlStateNormal];
    [b sizeToFit];
    size = b.bounds.size;
    b.frame = (CGRect) { CGPointMake(floor((self.view.bounds.size.width - size.width)/2.0), self.view.bounds.size.height - size.height - 20), size };
    [self.view addSubview:b];
}

- (void)save {
    NSFileManager *fm = [NSFileManager new];
    
    static NSString *saveFolder = nil;
    if (!saveFolder) {
        // get desktop
#if TARGET_IPHONE_SIMULATOR
        NSString *logname = [NSString stringWithCString:getenv("LOGNAME") encoding:NSUTF8StringEncoding];
        struct passwd *pw = getpwnam([logname UTF8String]);
        NSString *home = pw ? [NSString stringWithCString:pw->pw_dir encoding:NSUTF8StringEncoding] : [@"/Users" stringByAppendingPathComponent:logname];
        saveFolder = [NSString stringWithFormat:@"%@/Desktop", home];
#else
        saveFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
#endif
        if (![fm fileExistsAtPath:saveFolder])
        {
            [fm createDirectoryAtPath:saveFolder withIntermediateDirectories:NO attributes:nil error:NULL];
        }
    }
    
    // save image
    
    CGSize size = self.__drawMeView.bounds.size;
    
    // TODO: include the space for the shadow
//    if (self.__drawMeView.layer.shadowOpacity > 0) {
//        size.height += fabs(self.__drawMeView.layer.shadowOffset.height);
//        size.width += fabs(self.__drawMeView.layer.shadowOffset.width);
//    }
    
    // @1x
    UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
    [self.__drawMeView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSData *data = UIImagePNGRepresentation(image);
    
    NSString *imagePathComponent = @"DrawMe.png";
    int i = 0;
    while ([fm fileExistsAtPath:[saveFolder stringByAppendingPathComponent:imagePathComponent]]) {
        i++;
        imagePathComponent = [NSString stringWithFormat:@"DrawMe-%i.png", i];
    }
    
    [fm createFileAtPath:[saveFolder stringByAppendingPathComponent:imagePathComponent]
                contents:data
              attributes:nil];
    
    // @2x
    UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
    [self.__drawMeView.layer renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    data = UIImagePNGRepresentation(image);
    
    imagePathComponent = @"DrawMe@2x.png";
    i = 0;
    while ([fm fileExistsAtPath:[saveFolder stringByAppendingPathComponent:imagePathComponent]]) {
        i++;
        imagePathComponent = [NSString stringWithFormat:@"DrawMe-%i@2x.png", i];
    }
    
    [fm createFileAtPath:[saveFolder stringByAppendingPathComponent:imagePathComponent]
                contents:data
              attributes:nil];
}

@end
