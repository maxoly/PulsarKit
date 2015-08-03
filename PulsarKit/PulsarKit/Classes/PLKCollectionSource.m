//
//  PLKCollectionSource.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 03/08/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKCollectionSource.h"

#import "PLKCell.h"
#import "PLKSection.h"
#import "PLKSections.h"
#import "PLKSectionView.h"

#import "NSObject+PulsarKit.h"
#import "UIView+PulsarKit.h"

#import "PLKCellBuilder.h"
#import "PLKSizeStrategy.h"
#import "PLKCellDescriptor.h"
#import "PLKCollectionViewCellBuilder.h"



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

#pragma mark - Descriptor

- (PLKCellDescriptor *)registerCellDescriptorForCellClass:(Class)cellClass modelClass:(Class)model sizeStrategy:(id<PLKSizeStrategy>)strategy {
    id<PLKCellBuilder> builder = [PLKCollectionViewCellBuilder builderWithCellClass:cellClass];
    PLKCellDescriptor *descriptor = [PLKCellDescriptor cellDescriptorWithModel:model builder:builder strategy:strategy];
    return [self registerCellDescriptor:descriptor];
}

#pragma mark - UICollecitonViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sections[section].items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id entity = [self entityAtIndexPath:indexPath];
    id<PLKCellBuilder> builder = [self builderAtIndexPath:indexPath];
    return [builder cellForEntity:entity inContainer:collectionView atIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.onDidSelectItem) {
        id entity = [self entityAtIndexPath:indexPath];
        self.onDidSelectItem(indexPath, entity);
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    id entity = [self entityAtIndexPath:indexPath];
    id<PLKSizeStrategy> strategy = [self strategyAtIndexPath:indexPath];
    id<PLKCellBuilder> builder = [self builderAtIndexPath:indexPath];
    
    CGSize size = [strategy sizeForEntity:entity inContainer:collectionView atIndexPath:indexPath builder:builder];
    return size;
}

@end
