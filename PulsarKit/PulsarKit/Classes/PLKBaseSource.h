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


@class PLKSections;

@protocol PLKCell;
@protocol PLKSizeStrategy;
@protocol PLKCellDescriptor;



/**
 *  Source abstract class.
 */
@interface PLKBaseSource : NSObject <PLKSource>

// properties
@property (nonatomic, readonly, strong) NSCache *cellsCache;
@property (nonatomic, readonly, strong) UIScrollView *container;
@property (nonatomic, readonly, strong) PLKSections *sections;
@property (nonatomic, readwrite, assign) PLKSourceScrollOptions scrollOptions;
@property (nonatomic, readwrite, assign, getter = isFirstTime) BOOL firstTime;
@property (nonatomic, readwrite, copy) PLKSourceCellConfigurationBlock onCellConfiguration;
@property (nonatomic, readwrite, copy) PLKSourceCellConfigurationBlock onBeforeCellConfiguration;
@property (nonatomic, readwrite, copy) PLKSourceCellConfigurationBlock onAfterCellConfiguration;
@property (nonatomic, readwrite, copy) PLKSourceDidSelectItemBlock onDidSelectItem;

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
 *  Prepares the container. Override this method to perform additional initialization on a specific container.
 */
- (void)prepareContainer;

/**
 *  Return the cell at a given indexpath.
 *
 *  @param indexPath The index path.
 *
 *  @return The cell at indexpath.
 */
- (id<PLKCell>)cellAtIndexPath:(NSIndexPath *)indexPath;

// helper methods
- (id)modelAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)cellHandlersAtIndexPath:(NSIndexPath *)indexPath;
- (id<PLKCellDescriptor>)cellDescriptorAtIndexPath:(NSIndexPath *)indexPath;

// to override
- (void)registerNibForCellClass:(Class)cellClass;
- (void)registerClassForCellClass:(Class)cellClass;
- (void)configureCell:(UIView<PLKCell> *)cell atIndexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER;

@end
