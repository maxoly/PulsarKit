//
//  PLKSectionDescriptor.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 30/09/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

@import Foundation;

@protocol PLKSizeStrategy;

typedef NS_OPTIONS(NSInteger, PLKSectionKind)
{
    PLKSectionKindHeader = 1 << 0,
    PLKSectionKindFooter = 1 << 1,
    PLKSectionKindTop = 1 << 2,
    PLKSectionKindBottom =1 << 3
};


@protocol PLKSectionDescriptor <NSObject>

@property (nonatomic, readonly, copy) NSString *key;
@property (nonatomic, readonly, assign) PLKSectionKind kind;
@property (nonatomic, readonly, assign) Class modelClass;
@property (nonatomic, readonly, assign) Class sectionClass;
@property (nonatomic, readonly, strong) id<PLKSizeStrategy> sizeStrategy;

@end
