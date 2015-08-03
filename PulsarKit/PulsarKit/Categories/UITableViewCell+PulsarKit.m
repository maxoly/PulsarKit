//
//  UITableViewCell+PulsarKit.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 03/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "UITableViewCell+PulsarKit.h"

@implementation UITableViewCell (PulsarKit)

- (void)configureWithEntity:(id)entity {
    if ([entity respondsToSelector:@selector(description)]) {
        self.textLabel.text = [entity description];
    }
}

@end
