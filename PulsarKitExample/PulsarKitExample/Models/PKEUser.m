//
//  PKEUser.m
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 02/04/15.
//  Copyright (c) 2015 Massimo Oliviero. All rights reserved.
//

#import "PKEUser.h"

@implementation PKEUser

+ (instancetype)userWithName:(NSString *)name {
    PKEUser *user = [[self alloc] init];
    user.name = name;
    return user;
}

@end
