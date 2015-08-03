//
//  PLKBaseSource.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 06/02/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

// Header
#import "PLKBaseSource.h"

// Models
#import "PLKItem.h"
#import "PLKSection.h"
#import "PLKSections.h"
#import "PLKProvider.h"
#import "PLKCellDescriptor.h"

// Categories
#import "NSArray+PulsarKit.h"


@interface PLKBaseSource ()

@property (nonatomic, readwrite, strong) PLKSections *sections;

@end

@implementation PLKBaseSource

- (instancetype)initWithContainer:(UIScrollView *)container {
    self = [super init];
    if (self) {
        _container = container;

        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:self.container.window];
        [nc addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:self.container.window];
    }

    return self;
}

- (void)dealloc {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [nc removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Properties

- (PLKSections *)sections {
    if (!_sections) {
        _sections = [[PLKSections alloc] init];
    }

    return _sections;
}

- (NSMutableDictionary *)descriptors {
    if (!_descriptors) {
        _descriptors = [[NSMutableDictionary alloc] init];
    }

    return _descriptors;
}

#pragma mark - Descriptors

- (PLKCellDescriptor *)registerCellDescriptor:(PLKCellDescriptor *)cellDescriptor {
    self.descriptors[NSStringFromClass(cellDescriptor.model)] = cellDescriptor;
    return cellDescriptor;
}

- (PLKCellDescriptor *)registerCellDescriptorForCellClass:(Class)cellClass modelClass:(Class)model sizeStrategy:(id<PLKSizeStrategy>)strategy {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"you must override registerCellDescriptorForCellClass:modelClass:stategy: method" userInfo:nil];
}

#pragma mark - Loading

- (void)loadData {
    [self configureContainer];
    [self loadDataWithDirection:PLKDirectionNone];
}

- (void)loadDataWithDirection:(PLKDirection)direction {
    if (self.provider) {
        [self.provider source:self itemsForDirection:direction];
    }
}

- (void)configureContainer {
}

- (void)update {
}

#pragma mark - Notifications

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSTimeInterval duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:options];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    [self.container setContentInset:UIEdgeInsetsZero];
    [self.container setScrollIndicatorInsets:UIEdgeInsetsZero];
    [UIView commitAnimations];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    CGFloat keyboardHeight = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    NSTimeInterval duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    UIEdgeInsets inset = UIEdgeInsetsMake(0.0, 0.0, keyboardHeight, 0.0);

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationCurve:options];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDelegate:self];
    [self.container setContentInset:inset];
    [self.container setScrollIndicatorInsets:inset];
    [UIView commitAnimations];
}

#pragma mark - Helpers

- (PLKCellDescriptor *)descriptorAtIndexPath:(NSIndexPath *)indexPath {
    PLKSection *section = self.sections[indexPath.section];
    PLKItem *item = section[indexPath.row];

    if (item.descriptor) {
        return item.descriptor;
    }

    if (section.descriptor) {
        return section.descriptor;
    }

    return self.descriptors[NSStringFromClass([item.entity class])];
}

- (id<PLKSizeStrategy>)strategyAtIndexPath:(NSIndexPath *)indexPath {
    return [self descriptorAtIndexPath:indexPath].strategy;
}

- (id<PLKCellBuilder>)builderAtIndexPath:(NSIndexPath *)indexPath {
    return [self descriptorAtIndexPath:indexPath].builder;
}

- (id)entityAtIndexPath:(NSIndexPath *)indexPath {
    return self.sections[indexPath.section][indexPath.row].entity;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.sections.itemsCount == 0) {
        return;
    }

    if ((self.scrollOptions & PLKSourceScrollOptionInfiniteOnTop) == PLKSourceScrollOptionInfiniteOnTop &&
        scrollView.contentOffset.y == 0) {
        [self loadDataWithDirection:PLKDirectionTop];
    }

    if ((self.scrollOptions & PLKSourceScrollOptionInfiniteOnBottom) == PLKSourceScrollOptionInfiniteOnBottom &&
        scrollView.contentOffset.y == (scrollView.contentSize.height - scrollView.frame.size.height)) {
        [self loadDataWithDirection:PLKDirectionBottom];
    }
}

@end
