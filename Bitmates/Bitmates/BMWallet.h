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
- (void)sendPaymentTo:(NSString *)receiveAddress forAmount:(NSInteger)amount withCallback:(void (^)(NSDictionary *res, NSError *err))callback;
- (void)sendManyPaymentsTo:(NSDictionary *)recipients withCallback:(void (^)(NSDictionary *, NSError *))callback;
- (void)getAddressesWithCallback:(void (^)(NSDictionary *, NSError *))callback;
- (void)getBalanceOfAddress:(NSString *)address withMinConfirmations:(NSInteger)confirmations withCallback:(void (^)(NSDictionary *, NSError *))callback;
- (void)createAddressWithLabel:(NSString *)label withCallback:(void (^)(NSDictionary *, NSError *))callback;

@end
