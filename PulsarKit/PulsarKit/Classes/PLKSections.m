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

- (void)addEntitiesOnTop:(NSArray *)entities {
    PLKSection *section = [self returnOrCreateFirstSection];
    [section addEntitiesOnTop:entities];
}

- (void)addEntities:(NSArray *)entities {
    PLKSection *section = [self returnOrCreateFirstSection];
    [section addEntities:entities];
}

#pragma mark - Sections

- (PLKSection *)returnOrCreateFirstSection {
    PLKSection *section = [self.sections lastObject];

    if (!section) {
        section = [self addSection];
    }

    return section;
}

- (PLKSection *)addSection {
    return [self addSectionAtPostion:self.sections.count];
}

- (PLKSection *)addSectionAtPostion:(NSInteger)position {
    PLKSection *section = [self.sections plk_safeObjectAtIndex:position];

    if (!section) {
        section = [[PLKSection alloc] init];
        [self.sections addObject:section];
    }

    return section;
}

#pragma mark - Items

- (void)addItems:(NSArray *)items {
    PLKSection *section = [self addSectionAtPostion:0];
    [section addItems:items];
}

#pragma mark - Subscripting

- (PLKSection *)objectAtIndexedSubscript:(NSInteger)index {
    return self.sections[index];
}

@end
