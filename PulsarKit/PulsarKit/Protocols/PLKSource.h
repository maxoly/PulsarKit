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

#import "PLKSourceDelegate.h"
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
 *  Container inset.
 */
@property (nonatomic, readonly, assign) UIEdgeInsets containerInset;


/**
 *  Container's sections.
 */
@property (nonatomic, readonly, strong) PLKSections *sections;

/**
 *  Source delegate.
 */
@property (nonatomic, readwrite, weak) id<PLKSourceDelegate> delegate;

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