//
//  AppDelegate.h
//  NF_laxmitask
//
//  Created by Lakshmi Narayana on 10/01/19.
//  Copyright © 2019 lakshmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (strong) NSManagedObjectContext *managedObjectContext;

-(NSManagedObjectContext *)initialiseCoreDataStack;


@end

