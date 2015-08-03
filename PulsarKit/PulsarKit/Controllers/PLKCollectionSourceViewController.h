//
//  PLKCollectionSourceViewController.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 03/08/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

@import UIKit;

#import "PLKCollectionSource.h"

@interface PLKCollectionSourceViewController : UIViewController

@property (nonatomic, readwrite, strong) UICollectionView *collectionView;
@property (nonatomic, readwrite, strong) PLKCollectionSource *source;

@end
