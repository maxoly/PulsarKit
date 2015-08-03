//
//  PLKCollectionSource.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 03/08/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKBaseSource.h"



/**
 *  Define a collection source
 */
@interface PLKCollectionSource : PLKBaseSource <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

/**
 *  The Table View.
 */
@property (nonatomic, readonly, strong) UICollectionView *collectionView;

/**
 *  Unavailable init.
 *
 *  @param container The cotainer.
 *
 *  @return nothing.
 */
- (instancetype)initWithContainer:(UIScrollView *)container __unavailable;

/**
 *  Initialize a table source.
 *
 *  @param tableView The table view container.
 *
 *  @return An instance of PLKTableSource.
 */
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView;

@end
