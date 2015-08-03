//
//  PKEHomeViewController.m
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 04/03/15.
//  Copyright (c) 2015 Massimo Oliviero. All rights reserved.
//

#import "PKEHomeViewController.h"

#import <PulsarKit/PulsarKit.h>

#import "PKEUser.h"

@interface PKEHomeViewController () <PLKProvider>

@property (nonatomic, readwrite, strong) PLKTableSource *source;

@end

@implementation PKEHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.source = [[PLKTableSource alloc] initWithTableView:self.tableView];
    self.source.provider = self;
    self.source.scrollOptions = PLKSourceScrollOptionInfiniteOnBottom | PLKSourceScrollOptionInfiniteOnTop;
    [self.source registerCellDescriptorForCellClass:[UITableViewCell class] modelClass:[PKEUser class] sizeStrategy:[PLKAutolayoutSize autolayoutSize]];
    [self.source loadData];
}

- (void)source:(id<PLKSource>)source itemsForDirection:(PLKDirection)direction
{
    if (direction == PLKDirectionNone)
    {
        NSMutableArray *users = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 30; i++)
        {
            [users addObject:[[PKEUser alloc] init]];
        }
    
        [source.sections addEntities:users];
    }
    
    if (direction == PLKDirectionTop)
    {
        NSMutableArray *users = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 30; i++)
        {
            [users addObject:[[PKEUser alloc] init]];
        }
        
        [source.sections addEntitiesOnTop:users];
    }
    
    if (direction == PLKDirectionBottom)
    {
        NSMutableArray *users = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 30; i++)
        {
            [users addObject:[[PKEUser alloc] init]];
        }
        
        [source.sections addEntities:users];
    }
    
    [source update];
}

@end
