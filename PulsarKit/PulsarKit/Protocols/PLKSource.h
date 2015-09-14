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

/// Forward declarations
@class PLKSections;


/**
 *  Protocols.
 */
@protocol PLKCell;
@protocol PLKCellDescriptor;

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
typedef void (^PLKSourceDidSelectItemBlock)(NSIndexPath *indexPath, id model);

/**
 *  Cell configuration block.
 *
 *  @param cell The cell.
 */
typedef void (^PLKSourceCellConfigurationBlock)(id<PLKCell> cell);

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
 *  Cell configuration block.
 */
@property (nonatomic, readwrite, copy) PLKSourceCellConfigurationBlock onCellConfiguration;

/**
 *  Scroll options
 */
@property (nonatomic, readwrite, assign) PLKSourceScrollOptions scrollOptions;

/**
 *  Update container with data.
 */
- (void)update;

/**
 *  Register a cell descriptor.
 *
 *  @param cellDescriptor The cell descriptor.
 */
- (void)registerCellDescriptor:(id<PLKCellDescriptor>)cellDescriptor;

/**
 *  Set data provider block
 *
 *  @param dataProviderBlock The data provider block.
 */
- (void)setDataProvider:(PLKSourceDataProviderBlock)dataProviderBlock;

@end