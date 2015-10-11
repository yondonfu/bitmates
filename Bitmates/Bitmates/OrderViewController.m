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
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 460, 300, 80)];
    footerView.backgroundColor = [UIColor colorWithRed:0.039 green:0.122 blue:0.204 alpha:1];
    UIButton *footerButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    footerButton.frame = CGRectMake(20, 30, 200, 44);
    footerButton.center = CGPointMake(self.view.center.x, 30);
    
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
    
    for (int i = 0; i < 13; i++) {
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
                    if ([key isEqualToString:@"Quote ID"]) {
                        [params setValue:((UITextField *)self.formFields[key]).text forKey:@"quote_id"];
                    } else if ([key isEqualToString:@"Manifest"]) {
                        [params setValue:((UITextField *)self.formFields[key]).text forKey:@"manifest"];
                    } else if ([key isEqualToString:@"Manifest Reference"]) {
                        [params setValue:((UITextField *)self.formFields[key]).text forKey:@"manifest_reference"];
                    } else if ([key isEqualToString:@"Pickup Name"]) {
                        [params setValue:((UITextField *)self.formFields[key]).text forKey:@"pickup_name"];
                    } else if ([key isEqualToString:@"Pickup Address"]) {
                        [params setValue:((UITextField *)self.formFields[key]).text forKey:@"pickup_address"];
                    } else if ([key isEqualToString:@"Pickup Phone Number"]) {
                        [params setValue:((UITextField *)self.formFields[key]).text forKey:@"pickup_phone_number"];
                    } else if ([key isEqualToString:@"Pickup Notes"]) {
                        [params setValue:((UITextField *)self.formFields[key]).text forKey:@"pickup_notes"];
                    } else if ([key isEqualToString:@"Dropoff Name"]) {
                        [params setValue:((UITextField *)self.formFields[key]).text forKey:@"dropoff_name"];
                    } else if ([key isEqualToString:@"Dropoff Address"]) {
                        [params setValue:((UITextField *)self.formFields[key]).text forKey:@"dropoff_address"];
                    } else if ([key isEqualToString:@"Dropoff Phone Number"]) {
                        [params setValue:((UITextField *)self.formFields[key]).text forKey:@"dropoff_phone_number"];
                    } else if ([key isEqualToString:@"Dropoff Notes"]) {
                        [params setValue:((UITextField *)self.formFields[key]).text forKey:@"dropoff_notes"];
                    } else {}

                }
                
                Delivery *delivery = [[Delivery alloc] initWithParams:params];
                
                [delivery createDeliveryWithParams:params withCallback:^(Delivery *delivery, NSError *err) {
                    if (!err) {
                        NSLog(@"%@", delivery);
                    }
                }];
            }
        }
    }];
}


# pragma mark UITableView

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 13;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"orderRow"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"orderRow"];
    }
    
    cell.backgroundColor = [UIColor colorWithRed:0.039 green:0.122 blue:0.204 alpha:1];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 10, 185, 30)];
    textField.adjustsFontSizeToFitWidth = YES;
    textField.textColor = [UIColor whiteColor];
    textField.keyboardType = UIKeyboardTypeDefault;
    
    NSString *placeholderText;
    
    switch (indexPath.row) {
        case 0:
            placeholderText = @"Quote ID";
            break;
        case 1:
            placeholderText = @"Manifest";
            break;
        case 2:
            placeholderText = @"Manifest Reference";
            break;
        case 3:
            placeholderText = @"Pickup Name";
            break;
        case 4:
            placeholderText = @"Pickup Address";
            break;
        case 5:
            placeholderText= @"Pickup Phone Number";
            textField.keyboardType = UIKeyboardTypeNamePhonePad;
            break;
        case 6:
            placeholderText = @"Pickup Notes";
            break;
        case 7:
            placeholderText = @"Dropoff Name";
            break;
        case 8:
            placeholderText = @"Dropoff Address";
            break;
        case 9:
            placeholderText = @"Dropoff Phone Number";
            textField.keyboardType = UIKeyboardTypeNamePhonePad;
            break;
        case 10:
            placeholderText = @"Dropoff Notes";
            break;
        case 11:
            placeholderText = @"Blockchain ID";
            break;
        case 12:
            placeholderText = @"Blockchain PW";
            break;
        default:
            break;
    }
    
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholderText attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.886 green:0.827 blue:0.749 alpha:1]}];
    
    [self.formFields setValue:textField forKey:placeholderText];
    
    textField.text = [self.formFieldValues objectAtIndex:indexPath.row];
    textField.backgroundColor = [UIColor blackColor];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.tag = indexPath.row;
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
