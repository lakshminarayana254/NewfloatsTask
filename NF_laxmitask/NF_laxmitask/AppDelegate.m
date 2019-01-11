//
//  AppDelegate.m
//  NF_laxmitask
//
//  Created by Lakshmi Narayana on 10/01/19.
//  Copyright © 2019 lakshmi. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
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
    // Saves changes in the application's managed object context before the application terminates.
}

-(NSManagedObjectContext *)initialiseCoreDataStack
{
    
    NSManagedObjectContext *moc;
    
    
    // Step 1: Initialise the NSManagedObjectModel
    
    NSURL *modelURL = [[NSBundle mainBundle]URLForResource:@"NF_laxmitask" withExtension:@"momd"];
    
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
    
    NSAssert(mom != nil, @"Error initializing Managed Object Model");
    
    
    // Step 2: Initialise the Persistent store coordinator
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:mom];
    
    moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    [moc setPersistentStoreCoordinator:psc];
    //moc.automaticallyMergesChangesFromParent = YES;
    [self setManagedObjectContext:moc];
    
    
    // Step 3: Get the url to the persistent store
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    NSURL *documentsURL = [[fileMgr URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
    
    NSURL *storeUrl = [documentsURL URLByAppendingPathComponent:@"country.sqlite"];
    
    NSError *error = nil;
    
    psc = [moc persistentStoreCoordinator];
    
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:@{NSMigratePersistentStoresAutomaticallyOption:@YES,NSInferMappingModelAutomaticallyOption:@YES} error:&error];
    NSAssert(store != nil, @"Error initializing PSC: %@\n%@", [error localizedDescription], [error userInfo]);
    
    return moc;
}
@end
