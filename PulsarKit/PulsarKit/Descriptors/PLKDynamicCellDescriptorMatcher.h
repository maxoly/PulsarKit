//
//  PLKDynamicCellDescriptorMatcher.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 02/09/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

@import Foundation;

@protocol PLKCellDescriptor;

@interface PLKDynamicCellDescriptorMatcher : NSObject

@property (nonatomic, readwrite, strong) id<PLKCellDescriptor> cellDescriptor;
@property (nonatomic, readwrite, copy) NSString *keyPath;
@property (nonatomic, readwrite, copy) NSString *value;

+ (instancetype)matcherWithCellDescriptor:(id<PLKCellDescriptor>)cellDescriptor keyPath:(NSString *)keyPath value:(id)value;

@end
