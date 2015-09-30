//
//  PLKSections.m
//  PulsarKit
//
//  Created by Massimo Oliviero on 04/06/15.
//  Copyright (c) 2015 Nacoon. All rights reserved.
//

#import "PLKSections.h"

#import "PLKSection.h"
#import "NSArray+PulsarKit.h"

@interface PLKSections ()

@property (nonatomic, readwrite, strong) NSMutableArray *sections;

@end

@implementation PLKSections

#pragma mark - Heplers

- (NSInteger)indexOfSectionWithKey:(id)key {
    return [self.sections indexOfObjectPassingTest:^BOOL(PLKSection *section, NSUInteger idx, BOOL *stop) {
        *stop = [section.key isEqual:key];
        return *stop;
    }];
}

#pragma mark - Properties

- (NSMutableArray *)sections {
    if (!_sections) {
        _sections = [[NSMutableArray alloc] init];
    }
    
    return _sections;
}

- (NSInteger)count {
    return self.sections.count;
}

- (NSInteger)itemsCount {
    NSNumber *sum = [self.sections valueForKeyPath:@"@sum.items.@count"];
    return [sum integerValue];
}

- (void)addModel:(id)model {
    [self addModels:@[ model ]];
}

- (void)addModelsOnTop:(NSArray *)models {
    PLKSection *section = [self returnOrCreateLastSection];
    [section addModelsOnTop:models];
}

- (void)addModels:(NSArray *)models {
    PLKSection *section = [self returnOrCreateLastSection];
    [section addModels:models];

}

- (void)addModel:(id)model toSectionWithKey:(id)key {
    [self addModels:@[ model ] toSectionWithKey:key];
}

- (void)addModels:(NSArray *)models toSectionWithKey:(id)key {
    PLKSection *section = [self returnOrCreateSectionWithKey:key];
    [section addModels:models];
}

#pragma mark - Sections

- (PLKSection *)returnOrCreateLastSection {
    PLKSection *section = [self.sections lastObject];
    
    if (!section) {
        section = [self addSection];
    }
    
    return section;
}

- (PLKSection *)returnOrCreateSectionWithKey:(id)key {
    NSInteger index = [self indexOfSectionWithKey:key];
    if (index == NSNotFound) {
        PLKSection *section = [self addSection];
        section.key = key;
        return section;
    }
    
    return self.sections[index];
}

- (PLKSection *)addSection {
    return [self addSectionAtIndex:self.sections.count];
}

- (PLKSection *)addSectionWithKey:(id)key {
    return [self returnOrCreateSectionWithKey:key];
}

- (PLKSection *)addSectionAtIndex:(NSUInteger)index {
    PLKSection *section = [self.sections plk_safeObjectAtIndex:index];
    
    if (!section) {
        section = [[PLKSection alloc] init];
        [self.sections insertObject:section atIndex:index];
    }
    
    return section;
}

#pragma mark - Items

- (void)addItem:(PLKItem *)item {
    [self addItems:@[ item ]];
}

- (void)addItems:(NSArray *)items {
    PLKSection *section = [self returnOrCreateLastSection];
    [section addItems:items];
}

#pragma mark - Subscripting

- (PLKSection *)objectAtIndexedSubscript:(NSUInteger)index {
    return self.sections[index];
}

@end
