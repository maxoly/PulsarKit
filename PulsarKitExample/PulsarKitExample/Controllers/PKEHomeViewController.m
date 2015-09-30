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
#import "PKECustomCellTableViewCell.h"

@interface PKEHomeViewController ()

@property (nonatomic, readwrite, strong) PLKTableSource *source;

@end

@implementation PKEHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    __weak typeof(self) weakSelf = self;
    
    self.source = [[PLKTableSource alloc] initWithTableView:self.tableView];
    self.source.scrollOptions = PLKSourceScrollOptionInfiniteOnBottom | PLKSourceScrollOptionInfiniteOnTop;
    
    PLKModelCellDescriptor *cellDescriptor =[PLKModelCellDescriptor descriptorWithCellClass:[PKECustomCellTableViewCell class] sizeStrategy:[PLKProportionalSize proportionalHeightBasedOnWidth:0.1]];
    cellDescriptor.storyboard = YES;
    [self.source registerCellDescriptor:cellDescriptor];
    
    [self.source registerCellHandler:[PLKClassCellHandler handlerForCellClass:[PKECustomCellTableViewCell class] withBlock:^(id<PLKView> cell, id model, NSIndexPath *indexPath) {
        NSLog(@"tapped");
    }]];
    
//    [self.source registerCellHandler:[PLKClassCellHandler handlerForClass:[PKECustomCellTableViewCell class] block:^(){}]];
    
    
//    PLKDynamicCellDescriptor *dynamic = [PLKDynamicCellDescriptor descriptorForModelClass:[PKEUser class]];
//    [dynamic useCellDescriptor:[PLKModelCellDescriptor descriptorWithCellClass:[PKECustomCellTableViewCell class]] whenValueOfKeyPath:@"name" isEqualTo:@"user-2"];
//    
//    [self.source registerCellDescriptor:dynamic];
//    [self.source registerStoryboardCellDescriptorForCellClass:[PKECustomCellTableViewCell class] modelClass:[PKEUser class] sizeStrategy:[PLKAutolayoutSize autolayoutSize]];
    
/*
 
    [self.source registerCellDescriptor:[PLKModelCellDescriptor descriptorWithCellClass:[CELL class] forModel:nil]];
    [self.source registerCellDescriptor:[PLKModelCellDescriptor descriptorWithCellClass:[CELL class] forModel:[PKEUser class]]];
    [self.source registerCellDescriptor:[PLKModelCellDescriptor descriptorWithCellClass:[CELL class] forModel:[PKEUser class] sizeStrategy:[PLS ds]]];
 
 
    PLKDynamicCellDescriptor *dc = [PLKDynamicCellDescriptor descriptorForModel:[PKEUser class]];
    [dc useCellDescriptor:[PLKModelCellDescriptor descriptorWithCellClass:[CELL class]] whenKey:@"type" isEqualTo:@"1"]
    [dc useCellDescriptor:[PLKModelCellDescriptor descriptorWithCellClass:[CELL class]] whenKey:@"type" isEqualTo:@"2"]
    [self.source registerCellDescriptor:dc];
 */
    
    [self.source setDataProvider:^(PLKDirection direction) {
        if (direction == PLKDirectionNone)
        {
            NSMutableArray *users = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < 30; i++)
            {
                [users addObject:[PKEUser userWithName:[NSString stringWithFormat:@"user-%zd", i]]];
            }
            
            [weakSelf.source.sections addModels:users];
        }
        
        if (direction == PLKDirectionTop)
        {
            NSMutableArray *users = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < 30; i++)
            {
                [users addObject:[PKEUser userWithName:[NSString stringWithFormat:@"user-%zd", i]]];
            }
            
            [weakSelf.source.sections addModels:users];
        }
        
        if (direction == PLKDirectionBottom)
        {
            NSMutableArray *users = [[NSMutableArray alloc] init];
            for (NSInteger i = 0; i < 30; i++)
            {
                [users addObject:[PKEUser userWithName:[NSString stringWithFormat:@"user-%zd", i]]];
            }
            
            [weakSelf.source.sections addModels:users];
        }
        
        [weakSelf.source update];
    }];
    [self.source loadData];
}

@end
