//
//  CountryHomeTableViewController.m
//  NF_laxmitask
//
//  Created by Lakshmi Narayana on 10/01/19.
//  Copyright © 2019 lakshmi. All rights reserved.
//

#import "CountryHomeTableViewController.h"

@interface CountryHomeTableViewController ()<CountryListCellDelegate>
- (IBAction)backButton:(id)sender;

- (IBAction)addPlayerBTN:(id)sender;
@property (nonatomic,strong) NSManagedObjectContext* managedobjectcontext;

@end

@implementation CountryHomeTableViewController
NSString *countryName;
NSArray *playersList;
TeamPlayers *playerObject;

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.title = countryName;
    self.playersHomeTableView.delegate=self;
    self.playersHomeTableView.dataSource=self;
    
    AppDelegate *ad = [[AppDelegate alloc]init];
    _managedobjectcontext = ad.initialiseCoreDataStack;
    
    [self getPlayersofCountry:countryName];
    
}

-(void)getPlayersofCountry:(NSString *)county{
    //get players list from coredata if exist
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TeamPlayers"];
    NSError *error;
    [request setReturnsObjectsAsFaults:NO];
    [request setPredicate:[NSPredicate predicateWithFormat:@"countryId==%@",county]];
    playersList = [[NSArray alloc]init];
    playersList = [_managedobjectcontext executeFetchRequest:request error:&error];
    [_playersHomeTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getCountryNameFromList:(NSString *)country{
    countryName = country;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return playersList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"CountryHomeTableViewCell";
    CountryHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[CountryHomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.playerNameLB.text = [[playersList valueForKey:@"playerName"] objectAtIndex:indexPath.row];
    cell.itemNametext = [[playersList valueForKey:@"playerName"] objectAtIndex:indexPath.row];
    cell.itemText = [[playersList valueForKey:@"playerName"] objectAtIndex:indexPath.row];
    cell.delegate = self;
    return cell;
    
}


- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)addPlayerBTN:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@",countryName] message:@"Add your team member here!" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Player Name";
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"ADD" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Current password %@", [[alertController textFields][0] text]);
        if (![[[alertController textFields][0] text] isEqualToString:@""]) {
            [self savePlayerToCoredata:[[alertController textFields][0] text]];
        }
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Canelled");
    }];
    
    [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
-(void)savePlayerToCoredata:(NSString *)playerName{
    NSLog(@"player name is %@", playerName);
    playerObject = [NSEntityDescription insertNewObjectForEntityForName:@"TeamPlayers" inManagedObjectContext:_managedobjectcontext];
    NSError *error;
    
    playerObject.countryId = countryName;
    playerObject.playerName = playerName;
    
    if (![_managedobjectcontext save:&error]) {
        NSLog(@"Failed to save - error: %@", [error localizedDescription]);
    }else{
        
        NSLog(@"successfully inserted");
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"TeamPlayers"];
        NSError *error = nil;
        [request setReturnsObjectsAsFaults:NO];
        [request setPredicate:[NSPredicate predicateWithFormat:@"countryId==%@",countryName]];
        playersList = [_managedobjectcontext executeFetchRequest:request error:&error];
        [self.playersHomeTableView reloadData];
    }
    
}
- (void)buttonOneActionForItemText:(NSString *)itemText andname:(NSString *)itemName{
    UIAlertController *deleteCustAlert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Are you sure you want to delete this player ?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self deletePlayer:itemText];
        
    }];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Do not delete customer");
    }];
    [deleteCustAlert addAction:yesAction];
    [deleteCustAlert addAction:noAction];
    [self presentViewController:deleteCustAlert animated:NO completion:nil];
}

-(void)deletePlayer:(NSString *)playerName{
    
    //here we delete player from coredata
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TeamPlayers" inManagedObjectContext:_managedobjectcontext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"playerName=%@",playerName];
    [fetchRequest setEntity:entity];
    [fetchRequest setPredicate:predicate];
    
    NSError *error;
    NSArray *items = [_managedobjectcontext executeFetchRequest:fetchRequest error:&error];
    
    for (NSManagedObject *managedObject in items)
    {
        [_managedobjectcontext deleteObject:managedObject];
    }
    
    if (![self.managedobjectcontext save:&error]) {
        
        NSLog(@"%@",[error localizedDescription]);
        
    }
    else
    {
        NSLog(@"save Successfully");
        [self getPlayersofCountry:countryName];
    }
    
}

- (void)buttonTwoActionForItemText:(NSString *)itemText andname:(NSString *)itemName{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"%@",countryName] message:@"Update Name of your team member here!" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = itemText;
    }];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"Update" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Current password %@", [[alertController textFields][0] text]);
        if (![[[alertController textFields][0] text] isEqualToString:@""]) {
            
            [self UpdatePlayerNamefrom:itemText tonewName:[[alertController textFields][0] text]];
        }
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"Canelled");
    }];
    
    [alertController addAction:confirmAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
-(void)UpdatePlayerNamefrom:(NSString *)playeroldName tonewName:(NSString *)newName{
    
    // here we update player name
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TeamPlayers" inManagedObjectContext:_managedobjectcontext];
    [fetchRequest setReturnsObjectsAsFaults:NO];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"playerName==%@",playeroldName];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    NSArray *objectsArray = [_managedobjectcontext executeFetchRequest:fetchRequest error:&error];
    NSManagedObject* favoritsGrabbed = [objectsArray objectAtIndex:0];
    [favoritsGrabbed setValue:newName forKey:@"playerName"];
    [_managedobjectcontext save:&error];
    if (![_managedobjectcontext save:&error]) {
        
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        
    }else{
        [self getPlayersofCountry:countryName];
    }
    
}


@end
