//
//  UITableView+FixXcodeNine.m
//  ZiroomerProject
//
//  Created by ian on 2017/10/16.
//  Copyright © 2017年 www.ziroom.com. All rights reserved.
//

#import "UITableView+FixXcodeNine.h"
#if TARGET_IPHONE_SIMULATOR
#import <objc/NSObjCRuntime.h>
//#import <objc/objc-runtime.h>
#else
#import <objc/runtime.h>
#import <objc/message.h>
#endif
@implementation UITableView (FixXcodeNine)

+ (void)load
{
    Method myMethod = class_getInstanceMethod([self class], @selector(initWithFrame:style:));
    Method newMyMethod = class_getInstanceMethod([self class], @selector(zrInitWithFrame:style:));
    method_exchangeImplementations(myMethod, newMyMethod);
}

- (instancetype)zrInitWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)){
        UITableView *tableView = [self zrInitWithFrame:frame style:style];
        // 适配iOS11 关闭Self-Sizing
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        return tableView;
    } else {
        return [self zrInitWithFrame:frame style:style];
    }
#else
    return [self zrInitWithFrame:frame style:style];
#endif
}

@end
