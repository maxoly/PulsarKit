//
//  PLKDynamicCellDescriptor.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 02/09/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKDynamicCellDescriptor.h"

#import "PLKDynamicCellDescriptorMatcher.h"

@interface PLKDynamicCellDescriptor ()

@property (nonatomic, readwrite, strong) NSMutableDictionary *matchers;

@end

@implementation PLKDynamicCellDescriptor

#pragma mark - Properties

- (NSMutableDictionary *)matchers {
    if (!_matchers) {
        _matchers = [[NSMutableDictionary alloc] init];
    }
    
    return _matchers;
}

#pragma mark - PLKDynamicCellDescriptor

- (void)useCellDescriptor:(id<PLKCellDescriptor>)cellDescriptor whenValueOfKeyPath:(NSString *)keyPath isEqualTo:(id)value{
    self.matchers[value] = [PLKDynamicCellDescriptorMatcher matcherWithCellDescriptor:cellDescriptor keyPath:keyPath value:value];
}

- (id<PLKCellDescriptor>)cellDescriptorForModel:(id)model {
    for (PLKDynamicCellDescriptorMatcher *matcher in self.matchers.allValues) {
        id value = [model valueForKeyPath:matcher.keyPath];
        if ([value isEqual:matcher.value]) {
            return matcher.cellDescriptor;
        }
    }
    
    return nil;
}

#pragma mark - Convenient Constructors

+ (instancetype)descriptorForModelClass:(Class)modelClass {
    PLKDynamicCellDescriptor *cellDescriptor = [[self alloc] init];
    cellDescriptor.modelClass = modelClass;
    return cellDescriptor;
}

@end
