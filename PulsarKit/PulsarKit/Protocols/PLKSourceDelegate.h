//
//  PLKSourceDelegate.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 11/11/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

@import Foundation;
@import UIKit;

@protocol PLKView;
@protocol PLKSource;

@protocol PLKSourceDelegate <NSObject>

@optional

- (void)source:(id<PLKSource>)source willConfigureView:(id<PLKView>)view;
- (void)source:(id<PLKSource>)source configureView:(id<PLKView>)view;
- (void)source:(id<PLKSource>)source didConfigureView:(id<PLKView>)view;

- (void)source:(id<PLKSource>)source didScrollContainer:(UIScrollView *)container;
- (void)source:(id<PLKSource>)source didEndDeceleratingContainer:(UIScrollView *)container;

- (void)source:(id<PLKSource>)source didSelectModel:(id)model inView:(id<PLKView>)view atIndexPath:(NSIndexPath *)indexPath;
- (BOOL)source:(id<PLKSource>)source canSelectModel:(id)model inView:(id<PLKView>)view atIndexPath:(NSIndexPath *)indexPath;

@end
