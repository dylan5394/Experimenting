//
//  CreditCardTableViewController.m
//  Assignment6
//
//  Created by Dylan Kyle Davis on 3/3/16.
//  Copyright © 2016 dylan. All rights reserved.
//

#import "AppDelegate.h"
#import "KeychainItemWrapper.h"
#import <Security/Security.h>
#import "CreditCardTableViewController.h"
#import "CreditCardModel.h"

@interface CreditCardTableViewController () <UIAlertViewDelegate>

@property (strong, nonatomic) KeychainItemWrapper * pinWrapper;

@property (strong) UIAlertController * existingUserRef;
@property (strong) UIAlertController * userAlertRef;

@property (strong, nonatomic) CreditCardModel * model;

@end

@implementation CreditCardTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.model = [CreditCardModel sharedModel];
    
    self.pinWrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"com.dylan.Assignment6.pin" accessGroup:nil];
    [self.pinWrapper setObject:(id)kSecAttrAccessibleWhenUnlocked forKey:(id)kSecAttrAccessible];
    [self.pinWrapper setObject:@"pinIdentifer" forKey: (id)kSecAttrAccount];

    UIAlertController *existingUser = [UIAlertController alertControllerWithTitle:@"Welcome." message:@"Enter your pin." preferredStyle:UIAlertControllerStyleAlert];
    
    self.existingUserRef = existingUser;
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Done" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        NSString * firstField = ((UITextField *)[self.existingUserRef.textFields objectAtIndex:0]).text;
        
        if([firstField isEqualToString:(NSString*)[self.pinWrapper objectForKey:(id)kSecValueData]]) {
            
            ((UITextField *)[self.existingUserRef.textFields objectAtIndex:0]).text = @"";
            AppDelegate * temp = [[UIApplication sharedApplication] delegate];
            temp.isLoggedIn = true;
        }
        else {
            [self presentViewController:self.existingUserRef animated:YES completion:nil];
        }
    }];
    
    [existingUser addAction:defaultAction];
    [existingUser addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Pin number";
    }];
    
    
    //FOR NEW USERS
    UIAlertController *newUserAlert = [UIAlertController alertControllerWithTitle:@"First Time Logging In" message:@"Choose a pin." preferredStyle:UIAlertControllerStyleAlert];
    
    self.userAlertRef = newUserAlert;
    UIAlertAction *defaultAction2 = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        NSString * firstField = ((UITextField *)[self.userAlertRef.textFields objectAtIndex:0]).text;
        NSString * secondField = ((UITextField *)[self.userAlertRef.textFields objectAtIndex:1]).text;
        if([firstField isEqualToString:secondField] && firstField.length > 0) {
            
            [self.pinWrapper setObject:firstField forKey:(id)kSecValueData];
        }
        else {
            [self presentViewController:self.userAlertRef animated:YES completion:nil];
        }
    }];
    
    [newUserAlert addAction:defaultAction2];
    [newUserAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Enter a pin";
    }];
    [newUserAlert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Enter the pin again";
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentLogin) name:@"presentLogin" object:nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    AppDelegate * temp = [[UIApplication sharedApplication] delegate];
    if(!temp.isLoggedIn) {
        
        [self presentLogin];
    }
}

-(void)presentLogin {

    if([self.pinWrapper objectForKey:(id)kSecValueData]) {
        
        [self presentViewController:self.existingUserRef animated:YES completion:nil];
        
    } else {
        
        [self presentViewController:self.userAlertRef animated:YES completion:nil];
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
    
    return self.model.numCards;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"card" forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary * currentCard = [self.model getCardAtIndex:indexPath.row];
    
    NSString * last4;
    if([currentCard[kNumber] length] >= 4) {
        
        last4 = [currentCard[kNumber] substringFromIndex: [currentCard[kNumber] length] - 4];
    }
    else {
        last4 = @"";
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",currentCard[kName],last4];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
