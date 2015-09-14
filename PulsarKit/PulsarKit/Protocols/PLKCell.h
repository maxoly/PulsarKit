//
//  PLKCell.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 06/02/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

@import Foundation;

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
- (void)prepareForLayoutInBounds:(CGRect)bounds model:(id)model;

@end
