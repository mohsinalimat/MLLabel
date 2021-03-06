//
//  ListNoNibViewController.m
//  MLLabel
//
//  Created by molon on 15/6/19.
//  Copyright (c) 2015年 molon. All rights reserved.
//

#import "ListNoNibViewController.h"
#import <MLLabel/NSString+MLExpression.h>
#import "ListNoNibTableViewCell.h"
#import "UITableViewCell+Common.h"
#import "UIView+Convenience.h"
#import "MolonDebug.h"
#import "CommonData.h"

@interface ListNoNibViewController ()

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSMutableArray *expressionData;

@end

@implementation ListNoNibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"ListNoNib(little higher performance)";
    
    [self.tableView registerClass:[ListNoNibTableViewCell class] forCellReuseIdentifier:[ListNoNibTableViewCell cellReuseIdentifier]];
    
    self.data = kCommonListData();
    
    NSMutableArray *expressionData = [NSMutableArray new];
    MLExpression *exp = [MLExpression expressionWithRegex:@"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]" plistName:@"Expression" bundleName:@"Expression"];
    for (NSString *str in self.data) {
        [expressionData addObject:[str expressionAttributedStringWithExpression:exp]];
    }
    self.expressionData = expressionData;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ListNoNibTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ListNoNibTableViewCell cellReuseIdentifier] forIndexPath:indexPath];
    
    cell.label.attributedText = self.expressionData[indexPath.row%self.expressionData.count];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [ListNoNibTableViewCell heightForExpressionText:self.expressionData[indexPath.row%self.expressionData.count] width:self.view.frameWidth];
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
