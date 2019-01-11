//
//  CountryData+CoreDataProperties.h
//  NF_laxmitask
//
//  Created by Lakshmi Narayana on 10/01/19.
//  Copyright © 2019 lakshmi. All rights reserved.
//
//

#import "CountryData+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CountryData (CoreDataProperties)

+ (NSFetchRequest<CountryData *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *countryID;
@property (nullable, nonatomic, copy) NSString *countryName;
@property (nullable, nonatomic, retain) NSObject *countryLogo;

@end

NS_ASSUME_NONNULL_END
