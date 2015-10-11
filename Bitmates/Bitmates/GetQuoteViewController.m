//
//  GetQuoteViewController.m
//  Bitmates
//
//  Created by Snaheth Thumathy on 10/11/15.
//  Copyright © 2015 calhackssquad. All rights reserved.
//

#import "GetQuoteViewController.h"
#import "Postmates.h"
#import "APIManager.h"
#import "DeliveryQuote.h"
#import "ConfirmQuoteViewController.h"

@interface GetQuoteViewController ()
@property UITextField *pickField;
@property UITextField *dropField;
@property UIButton *done;
@end

@implementation GetQuoteViewController
@synthesize personName, pickField, dropField, done;


-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.title = personName;
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f],
                                                                   NSFontAttributeName, nil];
    
    pickField = [[UITextField alloc] initWithFrame: CGRectMake(0, 60, self.view.frame.size.width, 60)];
    pickField.backgroundColor = [UIColor colorWithRed:0.886 green:0.827 blue:0.749 alpha:1];
    pickField.borderStyle = UITextBorderStyleBezel;
    pickField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:45.0f];
    pickField.adjustsFontSizeToFitWidth = YES;
    pickField.minimumFontSize = 12.0f;
    pickField.placeholder = @"Pickup";
    pickField.keyboardType = UIKeyboardTypeDefault;
    pickField.returnKeyType = UIReturnKeyDone;
    pickField.clearButtonMode = UITextFieldViewModeWhileEditing;
    pickField.delegate = self;
    pickField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:pickField];
    [pickField becomeFirstResponder];
    
    dropField = [[UITextField alloc] initWithFrame: CGRectMake(0, 120, self.view.frame.size.width, 60)];
    dropField.backgroundColor = [UIColor colorWithRed:0.886 green:0.827 blue:0.749 alpha:1];
    dropField.borderStyle = UITextBorderStyleBezel;
    dropField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size: 45.0f];
    dropField.adjustsFontSizeToFitWidth = YES;
    dropField.minimumFontSize = 12.0f;
    dropField.placeholder = @"Dropoff";
    dropField.keyboardType = UIKeyboardTypeDefault;
    dropField.returnKeyType = UIReturnKeyDone;
    dropField.clearButtonMode = UITextFieldViewModeWhileEditing;
    dropField.delegate = self;
    dropField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [self.view addSubview:dropField];
    
    done = [UIButton buttonWithType:UIButtonTypeCustom]; //224
    [done setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    done.backgroundColor = [UIColor colorWithRed:0.039 green:0.122 blue:0.204 alpha:1];
    [done setTitle:@"Done" forState:UIControlStateNormal];
    done.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0f];
    done.frame = CGRectMake(0, 180, self.view.frame.size.width, self.view.frame.size.height - 224 - 180);
    [done addTarget:self action:@selector(fireDeliveryQuote) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:done];
}

-(void)fireDeliveryQuote{
    DeliveryQuote *q = [[DeliveryQuote alloc] initWithPickUp:pickField.text dropOff:dropField.text];
    [q generateDeliveryQuoteWithCallback:^(DeliveryQuote *updatedQuote, NSError *err){
        NSInteger fee = updatedQuote.fee;
        NSDate *eta = updatedQuote.dropOffEta;
        NSInteger duration = updatedQuote.duration;
        if(fee > 0 && duration > 0 && eta != nil){
            ConfirmQuoteViewController *confirmVC = [[ConfirmQuoteViewController alloc] init];
            confirmVC.fee = fee;
            confirmVC.duration = duration;
            [self.navigationController pushViewController:confirmVC animated:YES];
        }
        else{
            NSString *msg = @"";
            if(err != nil){
                msg = err.description;
            }
            else{
                msg = @"Check your inputs";
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
