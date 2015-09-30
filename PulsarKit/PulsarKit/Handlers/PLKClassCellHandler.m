//
//  PLKClassCellHandler.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 15/09/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

#import "PLKClassCellHandler.h"

#import "PLKView.h"

@implementation PLKClassCellHandler

#pragma mark - PLKCellHandler

- (BOOL)canHandleCell:(id<PLKView>)cell model:(id)model atIndexPath:(NSIndexPath *)indexPath {
    return [cell isKindOfClass:self.cellClass];
}

- (void)handleCell:(id<PLKView>)cell model:(id)model atIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:self.cellClass]) {
        if (self.block) {
            self.block(cell, model, indexPath);
        }
    }
}

#pragma mark - Convenient Constructors

+ (instancetype)handlerForCellClass:(Class)cellClass withBlock:(PLKClassCellHandlerBlock)block {
    PLKClassCellHandler *handler = [[self alloc] init];
    handler.cellClass = cellClass;
    handler.block = block;
    return handler;
}

@end
