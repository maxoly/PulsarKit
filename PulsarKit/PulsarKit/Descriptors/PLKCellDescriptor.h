//
//  PLKCellDescriptor.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

@import Foundation;

@protocol PLKCellBuilder;
@protocol PLKSizeStrategy;

@interface PLKCellDescriptor : NSObject

@property (nonatomic, readwrite, assign) Class model;
@property (nonatomic, readwrite, strong) id<PLKCellBuilder> builder;
@property (nonatomic, readwrite, strong) id<PLKSizeStrategy> strategy;

+ (instancetype)cellDescriptorWithModel:(Class)model builder:(id<PLKCellBuilder>)builder strategy:(id<PLKSizeStrategy>)strategy;

@end
