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
    NSString *targetAddress = [NSString stringWithFormat:@"%@/%@/payment", [self.class baseAPIUrl], identifier];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:pass forKey:@"main_password"];
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

@end
