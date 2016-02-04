//
//  AppDelegateMethods.h
//  Dongal
//
//  Created by 한승진 on 2016. 2. 3..
//  Copyright © 2016년 com.twentyApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AppDelegateMethods : NSObject

+ (NSArray *)initTabbarViewControllerArray;
+ (void)initTabbarViewControllerTitle:(UITabBar *)tabbar;
+ (void)initTabbarViewControllerIcons:(UITabBar *)tabbar;

+ (BOOL)checkLoginSession;
@end
