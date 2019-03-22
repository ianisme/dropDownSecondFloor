//
//  UIScrollView+FixXcodeNine.m
//  ZiroomerProject
//
//  Created by ian on 2017/10/16.
//  Copyright © 2017年 www.ziroom.com. All rights reserved.
//

#import "UIScrollView+FixXcodeNine.h"
#if TARGET_IPHONE_SIMULATOR
#import <objc/NSObjCRuntime.h>
//#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif
@implementation UIScrollView (FixXcodeNine)

+ (void)load
{
    Method myMethod = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method newMyMethod = class_getInstanceMethod([self class], @selector(zrScrollViewInitWithFrame:));
    method_exchangeImplementations(myMethod, newMyMethod);
}

- (instancetype)zrScrollViewInitWithFrame:(CGRect)frame
{
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)){
        UIScrollView *scrollView = [self zrScrollViewInitWithFrame:frame];
        
        if ([scrollView isKindOfClass:NSClassFromString(@"WKScrollView")]) {
            return scrollView;
        }
        
        // 不让系统调整布局
        if ([scrollView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        return scrollView;
    } else {
        return [self zrScrollViewInitWithFrame:frame];
    }
#else
    return [self zrScrollViewInitWithFrame:frame];
#endif
}

@end
