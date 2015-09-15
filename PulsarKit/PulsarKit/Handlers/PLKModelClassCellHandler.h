//
//  PLKModelClassCellHandler.h
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
typedef void(^PLKModelClassCellHandlerBlock)(id<PLKCell> cell, id model, NSIndexPath *indexPath);



/**
 * Defines a cell handler.
 */
@interface PLKModelClassCellHandler : NSObject<PLKCellHandler>

@property (nonatomic, readwrite, copy) PLKModelClassCellHandlerBlock block;
@property (nonatomic, readwrite, assign) Class modelClass;

+ (instancetype)handlerForModelClass:(Class)modelClas withBlock:(PLKModelClassCellHandlerBlock)block;

@end
