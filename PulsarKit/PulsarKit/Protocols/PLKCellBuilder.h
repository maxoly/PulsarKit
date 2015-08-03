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

@property (nonatomic, readwrite, assign) Class cellClass;

- (id)cellForEntity:(id)entity inContainer:(UIScrollView *)container atIndexPath:(NSIndexPath *)indexPath;
- (id)cachedCellForEntity:(id)entity inContainer:(UIScrollView *)container atIndexPath:(NSIndexPath *)indexPath;

@end
