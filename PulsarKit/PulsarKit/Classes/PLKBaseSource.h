//
//  PLKBaseSource.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 06/02/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

/**
 *  Imports
 */

#import "PLKSource.h"

@import UIKit;
@import Foundation;


@protocol PLKCellBuilder;
@protocol PLKSizeStrategy;


@class PLKSections;
@class PLKCellDescriptor;


/**
 *  Source abstract class.
 */
@interface PLKBaseSource : NSObject <PLKSource>

// properties
@property (nonatomic, readonly, strong) NSCache *cellCache;
@property (nonatomic, readonly, strong) UIScrollView *container;
@property (nonatomic, readonly, strong) PLKSections *sections;
@property (nonatomic, readwrite, strong) NSMutableDictionary *descriptors;
@property (nonatomic, readwrite, strong) NSObject<PLKProvider> *provider;
@property (nonatomic, readwrite, copy) PLKSourceDidSelectItemBlock onDidSelectItem;
@property (nonatomic, readwrite, assign) PLKSourceScrollOptions scrollOptions;

// inits
- (instancetype)init __unavailable;
- (instancetype)initWithContainer:(UIScrollView *)container;

// loading
- (void)loadData __attribute__((objc_requires_super));

- (void)registerCellDescriptor:(PLKCellDescriptor *)cellDescriptor;

// override
- (void)configureContainer;



// Cell methods
- (id<PLKCellBuilder>)builderAtIndexPath:(NSIndexPath *)indexPath;
- (id<PLKSizeStrategy>)strategyAtIndexPath:(NSIndexPath *)indexPath;
- (id)entityAtIndexPath:(NSIndexPath *)indexPath;

@end
