//
//  AddCardViewController.m
//  Assignment6
//
//  Created by Dylan Kyle Davis on 3/8/16.
//  Copyright © 2016 dylan. All rights reserved.
//

#import "CreditCardModel.h"
#import "AddCardViewController.h"

@interface AddCardViewController ()
@property (weak, nonatomic) IBOutlet UITextField *numberField;
@property (weak, nonatomic) IBOutlet UITextField *expirationDateField;
@property (weak, nonatomic) IBOutlet UITextField *cv2CodeField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (strong,nonatomic) CreditCardModel * model;

@end

@implementation AddCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.model = [CreditCardModel sharedModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonTapped:(id)sender {
    
    NSMutableDictionary *secureDataDict = [[NSMutableDictionary alloc] init];
    
    if(self.numberField.text)
        [secureDataDict setObject:self.numberField.text forKey:kNumber];
    
    if(self.expirationDateField.text)
        [secureDataDict setObject:self.expirationDateField.text forKey:kExpirationDate];
    
    if(self.cv2CodeField.text)
        [secureDataDict setObject:self.cv2CodeField.text forKey:kCV2];
    
    if(self.nameField.text)
        [secureDataDict setObject:self.nameField.text forKey:kName];
    
    [self.model addCard:secureDataDict];
    
    [self dismissViewControllerAnimated:NO completion:nil];
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
