//
//  CountryHomeTableViewCell.h
//  NF_laxmitask
//
//  Created by Lakshmi Narayana on 10/01/19.
//  Copyright © 2019 lakshmi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CountryListCellDelegate <NSObject,UIGestureRecognizerDelegate>
- (void)buttonOneActionForItemText:(NSString *)itemText andname:(NSString *)itemName;
- (void)buttonTwoActionForItemText:(NSString *)itemText andname:(NSString *)itemName;
@end

@interface CountryHomeTableViewCell : UITableViewCell
@property (nonatomic, strong) NSString *itemText;
@property (nonatomic, strong) NSString *itemNametext;

@property (weak, nonatomic) IBOutlet UILabel *textLB;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;

@property (weak, nonatomic) IBOutlet UILabel *playerNameLB;

@property (weak, nonatomic) IBOutlet UIButton *editOutlet;
@property (weak, nonatomic) IBOutlet UIButton *deleteOutlet;

@property (nonatomic, weak) id <CountryListCellDelegate> delegate;

@end
