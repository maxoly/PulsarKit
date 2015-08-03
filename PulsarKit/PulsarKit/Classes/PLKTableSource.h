//
//  PLKTableSource.h
//  PulsarKit
//
//  Created by Massimo Oliviero on 06/02/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKBaseSource.h"



/**
 *  Define a table source.
 */
@interface PLKTableSource : PLKBaseSource <UITableViewDataSource, UITableViewDelegate>

/**
 *  The Table View.
 */
@property (nonatomic, readonly, strong) UITableView *tableView;

/**
 *  Unavailable init.
 *
 *  @param container The cotainer.
 *
 *  @return nothing.
 */
- (instancetype)initWithContainer:(UIScrollView *)container __unavailable;

/**
 *  Initialize a table source.
 *
 *  @param tableView The table view container.
 *
 *  @return An instance of PLKTableSource.
 */
- (instancetype)initWithTable:(UITableView *)tableView;

@end
