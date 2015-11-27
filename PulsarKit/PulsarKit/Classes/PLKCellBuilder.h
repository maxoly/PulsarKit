//
//  PLKCellBuilder.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 27/11/15.
//  Copyright © 2015 Nacoon. All rights reserved.
//

@import Foundation;
@import UIKit;

@protocol PLKView;
@protocol PLKCellDescriptor;
@protocol PLKSectionDescriptor;


@interface PLKCellBuilder : NSObject

- (UIView<PLKView> *)build;
- (void)configureWithCellDescriptor:(id<PLKCellDescriptor>)cellDescriptor;
- (void)configureWithSectionDescriptor:(id<PLKSectionDescriptor>)sectionDescriptor;

@end
