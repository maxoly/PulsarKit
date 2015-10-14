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

#import "PLKSectionDescriptor.h"


/**
 * Forward declarations.
 */
@class PLKSections;



/**
 *  Protocols.
 */
@protocol PLKView;
@protocol PLKCellHandler;
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
typedef void (^PLKSourceCellConfigurationBlock)(id<PLKView> cell);

/**
 *  Data provider block.
 *
 *  @param direction Scroll direction.
 */
typedef void (^PLKSourceDataProviderBlock)(PLKDirection direction);

/**
 *  Container did scroll block
 *
 *  @param scrollView The scroll view.
 */
typedef void(^PLKSourceDidScrollBlock)(UIScrollView *scrollView);



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
 *  Did scroll.
 */
@property (nonatomic, readwrite, copy) PLKSourceDidScrollBlock onDidScroll;

/**
 *  Did end decelerating
 */
@property (nonatomic, readwrite, copy) PLKSourceDidScrollBlock onDidEndDecelerating;

/**
 *  Cell configuration block.
 */
@property (nonatomic, readwrite, copy) PLKSourceCellConfigurationBlock onCellConfiguration;

/**
 *  Cell configuration block.
 */
@property (nonatomic, readwrite, copy) PLKSourceCellConfigurationBlock onBeforeCellConfiguration;
/**
 *  Cell configuration block.
 */
@property (nonatomic, readwrite, copy) PLKSourceCellConfigurationBlock onAfterCellConfiguration;

/**
 *  Scroll options
 */
@property (nonatomic, readwrite, assign) PLKSourceScrollOptions scrollOptions;

/**
 *  Update container with data.
 */
- (void)update;

/**
 *  Set the Top or Bottom container section.
 *
 *  @param sectionDescriptor The sectin descriptor.
 */
- (void)setContainerSectionDescriptor:(id<PLKSectionDescriptor>)sectionDescriptor;

/**
 *  Show or hide the container section.
 *
 *  @param show Show or hide boolean.
 */
- (void)showOrHideContainerSectionOfKind:(PLKSectionKind)kind show:(BOOL)show;

/**
 *  Register a cell descriptor.
 *
 *  @param cellDescriptor The cell descriptor.
 */
- (void)registerCellDescriptor:(id<PLKCellDescriptor>)cellDescriptor;

/**
 *  Register a cell handelr.
 *
 *  @param cellHandler The cell handler.
 */
- (void)registerCellHandler:(id<PLKCellHandler>)cellHandler;

/**
 *  Register a section descriptor;
 *
 *  @param sectionDescriptor The section descriptor.
 */
- (void)registerSectionDescriptor:(id<PLKSectionDescriptor>)sectionDescriptor;

/**
 *  Set data provider block
 *
 *  @param dataProviderBlock The data provider block.
 */
- (void)setDataProvider:(PLKSourceDataProviderBlock)dataProviderBlock;

@end