//
//  PLKNumberOfCellsSize.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 30/10/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

#import "PLKNumberOfCellsSize.h"

#import "PLKView.h"
#import "PLKSource.h"
#import "PLKSections.h"

typedef NS_ENUM(NSInteger, PLKNumberOfCellsSizeType) {
    PLKNumberOfCellsSizeTypeWidth,
    PLKNumberOfCellsSizeTypeHeight
};


@interface PLKNumberOfCellsSize ()

@property (nonatomic, readwrite, assign) PLKNumberOfCellsSizeType type;
@property (nonatomic, readwrite, assign) CGFloat fixedValue;

@end



@implementation PLKNumberOfCellsSize

#pragma mark - PLKSizeStrategy

- (CGSize)sizeForModel:(id)model withCellBuilder:(PLKCellBuilder *)cellBuilder forSource:(id<PLKSource>)source {
    switch (self.type) {
        case PLKNumberOfCellsSizeTypeWidth: {
            CGFloat width = CGRectGetWidth(source.container.frame) / source.sections.models.count;
            return CGSizeMake(width, self.fixedValue);
        }
            break;
            
        case PLKNumberOfCellsSizeTypeHeight: {
            CGFloat height = CGRectGetHeight(source.container.frame) / source.sections.models.count;
            return CGSizeMake(self.fixedValue, height);
        }
            break;
    }
    
    return CGSizeZero;
}

#pragma mark - Convenient Constructors

+ (instancetype)numberOfCellsForWidthAndFixedHeight:(CGFloat)height {
    PLKNumberOfCellsSize *strategy = [[self alloc] init];
    strategy.type = PLKNumberOfCellsSizeTypeWidth;
    strategy.fixedValue = height;
    return strategy;
}

+ (instancetype)numberOfCellsForHeightAndFixedWidth:(CGFloat)width {
    PLKNumberOfCellsSize *strategy = [[self alloc] init];
    strategy.type = PLKNumberOfCellsSizeTypeHeight;
    strategy.fixedValue = width;
    return strategy;
}

@end
