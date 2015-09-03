//
//  UITableViewCell+PulsarKit.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 03/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "UITableViewCell+PulsarKit.h"

@implementation UITableViewCell (PulsarKit)

- (NSString *)reuseIdentifier {
    return NSStringFromClass(self.class);
}

- (void)configureWithModel:(id)model {
    if ([model respondsToSelector:@selector(description)]) {
        self.textLabel.text = [model description];
    }
}

@end
