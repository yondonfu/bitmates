//
//  BMManager.h
//  Bitmates
//
//  Created by Yondon Fu on 10/10/15.
//  Copyright © 2015 calhackssquad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMManager : NSObject

- (void)makeOutgoingPaymentTo:(NSString *)recieveAddress forAmount:(NSInteger)amount fromWalletIdentifier:(NSString *)identifier withPassword:(NSString *)pass withCallback:(void (^)(NSDictionary *, NSError *))callback;

@end
