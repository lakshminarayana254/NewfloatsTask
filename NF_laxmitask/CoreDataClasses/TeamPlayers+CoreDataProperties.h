//
//  TeamPlayers+CoreDataProperties.h
//  NF_laxmitask
//
//  Created by Lakshmi Narayana on 10/01/19.
//  Copyright © 2019 lakshmi. All rights reserved.
//
//

#import "TeamPlayers+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TeamPlayers (CoreDataProperties)

+ (NSFetchRequest<TeamPlayers *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *countryId;
@property (nullable, nonatomic, copy) NSString *playerName;

@end

NS_ASSUME_NONNULL_END
