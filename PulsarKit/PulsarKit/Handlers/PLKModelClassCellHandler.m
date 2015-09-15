//
//  PLKModelClassCellHandler.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 15/09/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

#import "PLKModelClassCellHandler.h"

@implementation PLKModelClassCellHandler

#pragma mark - PLKCellHandler

- (BOOL)canHandleCell:(id<PLKCell>)cell model:(id)model atIndexPath:(NSIndexPath *)indexPath {
    return [model isKindOfClass:self.modelClass];
}

- (void)handleCell:(id<PLKCell>)cell model:(id)model atIndexPath:(NSIndexPath *)indexPath {
    if ([model isKindOfClass:self.modelClass]) {
        if (self.block) {
            self.block(cell, model, indexPath);
        }
    }
}

#pragma mark - Convenient Constructors

+ (instancetype)handlerForModelClass:(Class)modelClass withBlock:(PLKModelClassCellHandlerBlock)block {
    PLKModelClassCellHandler *handler = [[self alloc] init];
    handler.modelClass = modelClass;
    handler.block = block;
    return handler;
}

@end
