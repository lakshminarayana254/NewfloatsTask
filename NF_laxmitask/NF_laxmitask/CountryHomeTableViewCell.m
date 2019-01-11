//
//  CountryHomeTableViewCell.m
//  NF_laxmitask
//
//  Created by Lakshmi Narayana on 10/01/19.
//  Copyright © 2019 lakshmi. All rights reserved.
//

#import "CountryHomeTableViewCell.h"

@implementation CountryHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)buttonClicked:(id)sender {
    if (sender == self.deleteOutlet) {
        [self.delegate buttonOneActionForItemText:self.itemText andname:self.itemNametext];
        NSLog(@"delete button 1!");
    } else if (sender == self.editOutlet) {
        [self.delegate buttonTwoActionForItemText:self.itemText andname:self.itemNametext];
    } else {
        NSLog(@"Clicked unknown button!");
    }
    
}

- (void)setItemText:(NSString *)itemText andname:(NSString *)itemNameText{
    //Update the instance variable
    _itemText = itemText;
    _itemNametext = itemNameText;
    
    //Set the text to the custom label.
    self.textLB.text = _itemText;
    self.nameLB.text = itemNameText;
    
    
}

@end
