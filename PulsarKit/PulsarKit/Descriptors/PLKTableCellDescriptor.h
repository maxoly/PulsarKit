//
//  PLKTableCellDescriptor.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKCellDescriptor.h"

@interface PLKTableCellDescriptor : PLKCellDescriptor

+ (instancetype)cellDescriptorWithCellClass:(Class)cellClass forModel:(Class)model;

@end
