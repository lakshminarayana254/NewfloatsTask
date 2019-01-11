//
//  CountryListTableViewController.m
//  NF_laxmitask
//
//  Created by Lakshmi Narayana on 10/01/19.
//  Copyright © 2019 lakshmi. All rights reserved.
//

#import "CountryListTableViewController.h"

@interface CountryListTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *countyListTableView;

@property (nonatomic,strong) NSManagedObjectContext* context;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
@implementation CountryListTableViewController
CountryData *dataObject;
NSMutableArray *responseArray;
NSArray *coreDataArray;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    responseArray = [[NSMutableArray alloc]init];
    coreDataArray = [[NSArray alloc]init];
    self.countyListTableView.delegate=self;
    self.countyListTableView.dataSource=self;
    
    
    AppDelegate *ad = [[AppDelegate alloc]init];
    _context = ad.initialiseCoreDataStack;
    
    //check wheather data exist local
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CountryData"];
    NSError *error = nil;
    [request setReturnsObjectsAsFaults:NO];
    NSArray *resultArray = [_context executeFetchRequest:request error:&error];
    if (resultArray.count == 0) {
        //get data from api for 1st time
        [self getCountriesDataFromApi];
        
    }else{
        
        // fetch data from coredata
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CountryData"];
        NSError *error = nil;
        [request setReturnsObjectsAsFaults:NO];
        coreDataArray = [_context executeFetchRequest:request error:&error];
        
    }
}

-(void)getCountriesDataFromApi{
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://demo6869072.mockable.io/cricket/countries"]];
    
    //create the Method "GET"
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                          if(httpResponse.statusCode == 200)
                                          {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  
                                                  NSError *parseError = nil;
                                                  responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
                                                  NSLog(@"The response is - %@",responseArray);
                                                  
                                                  //on successfully fetching data from api save it to coredata
                                                  [self insertDataToCoreDataTable:responseArray];
                                                  
                                                  [self->_countyListTableView reloadData];
                                              });
                                          }
                                          else
                                          {
                                              NSLog(@"Error");
                                          }
                                      }];
    [dataTask resume];
}

-(void)insertDataToCoreDataTable:(NSMutableArray *)responsedata{
    NSError *error = nil;
    for (NSDictionary *singleNote in responsedata){
        dataObject = [NSEntityDescription insertNewObjectForEntityForName:@"CountryData" inManagedObjectContext:_context];
        dataObject.countryID = [singleNote objectForKey:@"name"];
        dataObject.countryName = [singleNote objectForKey:@"name"];
        
        NSData *dataImage=[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[singleNote objectForKey:@"image"]]] options:NSDataReadingUncached error:&error];
        dataObject.countryLogo = dataImage;
    }
    
    if (![_context save:&error]) {
        NSLog(@"Failed to save - error: %@", [error localizedDescription]);
    }else{
        NSLog(@"successfully inserted");
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"CountryData"];
        NSError *error = nil;
        [request setReturnsObjectsAsFaults:NO];
        coreDataArray = [_context executeFetchRequest:request error:&error];
        [self.countyListTableView reloadData];
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (coreDataArray.count == 0) {
        return responseArray.count;
    }else{
        return coreDataArray.count;
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"CoutryListTableViewCell";
    CoutryListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[CoutryListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    if (coreDataArray.count == 0) {
        cell.countryNameLB.text = [[responseArray valueForKey:@"name"] objectAtIndex:indexPath.row];
        NSData *data = [[responseArray valueForKey:@"logo"] objectAtIndex:indexPath.row];
        cell.countrylogoView.image = [UIImage imageWithData:data];
    }else{
        cell.countryNameLB.text = [[coreDataArray valueForKey:@"countryName"] objectAtIndex:indexPath.row];
        NSData *data = [[coreDataArray valueForKey:@"countryLogo"] objectAtIndex:indexPath.row];
        if ([data isKindOfClass:[NSData class]]) {
            cell.countrylogoView.image = [UIImage imageWithData:data];
        }
    }
    return cell;
}

// delegate methods
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CountryHomeTableViewController *viewController = [[self storyboard] instantiateViewControllerWithIdentifier:@"CountryHomeTableViewController"];
    
    [viewController getCountryNameFromList:[[coreDataArray valueForKey:@"countryName"] objectAtIndex:indexPath.row]];
    [self presentViewController:viewController animated:NO completion:nil];
    
    
}

@end
