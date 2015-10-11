//
//  BMWallet.h
//  Bitmates
//
//  Created by Yondon Fu on 10/10/15.
//  Copyright © 2015 calhackssquad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMWallet : NSObject

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *password;

- (instancetype)initWithId:(NSString *)identifier andPassword:(NSString *)pass;

@end
