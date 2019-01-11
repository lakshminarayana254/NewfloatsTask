//
//  CountryHomeTableViewController.h
//  NF_laxmitask
//
//  Created by Lakshmi Narayana on 10/01/19.
//  Copyright © 2019 lakshmi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "TeamPlayers+CoreDataClass.h"
#import "CountryHomeTableViewCell.h"

@interface CountryHomeTableViewController : UITableViewController
-(void)getCountryNameFromList:(NSString *)country;
@property (strong, nonatomic) IBOutlet UITableView *playersHomeTableView;
@end
