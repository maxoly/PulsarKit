//
//  PLKModelCellHandler.h
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
typedef void(^PLKModelCellHandlerBlock)(id<PLKView> cell, id model, NSIndexPath *indexPath);



/**
 * Defines a cell handler.
 */
@interface PLKModelCellHandler : NSObject<PLKCellHandler>

@property (nonatomic, readwrite, copy) PLKModelCellHandlerBlock block;
@property (nonatomic, readwrite, weak) id model;

+ (instancetype)handlerForModel:(id)model withBlock:(PLKModelCellHandlerBlock)block;

@end
