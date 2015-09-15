//
//  PLKTableSource.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 06/02/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKTableSource.h"

// Protocoles
#import "PLKCell.h"
#import "PLKCellHandler.h"
#import "PLKCellDescriptor.h"

// Models
#import "PLKSection.h"
#import "PLKSections.h"
#import "PLKSectionView.h"
#import "PLKSizeStrategy.h"

// Categories
#import "NSObject+PulsarKit.h"
#import "UIView+PulsarKit.h"



/**
 * Implementation.
 */
@implementation PLKTableSource

#pragma mark - Inits

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super initWithContainer:tableView];
    if (self) {
        _tableView = tableView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollsToTop = YES;
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
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
}

- (void)update {
    [self.tableView reloadData];
}

#pragma mark - Cell Registration

- (void)registerNibForCellClass:(Class)cellClass {
    [self.tableView registerNib:[cellClass plk_nibFromClassName] forCellReuseIdentifier:[cellClass plk_className]];
}

- (void)registerClassForCellClass:(Class)cellClass {
    [self.tableView registerClass:cellClass forCellReuseIdentifier:[cellClass plk_className]];
}

- (id<PLKCell>)cellAtIndexPath:(NSIndexPath *)indexPath {
    return (id<PLKCell>) [self.tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id<PLKCellDescriptor> cellDescriptor = [self cellDescriptorAtIndexPath:indexPath];
    UITableViewCell<PLKCell> *cell = [tableView dequeueReusableCellWithIdentifier:[cellDescriptor.cellClass plk_className] forIndexPath:indexPath];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell<PLKCell> *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [super configureCell:cell atIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    id model = [self modelAtIndexPath:indexPath];
    
    if (self.onDidSelectItem) {
        self.onDidSelectItem(indexPath, model);
    }
    
    id<PLKCell> cell = [self cellAtIndexPath:indexPath];
    
    NSArray *handlers = [self cellHandlersAtIndexPath:indexPath];
    [handlers enumerateObjectsUsingBlock:^(id<PLKCellHandler> handler, NSUInteger idx, BOOL *stop) {
        [handler handleCell:cell model:model atIndexPath:indexPath];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = [self modelAtIndexPath:indexPath];
    
    id<PLKCellDescriptor> cellDescriptor = [self cellDescriptorAtIndexPath:indexPath];
    id<PLKSizeStrategy> sizeStrategy = cellDescriptor.sizeStrategy;
    
    UIView<PLKCell> *cell = [self.cellsCache objectForKey:[cellDescriptor.cellClass plk_className]];
    if (!cell) {
        cell = [cellDescriptor.cellClass plk_viewFromNibOrClass];
        [self.cellsCache setObject:cell forKey:[cellDescriptor.cellClass plk_className]];
    }
    
    CGSize size = [sizeStrategy sizeForModel:model withCell:cell inContainer:tableView];
    return size.height;
}

@end
