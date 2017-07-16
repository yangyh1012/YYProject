//
//  AppDelegate.m
//  YYProject
//
//  Created by 杨毅辉 on 2017/2/18.
//  Copyright © 2017年 杨毅辉. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*说明：资源文件目录     */
    NSBundle *bundle = [NSBundle mainBundle];
    DLog(@"%@",bundle);//DLog
    
    /*说明：documents文件目录      */
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    DLog(@"%@",paths);//DLog
    
    BOOL flag = NO;
    if (flag) {
        
        [self logAndAnalyticsHanlde];
    }
    
    /***** App store 应用打分 */
    [iRate sharedInstance].applicationBundleID = [[[NSBundle mainBundle] infoDictionary] objectForKey:(__bridge NSString *)kCFBundleIdentifierKey];
    [iRate sharedInstance].promptAtLaunch = NO;
    [iRate sharedInstance].onlyPromptIfLatestVersion = NO;
    /* ***** */
    
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

- (void)logAndAnalyticsHanlde {
    
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo> aspectInfo) {
                                   
                                   NSString *className = NSStringFromClass([[aspectInfo instance] class]);
                                   DLog(@"进入 %@ 控制器",className);
                                   
                               } error:NULL];
    
    [UIViewController aspect_hookSelector:@selector(viewWillDisappear:)
                              withOptions:AspectPositionAfter
                               usingBlock:^(id<AspectInfo> aspectInfo) {
                                   
                                   NSString *className = NSStringFromClass([[aspectInfo instance] class]);
                                   DLog(@"离开 %@ 控制器",className);
                                   
                               } error:NULL];
    
    [UIViewController aspect_hookSelector:NSSelectorFromString(@"dealloc")
                              withOptions:AspectPositionBefore
                               usingBlock:^(id<AspectInfo> aspectInfo) {
                                   
                                   NSString *className = NSStringFromClass([[aspectInfo instance] class]);
                                   DLog(@"%@ 控制器被释放了",className);
                                   
                               } error:NULL];
    
    [UIButton aspect_hookSelector:@selector(addTarget:action:forControlEvents:)
                      withOptions:AspectPositionAfter
                       usingBlock:^(id<AspectInfo> aspectInfo, id target, SEL action, UIControlEvents controlEvents) {
                           
                           if ([aspectInfo.instance isKindOfClass:[UIButton class]]) {
                               
                               UIButton *button = aspectInfo.instance;
                               button.accessibilityHint = NSStringFromSelector(action);
                           }
                       } error:NULL];
    
    [UIControl aspect_hookSelector:@selector(beginTrackingWithTouch:withEvent:)
                       withOptions:AspectPositionAfter
                        usingBlock:^(id<AspectInfo> aspectInfo, UITouch *touch, UIEvent *event) {
                            
                            if ([aspectInfo.instance isKindOfClass:[UIButton class]]) {
                                
                                UIButton *button = aspectInfo.instance;
                                id object =  [button.allTargets anyObject];
                                NSString *className = NSStringFromClass([object class]);
                                DLog(@"当前控制器：%@ 按钮方法：%@",className,button.accessibilityHint);
                            }
                        } error:NULL];
}


@end
