//
//  PLKCellDescriptor.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 02/09/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

@import Foundation;

@protocol PLKSizeStrategy;

@protocol PLKCellDescriptor <NSObject>

@property (nonatomic, readonly, assign) Class modelClass;
@property (nonatomic, readonly, assign) Class cellClass;
@property (nonatomic, readonly, assign) BOOL storyboard;
@property (nonatomic, readonly, strong) id<PLKSizeStrategy> sizeStrategy;

@end
