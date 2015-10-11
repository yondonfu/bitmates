//
//  BMWallet.m
//  Bitmates
//
//  Created by Yondon Fu on 10/10/15.
//  Copyright © 2015 calhackssquad. All rights reserved.
//

#import "BMWallet.h"
#import "Bitmates.h"

@interface BMWallet ()

@end

@implementation BMWallet

- (instancetype)initWithId:(NSString *)identifier andPassword:(NSString *)pass {
    self = [super init];
    if (!self) return nil;
    
    _identifier = identifier;
    _password = pass;
    
    return self;
}

- (void)sendPaymentTo:(NSString *)receiveAddress forAmount:(NSInteger)amount withCallback:(void (^)(NSDictionary *res, NSError *err))callback {
    [[Bitmates currentManager] makeOutgoingPaymentTo:receiveAddress forAmount:amount fromWalletIdentifier:self.identifier withPassword:self.password withCallback:^(NSDictionary *res, NSError *err) {
        if (err) {
            NSLog(@"%@", [err localizedDescription]);
            NSLog(@"%@", res);
            
            callback(nil, err);
        } else {
            NSLog(@"%@", res);
            
            callback(res, nil);
        }
    }];
}

@end
