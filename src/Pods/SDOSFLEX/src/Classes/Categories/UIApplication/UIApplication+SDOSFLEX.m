//
//  UIApplication+SDOSFLEX.h
//
//  Copyright © 2018 SDOS. All rights reserved.
//

#import "UIApplication+SDOSFLEX.h"
#import <FLEX/FLEX.h>

@implementation UIApplication (SDOSFLEX)

#pragma mark - Flex

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(event.type == UIEventSubtypeMotionShake)
    {
		[FLEXManager sharedManager].networkDebuggingEnabled = YES;
        [[FLEXManager sharedManager] showExplorer];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

@end
