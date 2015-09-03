//
//  PKECustomCellTableViewCell.h
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 02/09/15.
//  Copyright (c) 2015 Massimo Oliviero. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <PulsarKit/PulsarKit.h>

@interface PKECustomCellTableViewCell : UITableViewCell<PLKCell>

@property (weak, nonatomic) IBOutlet UILabel *label;

@end
