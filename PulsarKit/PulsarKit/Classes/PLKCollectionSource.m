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
#import "PLKCellBuilder.h"
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
        
        [collectionView registerClass:[UICollectionReusableView class]
           forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                  withReuseIdentifier:[UICollectionReusableView plk_className]];
        
        [collectionView registerClass:[UICollectionReusableView class]
           forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                  withReuseIdentifier:[UICollectionReusableView plk_className]];
        
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
    
    NSIndexSet *addedIndexes = [self.sections addedIndexes];
    NSIndexSet *removedIndexes = [self.sections removedIndexes];
    
    NSArray *addedIndexPaths = [self.sections addedIndexPaths];
    NSArray *removedIndexPaths = [self.sections removedIndexPaths];
    
    __weak typeof(self) weakSelf = self;
    
    [self.collectionView performBatchUpdates:^{
        [weakSelf.collectionView insertSections:addedIndexes];
        [weakSelf.collectionView deleteSections:removedIndexes];
        [weakSelf.collectionView insertItemsAtIndexPaths:addedIndexPaths];
        [weakSelf.collectionView deleteItemsAtIndexPaths:removedIndexPaths];
    } completion:^(BOOL finished) {
        [weakSelf.sections resetIndexes];
    }];
}

#pragma mark - Helpers

- (NSString *)kindStringFromKind:(PLKSectionKind)kind {
    switch (kind) {
        case PLKSectionKindHeader:
            return UICollectionElementKindSectionHeader;
            break;
            
        case PLKSectionKindFooter:
            return UICollectionElementKindSectionFooter;
    }
}

- (PLKSectionKind)sectionKindFormString:(NSString *)kind section:(NSInteger)section {
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
    
    if (sectionDescriptor.kind != kind) {
        return CGSizeZero;
    }
    
    [self.cellBuilder configureWithSectionDescriptor:sectionDescriptor];
    
    id<PLKSizeStrategy> sizeStrategy = sectionDescriptor.sizeStrategy;
    return [sizeStrategy sizeForModel:nil withCellBuilder:self.cellBuilder forSource:self];
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
    [self.sections resetIndexes];
    return self.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sections[section].items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    id<PLKCellDescriptor> cellDescriptor = [self cellDescriptorAtIndexPath:indexPath];
    UICollectionViewCell<PLKView> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[cellDescriptor.cellClass plk_className] forIndexPath:indexPath];
    [super prepareView:cell atIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    PLKSectionKind sectionKind = [self sectionKindFormString:kind section:indexPath.section];
    id<PLKSectionDescriptor> sectionDescriptor = [super sectionDescriptorInSection:indexPath.section ofKind:sectionKind];
    if (sectionDescriptor) {
        if (sectionKind == sectionDescriptor.kind) {
            UICollectionReusableView *sectionView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                       withReuseIdentifier:[sectionDescriptor.sectionClass plk_className]
                                                                                              forIndexPath:indexPath];
            return sectionView;
        }
    }
    
    return [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                              withReuseIdentifier:[UICollectionReusableView plk_className]
                                                     forIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell<PLKView> *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    [super willDisplayView:cell atIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id<PLKView> cell = [self cellAtIndexPath:indexPath];
    [super didSelectView:cell atIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView<PLKView> *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    [super configureSection:view atIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    id model = [self modelAtIndexPath:indexPath];
    id<PLKCellDescriptor> cellDescriptor = [self cellDescriptorAtIndexPath:indexPath];
    id<PLKSizeStrategy> sizeStrategy = cellDescriptor.sizeStrategy;
    
    [self.cellBuilder configureWithCellDescriptor:cellDescriptor];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    if ([layout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        UIEdgeInsets inset = layout.sectionInset;
        inset.right += layout.minimumLineSpacing;
        self.containerInset = inset;
    }
    
    CGSize size = [sizeStrategy sizeForModel:model withCellBuilder:self.cellBuilder forSource:self];
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return [self sizeForSupplementaryViewInSection:section
                                            ofKind:[self sectionKindFormString:UICollectionElementKindSectionHeader section:section]];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return [self sizeForSupplementaryViewInSection:section
                                            ofKind:[self sectionKindFormString:UICollectionElementKindSectionFooter section:section]];
}

@end