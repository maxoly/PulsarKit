//
//  PKEUser.h
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 02/04/15.
//  Copyright (c) 2015 Massimo Oliviero. All rights reserved.
//

@import Foundation;

@interface PKEUser : NSObject

@property (nonatomic, readwrite, copy) NSString *name;

+ (instancetype)userWithName:(NSString *)name;

@end
