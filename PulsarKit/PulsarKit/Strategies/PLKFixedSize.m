//
//  PLKFixedSize.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKFixedSize.h"

@interface PLKFixedSize ()

@property (nonatomic, readwrite, assign) CGSize size;

@end

@implementation PLKFixedSize

- (CGSize)sizeForEntity:(id)entity inContainer:(UIScrollView *)container atIndexPath:(NSIndexPath *)indexPath builder:(id<PLKCellBuilder>)builder {
    return self.size;
}

+ (instancetype)fixedSize:(CGSize)size {
    PLKFixedSize *fixedSize = [[PLKFixedSize alloc] init];
    fixedSize.size = size;
    return fixedSize;
}

@end
