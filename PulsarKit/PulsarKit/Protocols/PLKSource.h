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

/**
 *  Protocols.
 */
@protocol PLKProvider;

/**
 *  Did select row block.
 *
 *  @param indexPath The index path.
 *  @param item      The item.
 */
typedef void (^PLKSourceDidSelectItemBlock)(NSIndexPath *indexPath, id entity);

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
     *  Scoll.
     */
    PLKSourceScrollOptionNone               = 1 <<  0,

    /**
    *  Scroll
    */
    PLKSourceScrollOptionInfiniteOnTop      = 1 <<  1,

    /**
    *  Scroll.
    */
    PLKSourceScrollOptionInfiniteOnBottom   = 1 <<  2
};


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
 *  Data provider.
 */
@property (nonatomic, readwrite, strong) NSObject<PLKProvider> *provider;

/**
 *  Did Select item/row block.
 */
@property (nonatomic, readwrite, copy) PLKSourceDidSelectItemBlock onDidSelectItem;

/**
 *  Scroll options
 */
@property (nonatomic, readwrite, assign) PLKSourceScrollOptions scrollOptions;

/**
 *  Load data into the container.
 */
- (void)loadData;

@end



/*
   [PLKConfigurator configuratorWithBuilder:[PLKTableViewCellBuilder builderWithCellClass:[UITableViewCell class]]
                                    model:[PLKUser class]
                            sizeStrategy:[PLKAutolayoutStrategy strategy]];


   - (UITableViewCell<PLKCell> *)cellAtIndexPath:(NSIndexPath *)indexPath forEntity:(id)entity inContainer:(UIScrollView *)container;

 */
