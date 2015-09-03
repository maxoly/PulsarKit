//
//  PLKDynamicCellDescriptor.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 02/09/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKCellDescriptor.h"

@interface PLKDynamicCellDescriptor : NSObject<PLKCellDescriptor>

@property (nonatomic, readwrite, assign) Class modelClass;
@property (nonatomic, readwrite, assign) Class cellClass;
@property (nonatomic, readwrite, assign) BOOL storyboard;
@property (nonatomic, readonly, strong) id<PLKSizeStrategy> sizeStrategy;

- (void)useCellDescriptor:(id<PLKCellDescriptor>)cellDescriptor whenValueOfKeyPath:(NSString *)keyPath isEqualTo:(id)value;
- (id<PLKCellDescriptor>)cellDescriptorForModel:(id)model;

+ (instancetype)descriptorForModelClass:(Class)modelClass;

@end
