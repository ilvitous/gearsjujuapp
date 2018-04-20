//
//  AddRequestViewController.m
//  GearJuJu
//
//  Created by Andrea Vitale on 4/18/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import "AddRequestViewController.h"

@interface AddRequestViewController ()

@property (nonatomic,strong) NSMutableArray *equipment;

@end

@implementation AddRequestViewController
@synthesize event_title;
@synthesize event_id;
@synthesize titleLabel;
@synthesize EquipmentTable;
@synthesize responseView;
@synthesize sendButton;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *title = [NSString stringWithFormat:@"Request for %@" ,self.event_title];
    self.titleLabel.text = title;
    self.EquipmentTable.delegate = self;
    self.EquipmentTable.dataSource = self;
    self.EquipmentTable.backgroundColor = [UIColor clearColor];
    self.EquipmentTable.allowsSelection = NO;
    
    self.responseView.hidden = true;
    self.EquipmentTable.hidden = false;
    self.sendButton.hidden = false;
    
    [self get_all_equipment];
    
    

    
}

-(void)viewWillAppear:(BOOL)animated{
    self.responseView.hidden = true;
    self.EquipmentTable.hidden = false;
    self.sendButton.hidden = false;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void)get_all_equipment{
    NSString *auth = [[NSUserDefaults standardUserDefaults] objectForKey:@"Bearer"];
    NSString *bearer = [NSString stringWithFormat:@"Bearer %@", auth];
    
    NSURL *url = [NSURL URLWithString:@"http://laravel.roar.design/api/v1/equipment/request/all"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    
    [request setValue:bearer forHTTPHeaderField:@"Authorization"];
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:request
                                                  completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                                                      
                                                      id jsonOutput = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                      
                                                      NSString *status = [jsonOutput valueForKey:@"status"];
                                                      
                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                          
                                                          if ([[NSThread currentThread] isMainThread]){
                                                              NSLog(@"In main thread--completion handler");
                                                              
                                                              if( [status isEqualToString:@"success"]  ){
                                                                  
                                                                  self.equipment = [[NSMutableArray alloc] init];
                                                                  self.equipment = [jsonOutput valueForKey:@"data"];
                                                                  
                                                                  [self.EquipmentTable reloadData];
                                                                  
                                                                  
                                                              }else{
                                                                  NSLog(@"Status: %@",status);
                                                              }
                                                              
                                                          }
                                                          else{
                                                              NSLog(@"Not in main thread--completion handler");
                                                          }
                                                      });
                                                      
                                                      
                                                  }];
    
    
    // 5
    [uploadTask resume];
    
    
}

//table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.equipment count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[self.equipment objectAtIndex:section] valueForKey:@"category"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ [[self.equipment objectAtIndex:section] valueForKey:@"equipments"]  count];
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [self.EquipmentTable dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    NSMutableArray *eqipmentArray = [[self.equipment objectAtIndex:indexPath.section] valueForKey:@"equipments"];
    
    //    title
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    nameLabel.text = [[ eqipmentArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    
//    qty
    UILabel *qtyLabel = (UILabel *)[cell viewWithTag:2];
    qtyLabel.text = [NSString stringWithFormat:@"0"];
    
    //    category
    UILabel *catLabel = (UILabel *)[cell viewWithTag:3];
    catLabel.text = [[self.equipment objectAtIndex:indexPath.section] valueForKey:@"category"];
    
    //    id
    UILabel *idLabel = (UILabel *)[cell viewWithTag:4];
    idLabel.text = [NSString stringWithFormat:@"%@",[[ eqipmentArray objectAtIndex:indexPath.row] valueForKey:@"id"] ];
    
    
    //   type
    UILabel *typeLabel = (UILabel *)[cell viewWithTag:5];
    typeLabel.text = [[ eqipmentArray objectAtIndex:indexPath.row] valueForKey:@"type"];
    
    return cell;
    

   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 108; // your dynamic height...
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor whiteColor];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor blackColor]];
    
    // Another way to set the background color
    // Note: does not preserve gradient effect of original header
    // header.contentView.backgroundColor = [UIColor blackColor];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    
    
    
}

- (IBAction)addItem:(id)sender {
    
    UIButton *butn = (UIButton *)sender;
    UITableViewCell *cell = [self parentCellForView:butn];
    if (cell != nil) {
        
        UILabel *qtyLabel = (UILabel *)[cell viewWithTag:2];
        NSString *qtyString = [qtyLabel text];
        NSInteger qty = [qtyString integerValue];
        qty++;
        NSString *integerAsString = [@(qty) stringValue];
        qtyLabel.text = [NSString stringWithFormat:@"%@",integerAsString];
    
    }
    

}


- (IBAction)removeItem:(id)sender {
    
    UIButton *butn = (UIButton *)sender;
    UITableViewCell *cell = [self parentCellForView:butn];
    if (cell != nil) {
        
        UILabel *qtyLabel = (UILabel *)[cell viewWithTag:2];
        NSString *qtyString = [qtyLabel text];
        NSInteger qty = [qtyString integerValue];
        if(qty>0){
            qty--;
            NSString *integerAsString = [@(qty) stringValue];
            qtyLabel.text = [NSString stringWithFormat:@"%@",integerAsString];
        }
      
        
        
    }
    
    
    
    

}


-(UITableViewCell *)parentCellForView:(id)theView
{
    id viewSuperView = [theView superview];
    while (viewSuperView != nil) {
        if ([viewSuperView isKindOfClass:[UITableViewCell class]]) {
            return (UITableViewCell *)viewSuperView;
        }
        else {
            viewSuperView = [viewSuperView superview];
        }
    }
    return nil;
}


- (IBAction)sendRequest:(id)sender {
    
//    create cells array
    NSMutableArray *cells = [[NSMutableArray alloc] init];
    for (NSInteger j = 0; j < [self.EquipmentTable numberOfSections]; ++j)
    {
        for (NSInteger i = 0; i < [self.EquipmentTable numberOfRowsInSection:j]; ++i)
        {
            [cells addObject:[self.EquipmentTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:j]]];
        }
    }
    
    NSMutableArray *requeastArray = [[NSMutableArray alloc] init];
    
    
//    loop cells
    for (UITableViewCell *cell in cells)
    {
        
//        qty
        UILabel *qtyLabel = (UILabel *)[cell viewWithTag:2];
        NSString *qtyString = [qtyLabel text];
        
//        name
        UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
        NSString *nameString = [nameLabel  text];
        
        
        
//        id
        NSString *UUID = [[NSUUID UUID] UUIDString];
        
        
        //        equipment id
        UILabel *idLabel = (UILabel *)[cell viewWithTag:4];
        NSString *idString = [idLabel text];
        
        //        type
        UILabel *typeLabel = (UILabel *)[cell viewWithTag:5];
        NSString *typeString = [typeLabel text];
        
        //        category
        UILabel *categoryLabel = (UILabel *)[cell viewWithTag:3];
        NSString *categoryString = [categoryLabel text];
        
        
        
        NSInteger qty = [qtyString integerValue];
        if(qty>0){
            
            NSDictionary *requestDictionary = @{@"qty": qtyString, @"name":nameString, @"equipment_request":UUID, @"equipment_id":idString, @"type":typeString, @"category": categoryString };
            [requeastArray addObject:requestDictionary];
            
            
        }
        
        
    }
    
    
    if( [requeastArray count] > 0){
        
        NSError* error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:requeastArray options:NSJSONWritingPrettyPrinted error:&error];
        //    request array
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        
        NSString *auth = [[NSUserDefaults standardUserDefaults] objectForKey:@"Bearer"];
        NSString *bearer = [NSString stringWithFormat:@"Bearer %@", auth];
        NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"];

        
        NSURL *url = [NSURL URLWithString:@"http://laravel.roar.design/api/v1/request/add"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:bearer forHTTPHeaderField:@"Authorization"];
       
        NSDictionary *dictionary = @{@"equipment": jsonString, @"user": userId, @"event" : self.event_id};
        
        
        
        NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
        NSURLSession *session = [NSURLSession sharedSession];
        
        if (!error) {
            // 4
            NSURLSessionDataTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data, NSURLResponse *response,NSError *error) {
                id jsonOutput = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSString *status = [jsonOutput valueForKey:@"status"];
                NSString *msg = [jsonOutput valueForKey:@"msg"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([[NSThread currentThread] isMainThread]){
                        NSLog(@"In main thread--completion handler");
                        //
                        if( [status isEqualToString:@"success"]  ){
                            NSLog(@"Status: %@",status);
                            
                             self.responseView.hidden = false;
                             self.EquipmentTable.hidden = true;
                             self.sendButton.hidden = true;
                            
                        }else{
                            NSLog(@"Status: %@",status);
                            NSLog(@"Message: %@",msg);
                        }
                        
                    }
                    else{
                        NSLog(@"Not in main thread--completion handler");
                    }
                });
                
                
            }];
            [uploadTask resume];
        }
        
        
    }
    
    
    
    
    
    
    
   
    
    
}


//unique id
+ (NSString *)uuid
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);
    return (__bridge_transfer NSString *)uuidStringRef;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
