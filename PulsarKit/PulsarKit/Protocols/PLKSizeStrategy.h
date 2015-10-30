//
//  PLKSizeStrategy.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

@import UIKit;
@import Foundation;
@import CoreGraphics;



@protocol PLKView;
@protocol PLKSource;


@protocol PLKSizeStrategy <NSObject>

- (CGSize)sizeForModel:(id)model withView:(UIView<PLKView> *)view forSource:(id<PLKSource>)source;

@end
