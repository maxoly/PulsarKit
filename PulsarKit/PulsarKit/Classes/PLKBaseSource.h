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
@property (nonatomic, readwrite, assign, getter = isFirstTime) BOOL firstTime;

/**
 *   Unavailable init.
 *
 *  @return Nothing :)
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 *  Initialize source with a generic container.
 *
 *  @param container The generic container.
 *
 *  @return A new instance of source.
 */
- (instancetype)initWithContainer:(UIScrollView *)container;

/**
 *  Loads data into container.
 */
- (void)loadData NS_REQUIRES_SUPER;

/**
 *  Configures the container. Override this method to perform additional initialization on a specific container.
 */
- (void)configureContainer;

// Cell methods
- (id<PLKCellBuilder>)builderAtIndexPath:(NSIndexPath *)indexPath;
- (id<PLKSizeStrategy>)strategyAtIndexPath:(NSIndexPath *)indexPath;
- (id)entityAtIndexPath:(NSIndexPath *)indexPath;

// to override
- (void)registerNibForCellClass:(Class)cellClass;
- (void)registerClassForCellClass:(Class)cellClass;

@end
