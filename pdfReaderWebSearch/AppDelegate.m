//
//  AppDelegate.m
//  pdfReaderWebSearch
//
//  Created by Prayaas Jain on 6/18/13.
//  Copyright (c) 2013 Prayaas Jain. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize lop,tvc;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Activates PSPDFKit for com.stem-ed.pdfReaderWebSearch
    PSPDFSetLicenseKey("tQZSWNVoyCGSu4B4t0Rpyuokcj9EfcsiFkFTFUYl7oFTypRwv4DfMrNBU3IP"
                       "3YTsRQxylr7sJZJBo/FTr+hLG165vS38Lgjhf96eYYQeyjFnishNS7CI8yd9"
                       "zOKRsfLBFFWzxGvMXuO2FXIxQ9IHetBMtiMZixpsYADLug5kYK9RJnNDU5yt"
                       "4JpunwU47RHUvagC/IJbjrgszs6uz8yqqIkQrCIeO/+UzEzTqz8UqXY00Scp"
                       "1/wjJyeR9yOEeBc03OOKZW2URDLLpnhVzo6t34lxPzaY1ZkD65+xZvSM9+7c"
                       "3yCl2XNzOL4fPnvDu0Vd6uiR+C6ErKojt1aTdfDD/WO5k8kxvL4mYGCe7tSe"
                       "JdnG1PiRQLrCgGrsWcWtumdh1efvM9OccnF42TaTKxMxw5yfh6gOpoNZXJdZ"
                       "ULpJg+6PyeQEWvcHhXqlDysrw6g5RIr8C0aCC3vEMLWfybaVwo/d+Yw409gi"
                       "oAzYyZswXyE=");
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    //tvc = (TestViewController*)  self.window.rootViewController;
    UINavigationController *nc = (UINavigationController*) self.window.rootViewController;
    
    if([nc.topViewController.restorationIdentifier isEqual: @"list"])
    {
    [nc.topViewController performSegueWithIdentifier:@"loadFromSite" sender:self];
    tvc = (TestViewController*)nc.topViewController;
        [tvc loadURL:url];
    }
    else if([nc.topViewController.restorationIdentifier isEqualToString:@"showpdf"])
    {
        tvc = (TestViewController*)nc.topViewController;
        [tvc loadURL:url];
    }
    
    return YES;
}

@end
