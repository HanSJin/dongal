//
//  AppDelegate.m
//  Dongal
//
//  Created by 한승진 on 2016. 2. 3..
//  Copyright © 2016년 com.twentyApps. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegateMethods.h"
#import "KeychainHelper.h"
#import "SingletonData.h"

#import "Constants.h"
#import "ConnectionFactory.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // APNS에 디바이스를 등록한다.
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    application.applicationIconBadgeNumber = 0;
    
    
    
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [AppDelegateMethods initTabbarViewControllerArray];
    
    // Tab bar Customize
    self.tabBarController.tabBar.barTintColor = BLACK_COLOR; // color
    self.tabBarController.tabBar.tintColor = DONGGUK_COLOR;  // UIColor
    [self.tabBarController.tabBar setTranslucent:NO];
    
    // init title, icon of Tabbar
    [AppDelegateMethods initTabbarViewControllerIcons:self.tabBarController.tabBar];
    [AppDelegateMethods initTabbarViewControllerTitle:self.tabBarController.tabBar];
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}


// 성공시
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"[App Delegate Call] : didRegisterForRemoteNotificationsWithDeviceToken");
    // DATA -> trimSTR
    const unsigned *tokenBytes = [deviceToken bytes];
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    NSLog(@"push token : %@", hexToken);
    
    // trimSTR -> DATA
    NSData* hexTokenData = [hexToken dataUsingEncoding:NSUTF8StringEncoding];
    
    // 푸시 토큰 저장 - 키체인
    [KeychainHelper saveWithKey:@"push_token_dongal" andData:hexTokenData];
    
    
    
    SingletonData *sharedMan = [SingletonData sharedManager];
    NSString *postParams = [NSString stringWithFormat:@"uuid=%@&token=%@", sharedMan.UUID, hexToken];
    NSData *myData = [ConnectionFactory connType:@"POST" connAPI:CONNECT_POST_PUSH connParam:postParams];
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if ([AppDelegateMethods checkLoginSession]) {
        
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
