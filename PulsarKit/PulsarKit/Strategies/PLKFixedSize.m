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

- (CGSize)sizeForModel:(id)model withCell:(UIView<PLKCell> *)cell inContainer:(UIScrollView *)container {
    return self.size;
}

+ (instancetype)fixedSize:(CGSize)size {
    PLKFixedSize *fixedSize = [[PLKFixedSize alloc] init];
    fixedSize.size = size;
    return fixedSize;
}

@end
