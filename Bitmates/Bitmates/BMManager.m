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

+ (NSString *)baseAPIUrl {
    return @"https://blockchain.info/merchant/";
}

- (void)makeOutgoingPaymentTo:(NSString *)recieveAddress forAmount:(NSInteger)amount fromWalletIdentifier:(NSString *)identifier withPassword:(NSString *)pass withCallback:(void (^)(NSDictionary *res, NSError *err))callback {
    NSString *targetAddress = [NSString stringWithFormat:@"%@%@/payment", [self.class baseAPIUrl], identifier];
    
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
    NSString *targetAddress = [NSString stringWithFormat:@"%@%@/sendmany", [self.class baseAPIUrl], identifier];
    
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
    NSString *targetAddress = [NSString stringWithFormat:@"%@%@/list", [self.class baseAPIUrl], identifier];
    
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
    NSString *targetAddress = [NSString stringWithFormat:@"%@%@/address_balance", [self.class baseAPIUrl], identifier];
    
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
    NSString *targetAddress = [NSString stringWithFormat:@"%@%@/new_address", [self.class baseAPIUrl], identifier];
    
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

@end
