//
//  PLKClassCellHandler.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 15/09/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

#import "PLKCellHandler.h"



/**
 *  Block.
 *
 *  @param cell      The cell.
 *  @param model     The model.
 *  @param indexPath The index path.
 */
typedef void(^PLKClassCellHandlerBlock)(id<PLKCell> cell, id model, NSIndexPath *indexPath);



/**
 * Defines a cell handler.
 */
@interface PLKClassCellHandler : NSObject<PLKCellHandler>

@property (nonatomic, readwrite, copy) PLKClassCellHandlerBlock block;
@property (nonatomic, readwrite, assign) Class cellClass;

+ (instancetype)handlerForCellClass:(Class)cellClass withBlock:(PLKClassCellHandlerBlock)block;

@end
