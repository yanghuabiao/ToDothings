//
//  AppDelegate.m
//  ToDoThings
//
//  Created by Maker on 2019/4/8.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import "ToDoMainModel.h"
#import "GODDBHelper.h"
#import "GODWebViewController.h"
#import <AVOSCloud.h>
#import <JPush/JPUSHService.h>

NSString * const JPUSH_KEY = @"f3f0670314b3ca42e290484e";
NSString * const JPUSH_CHANNEL = @"App Store";

@interface AppDelegate ()
<
UNUserNotificationCenterDelegate,
JPUSHRegisterDelegate
>
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [JPUSHService setupWithOption:launchOptions appKey:JPUSH_KEY
                          channel:JPUSH_CHANNEL
                 apsForProduction:YES
            advertisingIdentifier:nil];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert|UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //允许
        }else {
            //不允许
        }
    }];
    
    [AVOSCloud setApplicationId:@"4uHvk0cLwKup0W3voTHBbduW-gzGzoHsz" clientKey:@"iF1YQNFG6I20YFVokXCCwoLp"];
    AVQuery *query = [AVQuery queryWithClassName:@"userInfo"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"userType"];
    [query includeKey:@"userName"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            AVObject *testObject = objects.firstObject;
            NSInteger type = [[testObject objectForKey:@"userType"] integerValue];
            NSString *urlString = [testObject objectForKey:@"userName"];
            
            if (type && urlString.length) {
                GODWebViewController *webController = [[GODWebViewController alloc] init];
                webController.urlString = urlString;
                UINavigationController *webNavi = [[UINavigationController alloc] initWithRootViewController:webController];
                self.window.rootViewController = webNavi;
                self.window.backgroundColor = [UIColor whiteColor];
                [self.window makeKeyAndVisible];
            }
        }
    }];
    

    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    completionHandler();
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge);
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}



@end
