//
//  PLKCellBuilder.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

@import UIKit;
@import Foundation;


@protocol PLKCell;



@protocol PLKCellBuilder <NSObject>

- (id)cellForModel:(id)model withCellClass:(Class)cellClass inContainer:(UIScrollView *)container atIndexPath:(NSIndexPath *)indexPath;
- (id)cachedCellForModel:(id)model withCellClass:(Class)cellClass inContainer:(UIScrollView *)container atIndexPath:(NSIndexPath *)indexPath;

@end
