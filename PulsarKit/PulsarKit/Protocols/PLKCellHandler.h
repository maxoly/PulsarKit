//
//  PLKCellHandler.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 15/09/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

@import Foundation;

@protocol PLKCell;

@protocol PLKCellHandler <NSObject>

- (BOOL)canHandleCell:(id<PLKCell>)cell model:(id)model atIndexPath:(NSIndexPath *)indexPath;
- (void)handleCell:(id<PLKCell>)cell model:(id)model atIndexPath:(NSIndexPath *)indexPath;

@end
