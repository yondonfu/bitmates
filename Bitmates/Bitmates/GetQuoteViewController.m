//
//  GetQuoteViewController.m
//  Bitmates
//
//  Created by Snaheth Thumathy on 10/11/15.
//  Copyright © 2015 calhackssquad. All rights reserved.
//

#import "GetQuoteViewController.h"

@interface GetQuoteViewController ()
@end

@implementation GetQuoteViewController
@synthesize personName;


-(id)init{
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = personName;
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f],
                                                                   NSFontAttributeName, nil];
    
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
