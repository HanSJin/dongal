//
//  AppDelegateMethods.m
//  Dongal
//
//  Created by 한승진 on 2016. 2. 3..
//  Copyright © 2016년 com.twentyApps. All rights reserved.
//

#import "AppDelegateMethods.h"
#import "AppDelegate.h"

#import "Constants.h"
#import "Customs.h"
#import "SingletonData.h"
#import "ConnectionFactory.h"
#import "KeychainHelper.h"

@implementation AppDelegateMethods


+ (NSArray *)initTabbarViewControllerArray; {
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    UIViewController *mvc = (UIViewController *)appDelegate.window.rootViewController;
    
    UIViewController *noticeVC      = [mvc.storyboard instantiateViewControllerWithIdentifier:@"NoticeTabVC"];
    UIViewController *favoriteVC    = [mvc.storyboard instantiateViewControllerWithIdentifier:@"FavoriteVC"];
    UIViewController *searchVC      = [mvc.storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
    UIViewController *settingVC     = [mvc.storyboard instantiateViewControllerWithIdentifier:@"SettingVC"];
    
    UINavigationController *noticeNaviVC    = [[UINavigationController alloc] initWithRootViewController:noticeVC];
    UINavigationController *favoriteNaviVC  = [[UINavigationController alloc] initWithRootViewController:favoriteVC];
    UINavigationController *searchNaviVC    = [[UINavigationController alloc] initWithRootViewController:searchVC];
    UINavigationController *settingNaviVC   = [[UINavigationController alloc] initWithRootViewController:settingVC];
    
    NSArray *vcArray = [NSArray arrayWithObjects:noticeNaviVC,
                        favoriteNaviVC,
                        searchNaviVC,
                        settingNaviVC, nil];
    return vcArray;
}

+ (void)initTabbarViewControllerTitle:(UITabBar *)tabbar; {
    
}

+ (void)initTabbarViewControllerIcons:(UITabBar *)tabbar; {
    [[tabbar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"tap_icon_notice"]];
    [[tabbar.items objectAtIndex:1] setImage:[UIImage imageNamed:@"tap_icon_favorite"]];
    [[tabbar.items objectAtIndex:2] setImage:[UIImage imageNamed:@"tap_icon_search"]];
    [[tabbar.items objectAtIndex:3] setImage:[UIImage imageNamed:@"tap_icon_setting"]];
    
    for(UITabBarItem * tabBarItem in tabbar.items) {
        tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    }
}


+ (BOOL)checkLoginSession; {
    NSString *uuid = [NSString stringWithFormat:@"%s",[[KeychainHelper loadWithKey:@"uuid"] bytes]];
    SingletonData *sharedMan = [SingletonData sharedManager];
    
    if ([uuid isEqualToString:@"(null)"]) {
        CFUUIDRef uuidRef = CFUUIDCreate(NULL);
        CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
        CFRelease(uuidRef);
        uuid = [NSString stringWithString:(__bridge NSString *) uuidStringRef];
        CFRelease(uuidStringRef);

        NSData* data = [uuid dataUsingEncoding:NSUTF8StringEncoding];
        [KeychainHelper saveWithKey:@"uuid" andData:data];
    }
//    [KeychainHelper deleteWithKey:@"uuid"];
    
    sharedMan.UUID = uuid;
    NSString *postParams = [NSString stringWithFormat:@"uuid=%@", sharedMan.UUID];
    NSData *myData = [ConnectionFactory connType:@"POST" connAPI:CONNECT_POST_LOGIN connParam:postParams];
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
    
    
    return YES;
}

@end
