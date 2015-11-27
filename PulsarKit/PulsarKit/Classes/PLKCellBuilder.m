//
//  PLKCellBuilder.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 27/11/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

#import "PLKCellBuilder.h"

#import "PLKView.h"
#import "PLKCellDescriptor.h"
#import "PLKSectionDescriptor.h"

#import "NSObject+PulsarKit.h"
#import "UIView+PulsarKit.h"

@interface PLKCellBuilder ()

@property (nonatomic, readwrite, strong) NSCache *cellsCache;
@property (nonatomic, readwrite, strong) id<PLKCellDescriptor> cellDescriptor;
@property (nonatomic, readwrite, strong) id<PLKSectionDescriptor> sectionDescriptor;

@end

@implementation PLKCellBuilder

- (NSCache *)cellsCache {
    if (!_cellsCache) {
        _cellsCache = [[NSCache alloc] init];
    }
    
    return _cellsCache;
}

- (void)configureWithCellDescriptor:(id<PLKCellDescriptor>)cellDescriptor {
    self.cellDescriptor = cellDescriptor;
}

- (void)configureWithSectionDescriptor:(id<PLKSectionDescriptor>)sectionDescriptor {
    self.sectionDescriptor = sectionDescriptor;
}

- (UIView<PLKView> *)build {
    UIView<PLKView> *cell = [self.cellsCache objectForKey:[self.cellDescriptor.cellClass plk_className]];
    if (!cell) {
        cell = [self.cellDescriptor.cellClass plk_viewFromNibOrClass];
        [self.cellsCache setObject:cell forKey:[self.cellDescriptor.cellClass plk_className]];
    }
    
    return cell;
}

- (UIView<PLKView> *)buildSection {
    UIView<PLKView> *sectionView = [self.cellsCache objectForKey:[self.sectionDescriptor.sectionClass plk_className]];
    
    if (!sectionView) {
        sectionView = [self.sectionDescriptor.sectionClass plk_viewFromNibOrClass];
        [self.cellsCache setObject:sectionView forKey:[self.sectionDescriptor.sectionClass plk_className]];
    }

    return sectionView;
}

@end
