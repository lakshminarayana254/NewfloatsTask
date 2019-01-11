//
//  TeamPlayers+CoreDataProperties.m
//  NF_laxmitask
//
//  Created by Lakshmi Narayana on 10/01/19.
//  Copyright © 2019 lakshmi. All rights reserved.
//
//

#import "TeamPlayers+CoreDataProperties.h"

@implementation TeamPlayers (CoreDataProperties)

+ (NSFetchRequest<TeamPlayers *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"TeamPlayers"];
}

@dynamic countryId;
@dynamic playerName;

@end
