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
#import "PLKSectionDescriptor.h"

@import UIKit;
@import Foundation;


@class PLKSections;
@class PLKCellBuilder;

@protocol PLKView;
@protocol PLKSizeStrategy;
@protocol PLKCellDescriptor;



/**
 *  Source abstract class.
 */
@interface PLKBaseSource : NSObject <PLKSource, UIScrollViewDelegate>

// properties
@property (nonatomic, readonly, strong) NSCache *sectionsCache;
@property (nonatomic, readonly, strong) UIScrollView *container;
@property (nonatomic, readonly, strong) PLKSections *sections;
@property (nonatomic, readonly, strong) PLKCellBuilder *cellBuilder;
@property (nonatomic, readwrite, weak) id<PLKSourceDelegate> delegate;
@property (nonatomic, readwrite, assign) PLKDirection lastDirection;
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
 *  Load data for specific direction.
 *
 *  @param direction The direction.
 */
- (void)loadDataWithDirection:(PLKDirection)direction;

/**
 *  Loads data into container.
 */
- (void)update NS_REQUIRES_SUPER;

/**
 *  Prepares the container. Override this method to perform additional initialization on a specific container.
 */
- (void)prepareContainer NS_REQUIRES_SUPER;

/**
 *  Return the cell at a given indexpath.
 *
 *  @param indexPath The index path.
 *
 *  @return The cell at indexpath.
 */
- (id<PLKView>)cellAtIndexPath:(NSIndexPath *)indexPath;


// helper methods
- (id)modelAtIndexPath:(NSIndexPath *)indexPath;
- (NSArray *)cellHandlersAtIndexPath:(NSIndexPath *)indexPath;
- (id<PLKCellDescriptor>)cellDescriptorAtIndexPath:(NSIndexPath *)indexPath;
- (id<PLKSectionDescriptor>)sectionDescriptorInSection:(NSInteger)section ofKind:(PLKSectionKind)kind;

// cell and section life'cycle
- (void)prepareView:(id<PLKView>)view atIndexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER;
- (void)willDisplayView:(id<PLKView>)view atIndexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER;
- (void)configureSection:(id<PLKView>)view atIndexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER;
- (void)didSelectView:(id<PLKView>)view atIndexPath:(NSIndexPath *)indexPath NS_REQUIRES_SUPER;

// to override
- (void)registerNibForCellClass:(Class)cellClass;
- (void)registerClassForCellClass:(Class)cellClass;
- (void)registerSupplementaryViewClass:(Class)viewClass ofKind:(PLKSectionKind)kind;
- (void)registerSupplementaryNibForViewClass:(Class)viewClass ofKind:(PLKSectionKind)kind;

@end
