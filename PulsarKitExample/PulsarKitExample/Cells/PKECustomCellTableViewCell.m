//
//  PKECustomCellTableViewCell.m
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 02/09/15.
//  Copyright (c) 2015 Massimo Oliviero. All rights reserved.
//

#import "PKECustomCellTableViewCell.h"

#import "PKEUser.h"

@implementation PKECustomCellTableViewCell

- (void)configureWithModel:(PKEUser *)user {
    self.label.text = user.name;
}

@end
