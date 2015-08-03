//
//  UIView+PulsarKit.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 06/02/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

@import UIKit;

@interface UIView (PulsarKit)

+ (instancetype)plk_viewFromNib;
+ (instancetype)plk_viewFromNibOrClass;
+ (UINib *)plk_nibFromClassName;

@end
