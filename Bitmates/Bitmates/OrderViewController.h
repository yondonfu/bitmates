//
//  OrderViewController.h
//  Bitmates
//
//  Created by Snaheth Thumathy on 10/11/15.
//  Copyright © 2015 calhackssquad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSString *personName;
@property (strong, nonatomic) NSString *quoteId;
@property (strong, nonatomic) NSString *pickUpAddress;
@property (strong, nonatomic) NSString *dropOffAddress;

@end
