//
//  PLKTableSource.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 06/02/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKTableSource.h"

#import "PLKCell.h"
#import "PLKSection.h"
#import "PLKSections.h"
#import "PLKSectionView.h"

#import "NSObject+PulsarKit.h"
#import "UIView+PulsarKit.h"

#import "PLKCellBuilder.h"
#import "PLKSizeStrategy.h"
#import "PLKCellDescriptor.h"

@interface PLKTableSource ()



@end

/**
   Source implementation.
 */
@implementation PLKTableSource

#pragma mark - Inits

- (instancetype)initWithTable:(UITableView *)tableView {
    self = [super initWithContainer:tableView];
    if (self) {
        _tableView = tableView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollsToTop = YES;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;

        // Self-sizing table view cells in iOS 8 require that the rowHeight property of the
        // table view be set to the constant UITableViewAutomaticDimension
//        _tableView.rowHeight = UITableViewAutomaticDimension;

        // Self-sizing table view cells in iOS 8 are enabled when the estimatedRowHeight property of the table view is set to a non-zero value.
        // Setting the estimated row height prevents the table view from calling tableView:heightForRowAtIndexPath: for every row in the table on first load;
        // it will only be called as cells are about to scroll onscreen. This is a major performance optimization.
//        _tableView.estimatedRowHeight = 44.0; // set this to whatever your "average" cell height is; it doesn't need to be very accurate
    }

    return self;
}

- (void)dealloc {
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
}

#pragma mark - Load

- (void)loadData {
    [super loadData];
}

- (void)configureContainer {
    for (id key in self.descriptors.allKeys) {
        PLKCellDescriptor *descriptor = self.descriptors[key];

        Class cellClass = descriptor.builder.cellClass;

        // Register Cell Nib
        NSString *nibPath = [[NSBundle bundleForClass:cellClass] pathForResource:[cellClass plk_className] ofType:@"nib"];

        if (nibPath) {
            [self.tableView registerNib:[cellClass plk_nibFromClassName] forCellReuseIdentifier:[cellClass plk_className]];
        } else {
            [self.tableView registerClass:cellClass forCellReuseIdentifier:[cellClass plk_className]];
        }
    }
}

- (void)update {
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id entity = [self entityAtIndexPath:indexPath];
    id<PLKCellBuilder> builder = [self builderAtIndexPath:indexPath];
    return [builder cellForEntity:entity inContainer:self.tableView atIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.onDidSelectItem) {
        id entity = [self entityAtIndexPath:indexPath];
        self.onDidSelectItem(indexPath, entity);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id entity = [self entityAtIndexPath:indexPath];
    id<PLKSizeStrategy> strategy = [self strategyAtIndexPath:indexPath];
    id<PLKCellBuilder> builder = [self builderAtIndexPath:indexPath];

    CGSize size = [strategy sizeForEntity:entity inContainer:self.tableView atIndexPath:indexPath builder:builder];
    return size.height;
}

@end
