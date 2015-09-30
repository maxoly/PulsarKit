//
//  PLKCellHandler.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 15/09/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

@import Foundation;

@protocol PLKView;

@protocol PLKCellHandler <NSObject>

- (BOOL)canHandleCell:(id<PLKView>)cell model:(id)model atIndexPath:(NSIndexPath *)indexPath;
- (void)handleCell:(id<PLKView>)cell model:(id)model atIndexPath:(NSIndexPath *)indexPath;

@end
