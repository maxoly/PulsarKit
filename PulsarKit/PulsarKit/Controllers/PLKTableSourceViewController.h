//
//  PLKTableSourceViewController.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 06/02/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

@import UIKit;

#import "PLKTableSource.h"

@interface PLKTableSourceViewController : UIViewController

@property (nonatomic, readwrite, strong) UITableView *tableView;
@property (nonatomic, readwrite, strong) PLKTableSource *source;

@end
