//
//  PLKCellSize.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 16/09/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

#import "PLKCellSize.h"

#import "PLKcell.h"

@implementation PLKCellSize

- (CGSize)sizeForModel:(id)model withCell:(UIView<PLKCell> *)cell inContainer:(UIScrollView *)container {
    if ([cell respondsToSelector:@selector(cellSize)]) {
        return [cell cellSize];
    }
    
    if ([[cell class] resolveClassMethod:@selector(cellSize)]) {
        return [[cell class] cellSize];
    }
    
    return CGSizeZero;
}

@end
