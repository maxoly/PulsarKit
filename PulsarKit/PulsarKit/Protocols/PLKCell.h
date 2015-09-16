//
//  PLKCell.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 06/02/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

@import Foundation;
@import CoreGraphics;



@protocol PLKCell <NSObject>

@optional

/**
 *  Configure cell content.
 *
 *  @param model The model.
 */
- (void)configureWithModel:(id)model;

/**
 *  Prepare for layout.
 *
 *  @param bounds The container bounds.
 *  @param model  The model.
 */
- (void)prepareForLayoutWithModel:(id)model inBounds:(CGRect)bounds;

/**
 *  Cell size.
 *
 *  @return The cell size.
 */
- (CGSize)cellSize;

/**
 *  Cell size.
 *
 *  @return The cell size.
 */
+ (CGSize)cellSize;

@end
