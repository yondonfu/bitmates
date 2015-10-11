//
//  OrderViewController.m
//  Bitmates
//
//  Created by Snaheth Thumathy on 10/11/15.
//  Copyright © 2015 calhackssquad. All rights reserved.
//

#import "OrderViewController.h"
#import "Bitmates.h"
#import "BMWallet.h"
#import "Delivery.h"

@interface OrderViewController ()

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableDictionary *formFields;
@property (strong, nonatomic) NSMutableArray *formFieldValues;

@end

@implementation OrderViewController

- (BOOL)prefersStatusBarHidden{
    return true;
}

- (void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.039 green:0.122 blue:0.204 alpha:1];
    [self setupView];
}

- (void)setupView {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame];
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    [self.view addSubview:self.tableView];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 460, 300, 140)];
    footerView.backgroundColor = [UIColor colorWithRed:0.039 green:0.122 blue:0.204 alpha:1];
    UIButton *footerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    footerButton.frame = CGRectMake(20, 30, 200, 44);
    footerButton.center = CGPointMake(self.view.center.x, 50);
    
    [footerButton setTitle:@"Place Order" forState:UIControlStateNormal];
    [[footerButton layer] setBorderWidth:2.0f];
    [[footerButton layer] setBorderColor:[UIColor blackColor].CGColor];
    [footerButton setBackgroundColor:[UIColor blueColor]];
    [footerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [footerButton addTarget:self action:@selector(placeOrder:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:footerButton];
    
    self.tableView.tableFooterView = footerView;
    
    self.formFields = [NSMutableDictionary new];
    self.formFieldValues = [NSMutableArray new];
    
    for (int i = 0; i < 11; i++) {
        [self.formFieldValues addObject:@""];
    }
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    [self.view addGestureRecognizer:tapGesture];
    
}

- (void)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)placeOrder:(id)sender {
    [[Bitmates currentManager] searchUsersForName:@"wenger" withCallback:^(NSDictionary *res, NSError *err) {
        if (!err) {
            NSLog(@"%@", res);
            if (res[@"results"] && ((NSArray *)res[@"results"]).count > 0) {
                NSDictionary *user = res[@"results"][0];
                NSString *addr = [BMManager getBitcoinAddressOfUser:user];
                
                NSLog(@"%@", addr);
                
                NSMutableDictionary *params = [NSMutableDictionary new];
                for (NSString *key in [self.formFields allKeys]) {
                    if (![key isEqualToString:@"blockchain_id"] && ![key isEqualToString:@"blockchain_pw"] && ![key isEqualToString:@"amount"]) {
                        [params setValue:((UITextField *)self.formFields[key]).text forKey:key];
                    }
                }
                
                [params setValue:self.quoteId forKey:@"quote_id"];
                [params setValue:self.pickUpAddress forKey:@"pickup_address"];
                [params setValue:self.dropOffAddress forKey:@"dropoff_address"];
                
                NSString *blockchainId = ((UITextField *)self.formFields[@"blockchain_id"]).text;
                NSString *blockchainPw = ((UITextField *)self.formFields[@"blockchain_pw"]).text;
                NSInteger amount = [((UITextField *)self.formFields[@"amount"]).text intValue];
                
                BMWallet *wallet = [[BMWallet alloc] initWithId:blockchainId andPassword:blockchainPw];
                
                Delivery *delivery = [[Delivery alloc] initWithParams:params];
                
                [delivery createDeliveryWithParams:params withCallback:^(Delivery *delivery, NSError *err) {
                    if (!err) {
                        NSLog(@"%@", delivery);
                        
                        [wallet sendPaymentTo:addr forAmount:amount withCallback:^(NSDictionary *res, NSError *err) {
                            if (!err) {
                                NSLog(@"%@", res);
                            }
                        }];
                    }
                }];
                
                NSArray *array = [self.navigationController viewControllers];
                [self.navigationController popToViewController:[array objectAtIndex:0] animated:NO];
            }
        }
    }];
}


# pragma mark UITableView

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderRow"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"orderRow"];
    }
    
    cell.backgroundColor = [UIColor colorWithRed:0.039 green:0.122 blue:0.204 alpha:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor colorWithRed:0.886 green:0.827 blue:0.749 alpha:1];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(150, 5, 155, 30)];
    textField.adjustsFontSizeToFitWidth = YES;
    textField.textColor = [UIColor blackColor];
    textField.keyboardType = UIKeyboardTypeDefault;
    
    NSString *placeholderText;
    
    switch (indexPath.row) {
        case 0:
            placeholderText = @"manifest";
            cell.textLabel.text = @"Manifest";
            break;
        case 1:
            placeholderText = @"manifest_reference";
            cell.textLabel.text = @"Manifest Ref";
            break;
        case 2:
            placeholderText = @"pickup_name";
            cell.textLabel.text = @"Pickup Name";
            break;
        case 3:
            placeholderText = @"pickup_phone_number";
            cell.textLabel.text = @"Pickup Phone #";
            textField.keyboardType = UIKeyboardTypeNamePhonePad;
            break;
        case 4:
            placeholderText = @"pickup_notes";
            cell.textLabel.text = @"Pickup Notes";
            break;
        case 5:
            placeholderText = @"dropoff_name";
            cell.textLabel.text = @"Dropoff Name";
            break;
        case 6:
            placeholderText = @"dropoff_phone_number";
            cell.textLabel.text = @"Dropoff Phone #";
            textField.keyboardType = UIKeyboardTypeNamePhonePad;
            break;
        case 7:
            placeholderText = @"dropoff_notes";
            cell.textLabel.text = @"Dropoff Notes";
            break;
        case 8:
            placeholderText = @"blockchain_id";
            cell.textLabel.text = @"Blockchain ID";
            break;
        case 9:
            placeholderText = @"blockchain_pw";
            cell.textLabel.text = @"Blockchain PW";
            textField.secureTextEntry = YES;
            break;
        case 10:
            placeholderText = @"amount";
            cell.textLabel.text = @"Amount";
            textField.keyboardType = UIKeyboardTypeNamePhonePad;
        default:
            break;
    }
    
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderText attributes:
                                       @{
                                         NSForegroundColorAttributeName: [UIColor colorWithRed:0.886 green:0.827 blue:0.749 alpha:1],
                                         NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0]
                                         }];
    
    
    [self.formFields setValue:textField forKey:placeholderText];
    
    textField.text = [self.formFieldValues objectAtIndex:indexPath.row];
    textField.borderStyle = UITextBorderStyleBezel;
    textField.backgroundColor = [UIColor colorWithRed:0.886 green:0.827 blue:0.749 alpha:1];
    textField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0f];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.tag = indexPath.row;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.delegate = self;
    [textField setEnabled:YES];
    
    
    [cell.contentView addSubview:textField];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.formFieldValues replaceObjectAtIndex:textField.tag withObject:textField.text];
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
