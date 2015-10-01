//
//  PLKBaseSource.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 06/02/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

// Header
#import "PLKBaseSource.h"

// Protocols
#import "PLKView.h"
#import "PLKCellHandler.h"
#import "PLKCellDescriptor.h"
#import "PLKSectionDescriptor.h"

// Models
#import "PLKItem.h"
#import "PLKSection.h"
#import "PLKSections.h"
#import "PLKDynamicCellDescriptor.h"

// Categories
#import "NSArray+PulsarKit.h"
#import "UIView+PulsarKit.h"



/**
 *  Extension
 */
@interface PLKBaseSource ()

@property (nonatomic, readwrite, strong) NSCache *cellsCache;
@property (nonatomic, readwrite, strong) NSCache *sectionsCache;
@property (nonatomic, readwrite, strong) PLKSections *sections;
@property (nonatomic, readwrite, strong) NSMutableArray *registeredCellClasses;
@property (nonatomic, readwrite, strong) NSMutableArray *cellHandlers;
@property (nonatomic, readwrite, strong) NSMutableDictionary *cellDescriptors;
@property (nonatomic, readwrite, strong) NSMutableDictionary *sectionDescriptors;
@property (nonatomic, readwrite, strong) NSMutableDictionary *containerSectionDescriptors;
@property (nonatomic, readwrite, copy) PLKSourceDataProviderBlock dataProviderBlock;

@end



/**
 * Implementation
 */
@implementation PLKBaseSource

#pragma mark - Inits

- (instancetype)initWithContainer:(UIScrollView *)container{
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

- (NSMutableDictionary *)sectionDescriptors {
    if (!_sectionDescriptors) {
        _sectionDescriptors = [[NSMutableDictionary alloc] init];
    }
    
    return _sectionDescriptors;
}

- (NSMutableDictionary *)containerSectionDescriptors {
    if (!_containerSectionDescriptors) {
        _containerSectionDescriptors = [[NSMutableDictionary alloc] init];
    }
    
    return _containerSectionDescriptors;
}

- (NSMutableDictionary *)cellDescriptors {
    if (!_cellDescriptors) {
        _cellDescriptors = [[NSMutableDictionary alloc] init];
    }
    
    return _cellDescriptors;
}

- (NSMutableArray *)cellHandlers {
    if (!_cellHandlers) {
        _cellHandlers = [[NSMutableArray alloc] init];
    }
    
    return _cellHandlers;
}

- (NSMutableArray *)registeredCellClasses {
    if (!_registeredCellClasses) {
        _registeredCellClasses = [[NSMutableArray alloc] init];
    }
    
    return _registeredCellClasses;
}

- (NSCache *)cellsCache {
    if (!_cellsCache) {
        _cellsCache = [[NSCache alloc] init];
    }
    
    return _cellsCache;
}

- (NSCache *)sectionsCache {
    if (!_sectionsCache) {
        _sectionsCache = [[NSCache alloc] init];
    }
    
    return _sectionsCache;
}

#pragma mark - PLKSource

- (void)registerSectionDescriptor:(id<PLKSectionDescriptor>)sectionDescriptor {
    self.sectionDescriptors[ sectionDescriptor.key ] = sectionDescriptor;
}

- (void)registerCellDescriptor:(id<PLKCellDescriptor>)cellDescriptor {
    self.cellDescriptors[ NSStringFromClass(cellDescriptor.modelClass) ] = cellDescriptor;
}

- (void)registerCellHandler:(id<PLKCellHandler>)cellHandler {
    [self.cellHandlers addObject:cellHandler];
}

- (void)setDataProvider:(PLKSourceDataProviderBlock)dataProviderBlock {
    self.dataProviderBlock = dataProviderBlock;
}

- (void)setContainerSectionDescriptor:(id<PLKSectionDescriptor>)sectionDescriptor {
    self.containerSectionDescriptors[ @(sectionDescriptor.kind) ] = sectionDescriptor;
}

- (void)showOrHideContainerSectionOfKind:(PLKSectionKind)kind show:(BOOL)show {
    id<PLKSectionDescriptor> sectionDescriptor = self.containerSectionDescriptors[ @(kind) ];
    if (sectionDescriptor) {
        switch (kind) {
            case PLKSectionKindHeader:
                self.sections.topSection = [PLKSection sectionWithSectionDescriptor:sectionDescriptor];
                break;
                
            case PLKSectionKindFooter:
                self.sections.bottomSection = [PLKSection sectionWithSectionDescriptor:sectionDescriptor];
                break;
        }
    }
}

#pragma mark - Loading

- (void)loadData {
    if (self.isFirstTime) {
        [self prepareContainer];
    }
    [self loadDataWithDirection:PLKDirectionNone];
    self.firstTime = NO;
}

- (void)loadDataWithDirection:(PLKDirection)direction {
    if (self.dataProviderBlock) {
        self.dataProviderBlock(direction);
    }
}

#pragma mark - PLKBaseSource

- (void)configureSection:(UIView<PLKView> *)view atIndexPath:(NSIndexPath *)indexPath {
    id model = [self modelAtSection:indexPath.section];
    if ([view respondsToSelector:@selector(configureWithModel:)]) {
        [view configureWithModel:model];
    }
}

- (void)configureCell:(UIView<PLKView> *)cell atIndexPath:(NSIndexPath *)indexPath {
    if (self.onBeforeCellConfiguration) {
        self.onBeforeCellConfiguration(cell);
    }
    
    if (self.onCellConfiguration) {
        self.onCellConfiguration(cell);
    } else {
        id model = [self modelAtIndexPath:indexPath];
        if ([cell respondsToSelector:@selector(configureWithModel:)]) {
            [cell configureWithModel:model];
        }
    }
    
    if (self.onAfterCellConfiguration) {
        self.onAfterCellConfiguration(cell);
    }
}

#pragma mark - To overrides

- (void)prepareContainer {
}

- (id<PLKView>)cellAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)update {
}

- (void)registerClassForCellClass:(Class)cellClass {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"you must override registerClassForCellClass: method" userInfo:nil];
}

- (void)registerNibForCellClass:(Class)cellClass {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"you must override registerNibForCellClass: method" userInfo:nil];
}

- (void)registerSupplementaryViewClass:(Class)viewClass ofKind:(PLKSectionKind)kind {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"you must override registerSupplementaryViewClass: method" userInfo:nil];
}

- (void)registerSupplementaryNibForViewClass:(Class)viewClass ofKind:(PLKSectionKind)kind {
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"you must override registerSupplementaryNibForViewClass: method" userInfo:nil];
}

#pragma mark - Notifications

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSTimeInterval duration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
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

- (NSArray *)cellHandlersAtIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert(indexPath);
    
    NSMutableArray *handlers = [[NSMutableArray alloc] init];
    
    id model = [self modelAtIndexPath:indexPath];
    id cell = [self cellAtIndexPath:indexPath];
    
    for (id<PLKCellHandler> handler in self.cellHandlers) {
        if ([handler canHandleCell:cell model:model atIndexPath:indexPath]) {
            [handlers addObject:handler];
        }
    }
    
    return handlers.copy;
}

- (id<PLKSectionDescriptor>)sectionDescriptorInSection:(NSInteger)section ofKind:(PLKSectionKind)kind {
    PLKSection *internalSection = self.sections[section];
    id<PLKSectionDescriptor> sectionDescriptor = nil;
    
    if (kind & PLKSectionKindHeader && internalSection.headerDescription) {
        if (internalSection.headerDescription.kind == kind) {
            sectionDescriptor = internalSection.headerDescription;
        }
    }
    
    if (kind & PLKSectionKindFooter && internalSection.footerDescription) {
        if (internalSection.footerDescription.kind == kind) {
            sectionDescriptor = internalSection.footerDescription;
        }
    }
    
    if (internalSection.isSpecial) {
        [self registerViewOfSectionDescriptor:sectionDescriptor];
        return sectionDescriptor;
    }
    
    NSString *key = [NSString stringWithFormat:@"%zd.%zd", section, kind];
    if (!sectionDescriptor) {
        sectionDescriptor = self.sectionDescriptors[ key ];
    }
    
    if (!sectionDescriptor) {
        key = [NSString stringWithFormat:@"%zd.%zd", NSIntegerMax, kind];
        sectionDescriptor = self.sectionDescriptors[ key ];
    }
    
    if (!sectionDescriptor) {
        key = [NSString stringWithFormat:@"%zd.%zd", NSIntegerMax, PLKSectionKindHeader | PLKSectionKindFooter];
        sectionDescriptor = self.sectionDescriptors[ key ];
    }
    
    if (!sectionDescriptor) {
        key = NSStringFromClass(sectionDescriptor.modelClass);
        sectionDescriptor = self.sectionDescriptors[ key ];
    }
    
    [self registerViewOfSectionDescriptor:sectionDescriptor];
    
    return sectionDescriptor;
}

- (void)registerViewOfSectionDescriptor:(id<PLKSectionDescriptor>)sectionDescriptor {
    if (sectionDescriptor) {
        NSString *nibPath = [sectionDescriptor.sectionClass plk_nibPathFromClassName];
        
        if (nibPath) {
            [self registerSupplementaryNibForViewClass:sectionDescriptor.sectionClass ofKind:sectionDescriptor.kind];
        } else {
            [self registerSupplementaryViewClass:sectionDescriptor.sectionClass ofKind:sectionDescriptor.kind];
        }
    }
}

- (id<PLKCellDescriptor>)cellDescriptorAtIndexPath:(NSIndexPath *)indexPath {
    NSParameterAssert(indexPath);
    
    PLKSection *section = self.sections[indexPath.section];
    PLKItem *item = section[indexPath.row];
    
    id<PLKCellDescriptor> cellDescriptor;
    
    if (item.cellDescriptor) {
        cellDescriptor = item.cellDescriptor;
    } else if (section.cellDescriptor) {
        cellDescriptor = section.cellDescriptor;
    } else {
        cellDescriptor = self.cellDescriptors[ NSStringFromClass([item.model class]) ];
    }
    
    if ([cellDescriptor isKindOfClass:[PLKDynamicCellDescriptor class]]) {
        PLKDynamicCellDescriptor *dcd = cellDescriptor;
        cellDescriptor = [dcd cellDescriptorForModel:item.model];
    }
    
    if (!cellDescriptor) {
        cellDescriptor = self.cellDescriptors[ NSStringFromClass([NSNull class])];
    }
    
    if (!cellDescriptor.storyboard) {
        
        if (![self.registeredCellClasses containsObject:cellDescriptor.cellClass]) {
            
            NSString *nibPath = [cellDescriptor.cellClass plk_nibPathFromClassName];
            
            if (nibPath) {
                [self registerNibForCellClass:cellDescriptor.cellClass];
            } else {
                [self registerClassForCellClass:cellDescriptor.cellClass];
            }
            
            [self.registeredCellClasses addObject:cellDescriptor.cellClass];
        }
    }
    
    return cellDescriptor;
}

- (id)modelAtIndexPath:(NSIndexPath *)indexPath {
    return self.sections[indexPath.section][indexPath.row].model;
}

- (id)modelAtSection:(NSInteger)section {
    return self.sections[section].model;
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
    
    if ((self.scrollOptions & PLKSourceScrollOptionInfiniteOnLeft) == PLKSourceScrollOptionInfiniteOnLeft &&
        scrollView.contentOffset.x == 0) {
        [self loadDataWithDirection:PLKDirectionTop];
    }
    
    if ((self.scrollOptions & PLKSourceScrollOptionInfiniteOnRight) == PLKSourceScrollOptionInfiniteOnRight &&
        scrollView.contentOffset.x == (scrollView.contentSize.width - scrollView.frame.size.width)) {
        [self loadDataWithDirection:PLKDirectionBottom];
    }
}

@end