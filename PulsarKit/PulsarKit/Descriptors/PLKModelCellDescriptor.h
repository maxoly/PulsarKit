//
//  PLKModelCellDescriptor.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKCellDescriptor.h"


@interface PLKModelCellDescriptor : NSObject<PLKCellDescriptor>

@property (nonatomic, readwrite, assign) Class modelClass;
@property (nonatomic, readwrite, assign) Class cellClass;
@property (nonatomic, readwrite, assign) BOOL storyboard;
@property (nonatomic, readwrite, strong) id<PLKSizeStrategy> sizeStrategy;

+ (instancetype)descriptorWithCellClass:(Class)cellClass;
+ (instancetype)descriptorWithCellClass:(Class)cellClass forModelClass:(Class)modelClass;
+ (instancetype)descriptorWithCellClass:(Class)cellClass forModelClass:(Class)modelClass sizeStrategy:(id<PLKSizeStrategy>)sizeStrategy;
+ (instancetype)descriptorWithCellClass:(Class)cellClass sizeStrategy:(id<PLKSizeStrategy>)sizeStrategy;

@end
