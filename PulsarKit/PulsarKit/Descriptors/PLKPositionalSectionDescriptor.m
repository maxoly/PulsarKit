//
//  PLKPositionalSectionDescriptor.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 30/09/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

#import "PLKPositionalSectionDescriptor.h"

#import "PLKAutolayoutSize.h"


@implementation PLKPositionalSectionDescriptor

+ (instancetype)descriptorOfKind:(PLKSectionKind)kind withSectionClass:(Class)sectionClass {
    return [self descriptorOfKind:(PLKSectionKind)kind withSectionClass:sectionClass sizeStrategy:[PLKAutolayoutSize autolayoutSize]];
}

+ (instancetype)descriptorOfKind:(PLKSectionKind)kind withSectionClass:(Class)sectionClass sizeStrategy:(id<PLKSizeStrategy>)sizeStrategy {
    return [self descriptorOfKind:(PLKSectionKind)kind forPosition:NSIntegerMax withSectionClass:sectionClass sizeStrategy:sizeStrategy];
}

+ (instancetype)descriptorOfKind:(PLKSectionKind)kind forPosition:(NSInteger)position withSectionClass:(Class)sectionClass {
    return [self descriptorOfKind:(PLKSectionKind)kind forPosition:position withSectionClass:sectionClass sizeStrategy:[PLKAutolayoutSize autolayoutSize]];
}

+ (instancetype)descriptorOfKind:(PLKSectionKind)kind forPosition:(NSInteger)position withSectionClass:(Class)sectionClass sizeStrategy:(id<PLKSizeStrategy>)sizeStrategy {
    PLKPositionalSectionDescriptor *sectionDescriptor = [[self alloc] init];
    sectionDescriptor.sectionClass = sectionClass;
    sectionDescriptor.kind = kind;
    sectionDescriptor.key = [NSString stringWithFormat:@"%zd.%zd", position, kind];
    sectionDescriptor.sizeStrategy = sizeStrategy;
    return sectionDescriptor;
}

@end
