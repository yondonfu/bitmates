//
//  Bitmates.m
//  Bitmates
//
//  Created by Yondon Fu on 10/10/15.
//  Copyright © 2015 calhackssquad. All rights reserved.
//

#import "Bitmates.h"
#import "BMManager.h"
#import "BMWallet.h"

@implementation Bitmates

static BMManager *currentBMManager;

+ (void)setAPIId:(NSString *)apiId andAPISecret:(NSString *)apiSecret {
    BMManager *manager = [[BMManager alloc] initWithApiId:apiId andApiSecret:apiSecret];
    
    currentBMManager = manager;
}

+ (BMManager *)currentManager {
    return currentBMManager;
}

+ (void)clearCurrentManager {
    currentBMManager = nil;
}

@end
