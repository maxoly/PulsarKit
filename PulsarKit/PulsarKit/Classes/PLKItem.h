//
//  PLKItem.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

@import Foundation;

@protocol PLKCellDescriptor;



@interface PLKItem : NSObject

@property (nonatomic, readwrite, strong) id model;
@property (nonatomic, readwrite, strong) id<PLKCellDescriptor> cellDescriptor;

+ (instancetype)itemWithModel:(id)model;
+ (instancetype)itemWithModel:(id)model cellDescriptor:(id<PLKCellDescriptor>)cellDescriptor ;

@end
