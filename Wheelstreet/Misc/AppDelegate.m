//
//  AppDelegate.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 01/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Reachability Code
    //==========================================================================
    self.reach = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Set the blocks
    self.reach.reachableBlock = ^(Reachability *reach)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"REACHABLE!");
        });
    };
    
    self.reach.unreachableBlock = ^(Reachability *reach)
    {
        NSLog(@"UNREACHABLE!");
        
    };
    
    //===========================================================================
    
    
    //Changing the navigation bar appearance throughout the app
    //===========================================================================

    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"status_bar_bg.png"] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    //===========================================================================

    
    // Integrating mixpanel analytics into our app
    //===========================================================================
    [Mixpanel sharedInstanceWithToken:MIXPANEL_TOKEN];
    //Mixpanel *mixPanel = [Mixpanel sharedInstance];
    ///[mixPanel track:@"demo-event"];
    //===========================================================================
    
    
    // Integrating google places into our app
    //===========================================================================
    
    [GMSServices provideAPIKey:GOOGLE_API_KEY];
    
    //===========================================================================
    
    
    // Integrating the feature of force update into app. Still to be completed
    //===========================================================================

    NSLog(@"Build version: %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]);
        
    //===========================================================================

    
    //Integrating crashlytics into our app
    //===========================================================================
    
    [Fabric with:@[[Crashlytics class]]];
    
    //===========================================================================
    
    // Start the notifier, which will cause the reachability object to retain itself!
    //===========================================================================
    
    [self.reach startNotifier];
    
    //==========================================================================
    
    [[UITextField appearance] setTintColor:[UIColor darkGrayColor]];
    
    //Navigation bar apperance throughout the app
    //===========================================================================
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:52.0f green:52.0f blue:52.0f alpha:1.0f]];
    [[UINavigationBar appearance] setTranslucent:NO];
    //===========================================================================
    
    //Different status bar appearance for different environments - DEV, STAGING and PRODUCTION
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    
    //Implementing the sidebar for the Home screen
    //=================================================================================================================================================================
    
    //UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
    //                                                         bundle: nil];
    
    //	RightMenuViewController *rightMenu = (RightMenuViewController*)[mainStoryboard
    //														   instantiateViewControllerWithIdentifier: @"RightMenuViewController"];
    
    //	[SlideNavigationController sharedInstance].rightMenu = rightMenu;
     // Creating a custom bar button for right menu
    //	UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    //	[button setImage:[UIImage imageNamed:@"gear"] forState:UIControlStateNormal];
    //	[button addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleRightMenu) forControlEvents:UIControlEventTouchUpInside];
    //	UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    //	[SlideNavigationController sharedInstance].rightBarButtonItem = rightBarButtonItem;
    
    
    //===================================================================================================================================================================
    
    self.swipeTutorialPageIndex = 1;
    
    return YES;
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    // Add any custom logic here.
    return handled;
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "in.wheelstreet.Wheelstreet" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Wheelstreet" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Wheelstreet.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
