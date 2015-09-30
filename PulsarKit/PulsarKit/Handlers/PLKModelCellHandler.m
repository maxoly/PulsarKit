//
//  PLKModelCellHandler.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 15/09/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

#import "PLKModelCellHandler.h"

@implementation PLKModelCellHandler

#pragma mark - PLKCellHandler

- (BOOL)canHandleCell:(id<PLKView>)cell model:(id)model atIndexPath:(NSIndexPath *)indexPath {
    return [self.model isEqual:model];
}

- (void)handleCell:(id<PLKView>)cell model:(id)model atIndexPath:(NSIndexPath *)indexPath {
    if ([self.model isEqual:model]) {
        if (self.block) {
            self.block(cell, model, indexPath);
        }
    }
}

#pragma mark - Convenient Constructors

+ (instancetype)handlerForModel:(id)model withBlock:(PLKModelCellHandlerBlock)block {
    PLKModelCellHandler *handler = [[self alloc] init];
    handler.model = model;
    handler.block = block;
    return handler;
}

@end
