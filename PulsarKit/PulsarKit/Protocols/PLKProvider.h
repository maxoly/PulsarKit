//
//  PLKProvider.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 06/02/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

@import Foundation;

/**
 *  Success block definition.
 *
 *  @param items The items array.
 */
typedef void (^PLKProviderCompletionBlock)();

/**
 *  Define a provider protocol.
 */
@protocol PLKProvider <NSObject>

- (void)source:(id<PLKSource>)source itemsForDirection:(PLKDirection)direction;

@end
