//
//  PLKItem.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

@import Foundation;

@class PLKCellDescriptor;

@interface PLKItem : NSObject

@property (nonatomic, readwrite, strong) id entity;
@property (nonatomic, readwrite, strong) PLKCellDescriptor *descriptor;

+ (instancetype)itemWithEntity:(id)entity;

@end
