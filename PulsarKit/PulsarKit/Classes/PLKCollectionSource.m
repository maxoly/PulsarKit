//
//  PLKCollectionSource.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 03/08/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKCollectionSource.h"

// Protocoles
#import "PLKView.h"
#import "PLKCellHandler.h"
#import "PLKCellDescriptor.h"
#import "PLKSectionDescriptor.h"

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
    [super update];
    [self.collectionView reloadData];
    
//    NSIndexSet *addedIndexes = [self.sections addedIndexes];
//    NSArray *addedIndexPaths = [self.sections addedIndexPaths];
//    
//    __weak typeof(self) weakSelf = self;
//    
//    [self.collectionView performBatchUpdates:^{
//        [weakSelf.collectionView insertSections:addedIndexes];
//        [weakSelf.collectionView insertItemsAtIndexPaths:addedIndexPaths];
//    } completion:^(BOOL finished) {
//        [weakSelf.sections resetIndexes];
//    }];
}

#pragma mark - Helpers

- (NSString *)kindStringFromKind:(PLKSectionKind)kind {
    switch (kind) {
        case PLKSectionKindHeader:
            return UICollectionElementKindSectionHeader;
            break;
            
        case PLKSectionKindFooter:
            return UICollectionElementKindSectionFooter;
            
        default:
            return nil;
    }
}

- (PLKSectionKind)sectionKindFormString:(NSString *)kind {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        return PLKSectionKindHeader;
    }
    
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        return PLKSectionKindFooter;
    }
    
    return PLKSectionKindHeader | PLKSectionKindFooter;
}

- (CGSize)sizeForSupplementaryViewInSection:(NSInteger)section ofKind:(PLKSectionKind)kind {
    id<PLKSectionDescriptor> sectionDescriptor = [super sectionDescriptorInSection:section ofKind:kind];
    
    if (!sectionDescriptor) {
        return CGSizeZero;
    }
    
    if (!sectionDescriptor.kind == kind) {
        return CGSizeZero;
    }
    
    UIView *sectionView = [self.cellsCache objectForKey:[sectionDescriptor.sectionClass plk_className]];
    
    if (!sectionView) {
        sectionView = [sectionDescriptor.sectionClass plk_viewFromNibOrClass];
        [self.cellsCache setObject:sectionView forKey:[sectionDescriptor.sectionClass plk_className]];
    }
    
    id<PLKSizeStrategy> sizeStrategy = sectionDescriptor.sizeStrategy;
    return [sizeStrategy sizeForModel:nil withView:nil inContainer:self.collectionView];
}

#pragma mark - Cell/Supplementary View Registration

- (void)registerNibForCellClass:(Class)cellClass {
    [self.collectionView registerNib:[cellClass plk_nibFromClassName] forCellWithReuseIdentifier:[cellClass plk_className]];
}

- (void)registerClassForCellClass:(Class)cellClass {
    [self.collectionView registerClass:cellClass forCellWithReuseIdentifier:[cellClass plk_className]];
}

- (void)registerSupplementaryViewClass:(Class)viewClass ofKind:(PLKSectionKind)kind {
    [self.collectionView registerClass:viewClass forSupplementaryViewOfKind:[self kindStringFromKind:kind] withReuseIdentifier:[viewClass plk_className]];
}

- (void)registerSupplementaryNibForViewClass:(Class)viewClass ofKind:(PLKSectionKind)kind {
    [self.collectionView registerNib:[viewClass plk_nibFromClassName] forSupplementaryViewOfKind:[self kindStringFromKind:kind] withReuseIdentifier:[viewClass plk_className]];
}

- (id<PLKView>)cellAtIndexPath:(NSIndexPath *)indexPath {
    return (id<PLKView>) [self.collectionView cellForItemAtIndexPath:indexPath];
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
    UICollectionViewCell<PLKView> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[cellDescriptor.cellClass plk_className] forIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    PLKSectionKind sectionKind = [self sectionKindFormString:kind];
    id<PLKSectionDescriptor> sectionDescriptor = [super sectionDescriptorInSection:indexPath.section ofKind:sectionKind];
    if (sectionDescriptor) {
        UICollectionReusableView *sectionView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                   withReuseIdentifier:[sectionDescriptor.sectionClass plk_className]
                                                                                          forIndexPath:indexPath];
        return sectionView;
    }
    
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell<PLKView> *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [super configureCell:cell atIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id model = [self modelAtIndexPath:indexPath];
    
    if (self.onDidSelectItem) {
        self.onDidSelectItem(indexPath, model);
    }
    
    id<PLKView> cell = [self cellAtIndexPath:indexPath];
    
    NSArray *handlers = [self cellHandlersAtIndexPath:indexPath];
    [handlers enumerateObjectsUsingBlock:^(id<PLKCellHandler> handler, NSUInteger idx, BOOL *stop) {
        [handler handleCell:cell model:model atIndexPath:indexPath];
    }];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView<PLKView> *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    [super configureSection:view atIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    id model = [self modelAtIndexPath:indexPath];
    id<PLKCellDescriptor> cellDescriptor = [self cellDescriptorAtIndexPath:indexPath];
    id<PLKSizeStrategy> sizeStrategy = cellDescriptor.sizeStrategy;
    
    UIView<PLKView> *cell = [self.cellsCache objectForKey:[cellDescriptor.cellClass plk_className]];
    if (!cell) {
        cell = [cellDescriptor.cellClass plk_viewFromNibOrClass];
        [self.cellsCache setObject:cell forKey:[cellDescriptor.cellClass plk_className]];
    }
    
    CGSize size = [sizeStrategy sizeForModel:model withView:cell inContainer:collectionView];
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return [self sizeForSupplementaryViewInSection:section
                                            ofKind:[self sectionKindFormString:UICollectionElementKindSectionHeader]];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return [self sizeForSupplementaryViewInSection:section
                                            ofKind:[self sectionKindFormString:UICollectionElementKindSectionFooter]];
}

@end