//
//  ViewController.m
//  Bitmates
//
//  Created by Yondon Fu on 10/10/15.
//  Copyright © 2015 calhackssquad. All rights reserved.
//

#import "ViewController.h"
#import "BMWallet.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    BMWallet *wallet = [[BMWallet alloc] initWithId:@"46ff0f30-2305-4153-9cea-64a0a853e4b3" andPassword:@"#17movefast"];
    //    [wallet getBalanceOfAddress:@"15B8XD151dn7JQXUKGM4dtA3nqiKdDbdGX" withMinConfirmations:0 withCallback:^(NSDictionary *res, NSError *err) {
//        if (!err) {
//            NSLog(@"%@", res);
//        }
//    }];
    
    [wallet createAddressWithLabel:@"test" withCallback:^(NSDictionary *res, NSError *err) {
        if (!err) {
            NSLog(@"%@", res);
            
            [wallet getAddressesWithCallback:^(NSDictionary *res, NSError *err) {
                if (!err) {
                    NSLog(@"%@", res);
                }
            }];

        }
    }];
    
//    [wallet sendPaymentTo:@"19S2pGLiT23VL2bi3mkazPYmGWeKNGBdjx" forAmount:10000 withCallback:^(NSDictionary *res, NSError *err) {
//        if (!err) {
//            NSLog(@"%@", res);
//        }
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
