//
//  PLKTableViewCellBuilder.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKCellBuilder.h"

@interface PLKTableViewCellBuilder : NSObject <PLKCellBuilder>

@property (nonatomic, readwrite, assign) Class cellClass;

+ (instancetype)builderWithCellClass:(Class)cellClass;

@end
