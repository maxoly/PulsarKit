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

#import "PLKTableViewCellBuilder.h"
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

- (instancetype)initWithTableView:(UITableView *)tableView {
    self = [super initWithContainer:tableView cellBuilder:[PLKTableViewCellBuilder new]];
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = [self modelAtIndexPath:indexPath];
    id<PLKCellDescriptor> cellDescriptor = [self cellDescriptorAtIndexPath:indexPath];
    return [self.cellBuilder cellForModel:model withCellClass:cellDescriptor.cellClass inContainer:tableView atIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (self.onDidSelectItem) {
        id model = [self modelAtIndexPath:indexPath];
        self.onDidSelectItem(indexPath, model);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    id model = [self modelAtIndexPath:indexPath];
    
    id<PLKCellDescriptor> cellDescriptor = [self cellDescriptorAtIndexPath:indexPath];
    id<PLKSizeStrategy> sizeStrategy = cellDescriptor.sizeStrategy;
    
    UIView<PLKCell> *cell = [self.cellBuilder cachedCellForModel:model
                                                    withCellClass:cellDescriptor.cellClass
                                                      inContainer:tableView
                                                      atIndexPath:indexPath];

    
    CGSize size = [sizeStrategy sizeForModel:model withCell:cell inContainer:tableView];
    return size.height;
}

@end
