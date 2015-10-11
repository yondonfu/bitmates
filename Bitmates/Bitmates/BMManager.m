//
//  BMManager.m
//  Bitmates
//
//  Created by Yondon Fu on 10/10/15.
//  Copyright © 2015 calhackssquad. All rights reserved.
//

#import "BMManager.h"
#import "AFNetworking.h"

@implementation BMManager

- (instancetype)initWithApiId:(NSString *)apiId andApiSecret:(NSString *)apiSecret {
    self = [super init];
    if (!self) return nil;
    
    _onenameApiId = apiId;
    _onenameApiSecret = apiSecret;
    
    return self;
}

+ (NSString *)baseBlockchainAPIUrl {
    return @"https://blockchain.info/merchant/";
}

+ (NSString *)baseOnenameAPIUrl {
    return @"https://api.onename.com/v1/";
}

- (void)makeOutgoingPaymentTo:(NSString *)recieveAddress forAmount:(NSInteger)amount fromWalletIdentifier:(NSString *)identifier withPassword:(NSString *)pass withCallback:(void (^)(NSDictionary *res, NSError *err))callback {
    NSString *targetAddress = [NSString stringWithFormat:@"%@%@/payment", [self.class baseBlockchainAPIUrl], identifier];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:pass forKey:@"password"];
    [params setValue:recieveAddress forKey:@"to"];
    [params setValue:[NSNumber numberWithInteger:amount] forKey:@"amount"];
    
    [manager POST:targetAddress parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSError *dictError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:operation.responseData options:kNilOptions error:&dictError];
        
        callback(json, error);
    }];
}

- (void)sendManyOutgoingPaymentsTo:(NSDictionary *)recipients fromWalletIdentifier:(NSString *)identifier withPassword:(NSString *)pass withCallback:(void (^)(NSDictionary *, NSError *))callback {
    NSString *targetAddress = [NSString stringWithFormat:@"%@%@/sendmany", [self.class baseBlockchainAPIUrl], identifier];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:pass forKey:@"password"];
    [params setValue:recipients forKey:@"recipients"];
    
    [manager POST:targetAddress parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSError *dictError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:operation.responseData options:kNilOptions error:&dictError];
        
        callback(json, error);
    }];
}

- (void)listAddressesForWalletIdentifier:(NSString *)identifier withPassword:(NSString *)pass withCallback:(void (^)(NSDictionary *, NSError *))callback {
    NSString *targetAddress = [NSString stringWithFormat:@"%@%@/list", [self.class baseBlockchainAPIUrl], identifier];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:pass forKey:@"password"];
    
    [manager GET:targetAddress parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSError *dictError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:operation.responseData options:kNilOptions error:&dictError];
        
        callback(json, error);
    }];
}

- (void)getBalanceOfAddress:(NSString *)address withMinConfirmations:(NSInteger)confirmations forWalletIdentifier:(NSString *)identifier withPassword:(NSString *)pass withCallback:(void (^)(NSDictionary *, NSError *))callback {
    NSString *targetAddress = [NSString stringWithFormat:@"%@%@/address_balance", [self.class baseBlockchainAPIUrl], identifier];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:pass forKey:@"password"];
    [params setValue:address forKey:@"address"];
    [params setValue:[NSNumber numberWithInteger:confirmations] forKey:@"confirmations"];
    
    [manager GET:targetAddress parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSError *dictError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:operation.responseData options:kNilOptions error:&dictError];
        
        callback(json, error);
    }];
}

- (void)createAddressWithLabel:(NSString *)label forWalletIdentifier:(NSString *)identifier withPassword:(NSString *)pass withCallback:(void (^)(NSDictionary *, NSError *))callback {
    NSString *targetAddress = [NSString stringWithFormat:@"%@%@/new_address", [self.class baseBlockchainAPIUrl], identifier];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:pass forKey:@"password"];
    [params setValue:label forKey:@"label"];
    
    [manager POST:targetAddress parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSError *dictError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:operation.responseData options:kNilOptions error:&dictError];
        
        callback(json, error);
    }];
}

- (void)searchUsersForName:(NSString *)name withCallback:(void (^)(NSDictionary *, NSError *))callback {
    NSString *targetAddress = [NSString stringWithFormat:@"%@search", [self.class baseOnenameAPIUrl]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:self.onenameApiId password:self.onenameApiSecret];
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:name forKey:@"query"];
    
    [manager GET:targetAddress parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callback(responseObject, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError * error) {
        NSError *dictError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:operation.responseData options:kNilOptions error:&dictError];
        
        callback(json, error);
    }];
}

+ (NSString *)getBitcoinAddressOfUser:(NSDictionary *)user {
    NSDictionary *profile = user[@"profile"];
    if (!profile[@"bitcoin"]) {
        return nil;
    }
    
    return profile[@"bitcoin"][@"address"];
}

@end
