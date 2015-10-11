//
//  BMManager.h
//  Bitmates
//
//  Created by Yondon Fu on 10/10/15.
//  Copyright © 2015 calhackssquad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMManager : NSObject

@property (nonatomic, copy, readonly) NSString *onenameApiId;
@property (nonatomic, copy, readonly) NSString *onenameApiSecret;

- (instancetype)initWithApiId:(NSString *)apiId andApiSecret:(NSString *)apiSecret;

- (void)makeOutgoingPaymentTo:(NSString *)recieveAddress forAmount:(NSInteger)amount fromWalletIdentifier:(NSString *)identifier withPassword:(NSString *)pass withCallback:(void (^)(NSDictionary *, NSError *))callback;

- (void)sendManyOutgoingPaymentsTo:(NSDictionary *)recipients fromWalletIdentifier:(NSString *)identifier withPassword:(NSString *)pass withCallback:(void (^)(NSDictionary *, NSError *))callback;

- (void)listAddressesForWalletIdentifier:(NSString *)identifier withPassword:(NSString *)pass withCallback:(void (^)(NSDictionary *, NSError *))callback;

- (void)getBalanceOfAddress:(NSString *)address withMinConfirmations:(NSInteger)confirmations forWalletIdentifier:(NSString *)identifier withPassword:(NSString *)pass withCallback:(void (^)(NSDictionary *, NSError *))callback;

- (void)createAddressWithLabel:(NSString *)label forWalletIdentifier:(NSString *)identifier withPassword:(NSString *)pass withCallback:(void (^)(NSDictionary *, NSError *))callback;

- (void)searchUsersForName:(NSString *)name withCallback:(void (^)(NSDictionary *, NSError *))callback;

+ (NSString *)getBitcoinAddressOfUser:(NSDictionary *)user;

@end
