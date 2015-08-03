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
#import "PLKCellBuilder.h"
#import "PLKCellDescriptor.h"

// Categories
#import "NSArray+PulsarKit.h"
#import "UIView+PulsarKit.h"


@interface PLKBaseSource ()

@property (nonatomic, readwrite, strong) PLKSections *sections;
@property (nonatomic, readwrite, copy) PLKSourceDataProviderBlock dataProviderBlock;

@end

@implementation PLKBaseSource

- (instancetype)initWithContainer:(UIScrollView *)container {
    self = [super init];
    if (self) {
        _container = container;
        _firstTime = YES;
        
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

#pragma mark - PLKSource

- (PLKCellDescriptor *)registerCellDescriptor:(PLKCellDescriptor *)cellDescriptor {
    self.descriptors[NSStringFromClass(cellDescriptor.model)] = cellDescriptor;
    return cellDescriptor;
}

- (PLKCellDescriptor *)registerCellDescriptorForCellClass:(Class)cellClass modelClass:(Class)model sizeStrategy:(id<PLKSizeStrategy>)strategy {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"you must override registerCellDescriptorForCellClass:modelClass:stategy: method" userInfo:nil];
}

- (void)setDataProvider:(PLKSourceDataProviderBlock)dataProviderBlock {
    self.dataProviderBlock = dataProviderBlock;
}

#pragma mark - Loading

- (void)loadData {
    if (self.isFirstTime) {
        [self configureDescriptors];
        [self configureContainer];
    }
    [self loadDataWithDirection:PLKDirectionNone];
    self.firstTime = NO;
}

- (void)loadDataWithDirection:(PLKDirection)direction {
    if (self.dataProviderBlock) {
        self.dataProviderBlock(direction);
    }
}

- (void)configureDescriptors {
    for (id key in self.descriptors.allKeys) {
        PLKCellDescriptor *descriptor = self.descriptors[key];
        
        Class cellClass = descriptor.builder.cellClass;
        
        // Register Cell Nib
        NSString *nibPath = [cellClass plk_nibPathFromClassName];
        
        if (nibPath) {
            [self registerNibForCellClass:cellClass];
        } else {
            [self registerClassForCellClass:cellClass];
        }
    }
}

#pragma mark - To overrides

- (void)configureContainer {
}

- (void)update {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"you must override update method" userInfo:nil];
}

- (void)registerClassForCellClass:(Class)cellClass {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"you must override registerClassForCellClass: method" userInfo:nil];
}

- (void)registerNibForCellClass:(Class)cellClass {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"you must override registerNibForCellClass: method" userInfo:nil];
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
