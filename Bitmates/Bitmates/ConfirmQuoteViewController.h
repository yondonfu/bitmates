//
//  ConfirmQuoteViewController.h
//  Bitmates
//
//  Created by Snaheth Thumathy on 10/11/15.
//  Copyright © 2015 calhackssquad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DeliveryQuote.h"

@interface ConfirmQuoteViewController : UIViewController

@property (strong, nonatomic) DeliveryQuote *quote;
@property (strong, nonatomic) NSString *personName;

@end
