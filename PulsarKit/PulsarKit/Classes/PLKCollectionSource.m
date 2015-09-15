//
//  PLKCollectionSource.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 03/08/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKCollectionSource.h"

// Protocoles
#import "PLKCell.h"
#import "PLKCellHandler.h"
#import "PLKCellDescriptor.h"

// Models
#import "PLKSection.h"
#import "PLKSections.h"
#import "PLKSectionView.h"
#import "PLKSizeStrategy.h"

// Categories
#import "NSObject+PulsarKit.h"
#import "UIView+PulsarKit.h"



/**
 * Implementation
 */
@implementation PLKCollectionSource

#pragma mark - Inits

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView {
    self = [super initWithContainer:collectionView];
    if (self) {
        _collectionView = collectionView;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = YES;
        _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    
    return self;
}

- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

#pragma mark - Load

- (void)loadData {
    [super loadData];
}

- (void)configureContainer {
}

- (void)update {
    [self.collectionView reloadData];
}

#pragma mark - Cell Registration

- (void)registerNibForCellClass:(Class)cellClass {
    [self.collectionView registerNib:[cellClass plk_nibFromClassName] forCellWithReuseIdentifier:[cellClass plk_className]];
}

- (void)registerClassForCellClass:(Class)cellClass {
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:[cellClass plk_className]];
}

- (id<PLKCell>)cellAtIndexPath:(NSIndexPath *)indexPath {
    return (id<PLKCell>) [self.collectionView cellForItemAtIndexPath:indexPath];
}

#pragma mark - UICollecitonViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sections[section].items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id<PLKCellDescriptor> cellDescriptor = [self cellDescriptorAtIndexPath:indexPath];
    UICollectionViewCell<PLKCell> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[cellDescriptor.cellClass plk_className] forIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell<PLKCell> *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [super configureCell:cell atIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id model = [self modelAtIndexPath:indexPath];
    
    if (self.onDidSelectItem) {
        self.onDidSelectItem(indexPath, model);
    }
    
    id<PLKCell> cell = [self cellAtIndexPath:indexPath];
    
    NSArray *handlers = [self cellHandlersAtIndexPath:indexPath];
    [handlers enumerateObjectsUsingBlock:^(id<PLKCellHandler> handler, NSUInteger idx, BOOL *stop) {
        [handler handleCell:cell model:model atIndexPath:indexPath];
    }];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    id model = [self modelAtIndexPath:indexPath];
    id<PLKCellDescriptor> cellDescriptor = [self cellDescriptorAtIndexPath:indexPath];
    id<PLKSizeStrategy> sizeStrategy = cellDescriptor.sizeStrategy;
    
    UIView<PLKCell> *cell = [self.cellsCache objectForKey:[cellDescriptor.cellClass plk_className]];
    if (!cell) {
        cell = [cellDescriptor.cellClass plk_viewFromNibOrClass];
        [self.cellsCache setObject:cell forKey:[cellDescriptor.cellClass plk_className]];
    }
    
    CGSize size = [sizeStrategy sizeForModel:model withCell:cell inContainer:collectionView];
    return size;
}

@end
