//
//  PLKPositionalSectionDescriptor.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 30/09/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

#import "PLKSectionDescriptor.h"

@interface PLKPositionalSectionDescriptor : NSObject<PLKSectionDescriptor>

@property (nonatomic, readwrite, copy) NSString *key;
@property (nonatomic, readwrite, assign) PLKSectionKind kind;
@property (nonatomic, readwrite, assign) Class modelClass;
@property (nonatomic, readwrite, assign) Class sectionClass;
@property (nonatomic, readwrite, strong) id<PLKSizeStrategy> sizeStrategy;

+ (instancetype)descriptorOfKind:(PLKSectionKind)kind withSectionClass:(Class)sectionClass;
+ (instancetype)descriptorOfKind:(PLKSectionKind)kind withSectionClass:(Class)sectionClass sizeStrategy:(id<PLKSizeStrategy>)sizeStrategy;
+ (instancetype)descriptorOfKind:(PLKSectionKind)kind forPosition:(NSInteger)position withSectionClass:(Class)sectionClass;
+ (instancetype)descriptorOfKind:(PLKSectionKind)kind forPosition:(NSInteger)position withSectionClass:(Class)sectionClass sizeStrategy:(id<PLKSizeStrategy>)sizeStrategy;

@end
