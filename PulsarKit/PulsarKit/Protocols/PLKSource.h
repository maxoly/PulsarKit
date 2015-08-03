//
//  PLKSource.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 06/02/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

/**
 *  Imports
 */
@import UIKit;
@import Foundation;

@class PLKSections;
@class PLKCellDescriptor;

/**
 *  Protocols.
 */
@protocol PLKProvider;
@protocol PLKSizeStrategy;

/**
 * Enum.
 */
typedef NS_ENUM (NSInteger, PLKDirection)
{
    /**
     *  Scoll.
     */
    PLKDirectionNone,

    /**
     *  Scoll.
     */
    PLKDirectionTop,

    /**
     *  Scoll.
     */
    PLKDirectionBottom
};

/**
 *  Scroll options.
 */
typedef NS_OPTIONS (NSInteger, PLKSourceScrollOptions)
{
    /**
     *  None
     */
    PLKSourceScrollOptionNone = 1 << 0,

    /**
    *  Top
    */
    PLKSourceScrollOptionInfiniteOnTop = 1 << 1,

    /**
    *  Bottom
    */
    PLKSourceScrollOptionInfiniteOnBottom = 1 << 2,
    
    /**
    * Left
    */
    PLKSourceScrollOptionInfiniteOnLeft = 1 << 3,
    
    /**
    *  Right
    */
    PLKSourceScrollOptionInfiniteOnRight = 1 << 4
};

/**
 *  Did select row block.
 *
 *  @param indexPath The index path.
 *  @param item      The item.
 */
typedef void (^PLKSourceDidSelectItemBlock)(NSIndexPath *indexPath, id entity);

/**
 *  Data provider block.
 *
 *  @param direction Scroll direction.
 */
typedef void (^PLKSourceDataProviderBlock)(PLKDirection direction);

/**
 *  Define source protocol.
 */
@protocol PLKSource <NSObject>

/**
 *  Source items container.
 */
@property (nonatomic, readonly, strong) UIScrollView *container;

/**
 *  Container's sections.
 */
@property (nonatomic, readonly, strong) PLKSections *sections;

/**
 *  Did Select item/row block.
 */
@property (nonatomic, readwrite, copy) PLKSourceDidSelectItemBlock onDidSelectItem;

/**
 *  Scroll options
 */
@property (nonatomic, readwrite, assign) PLKSourceScrollOptions scrollOptions;

/**
 *  Update container with data.
 */
- (void)update;

/**
 *  Set data provider block
 *
 *  @param dataProviderBlock The data provider block.
 */
- (void)setDataProvider:(PLKSourceDataProviderBlock)dataProviderBlock;

/**
 *  Registers a new cell descriptor.
 *
 *  @param cellDescriptor An instance of PLKCellDescriptor.
 */
- (PLKCellDescriptor *)registerCellDescriptor:(PLKCellDescriptor *)cellDescriptor;

/**
 *  Register a new cell description to the source.
 *
 *  @param cellClass The cell class.
 *  @param model     The model class.
 *  @param strategy  The cell size strategy.
 *
 *  @return A new instance of PLKCellDescriptor.
 */
- (PLKCellDescriptor *)registerCellDescriptorForCellClass:(Class)cellClass modelClass:(Class)model sizeStrategy:(id<PLKSizeStrategy>)strategy;

@end