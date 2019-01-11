//
//  CountryData+CoreDataProperties.m
//  NF_laxmitask
//
//  Created by Lakshmi Narayana on 10/01/19.
//  Copyright © 2019 lakshmi. All rights reserved.
//
//

#import "CountryData+CoreDataProperties.h"

@implementation CountryData (CoreDataProperties)

+ (NSFetchRequest<CountryData *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"CountryData"];
}

@dynamic countryID;
@dynamic countryName;
@dynamic countryLogo;

@end
