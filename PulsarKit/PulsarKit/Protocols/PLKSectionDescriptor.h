//
//  PLKSectionDescriptor.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 30/09/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

@import Foundation;

@protocol PLKSectionDescriptor <NSObject>

@property (nonatomic, readonly, copy) NSString *key;
@property (nonatomic, readonly, copy) NSString *kind;
@property (nonatomic, readonly, assign) Class modelClass;
@property (nonatomic, readonly, assign) Class sectionClass;
@property (nonatomic, readonly, strong) id<PLKSizeStrategy> sizeStrategy;

@end
