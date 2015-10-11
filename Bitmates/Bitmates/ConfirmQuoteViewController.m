//
//  ConfirmQuoteViewController.m
//  Bitmates
//
//  Created by Snaheth Thumathy on 10/11/15.
//  Copyright © 2015 calhackssquad. All rights reserved.
//

#import "ConfirmQuoteViewController.h"
#import "OrderViewController.h"

@interface ConfirmQuoteViewController ()

@end

@implementation ConfirmQuoteViewController
@synthesize fee, duration;

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Show the fees, eta, and ETA for user's approval.
    //If all is good, then continue to OrderViewController to actually process order.
    
    self.navigationController.navigationBarHidden = YES;

    self.view.backgroundColor = [UIColor blackColor];

    UILabel *feeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/2, 100)];
    feeLabel.backgroundColor = [UIColor whiteColor];
    feeLabel.textColor = [UIColor blackColor];
    feeLabel.textAlignment = NSTextAlignmentCenter;
    [feeLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:30.0f]];
    [feeLabel setText:[NSString stringWithFormat:@"$%.02f" , (long)fee/100.00]];
    [self.view addSubview:feeLabel];
    
    UILabel *durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2, 100)];
    durationLabel.textAlignment = NSTextAlignmentCenter;
    durationLabel.backgroundColor = [UIColor whiteColor];
    durationLabel.textColor = [UIColor blackColor];
    [durationLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:30.0f]];
    [durationLabel setText:[NSString stringWithFormat:@"%ld min" , (long)duration]];
    [self.view addSubview:durationLabel];
    
    UIButton *done = [UIButton buttonWithType:UIButtonTypeCustom];
    [done setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    done.backgroundColor = [UIColor colorWithRed:0.133 green:0.553 blue:1.000 alpha:1];
    [done setTitle:@"Continue" forState:UIControlStateNormal];
    done.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0f];
    done.frame = CGRectMake(0, 100, self.view.frame.size.width, (self.view.frame.size.height - 100)/2);
    [done addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:done];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    back.backgroundColor = [UIColor colorWithRed:0.957 green:0.204 blue:0.247 alpha:1];
    [back setTitle:@"No Thanks" forState:UIControlStateNormal];
    back.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:24.0f];
    back.frame = CGRectMake(0, done.frame.origin.y + done.frame.size.height, self.view.frame.size.width, (self.view.frame.size.height - 100)/2);
    [back addTarget:self action:@selector(goBackToFront) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
}

-(void)done{
    OrderViewController *ovc = [[OrderViewController alloc] init];
    [self.navigationController pushViewController:ovc animated:YES];
}

-(void)goBackToFront{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
