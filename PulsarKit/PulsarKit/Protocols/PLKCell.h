//
//  PLKCell.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 06/02/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

@import Foundation;

@protocol PLKCell <NSObject>

- (void)configureWithEntity:(id)entity;

@optional
- (void)configureForLayoutInBounds:(CGRect)bounds;

@end
