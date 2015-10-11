//
//  Bitmates.h
//  Bitmates
//
//  Created by Yondon Fu on 10/10/15.
//  Copyright © 2015 calhackssquad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMManager.h"

@interface Bitmates : NSObject

+ (void)setUp;
+ (BMManager *)currentManager;
+ (void)clearCurrentManager;

@end
