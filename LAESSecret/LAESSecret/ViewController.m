//
//  ViewController.m
//  LAESSecret
//
//  Created by 李昊泽 on 16/9/7.
//  Copyright © 2016年 李昊泽. All rights reserved.
//

#import "ViewController.h"
#import "LocalAESSerectController.h"
@interface ViewController ()
/** tableview数据数组  */
@property (nonatomic, strong) NSArray *sourceArray;
@end

@implementation ViewController

#pragma mark - initialization
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.navigationItem.title = @"pusswzy";
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.textLabel.text = self.sourceArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            LocalAESSerectController *local = [[LocalAESSerectController alloc] init];
            [self.navigationController pushViewController:local animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Lazy
- (NSArray *)sourceArray {
    if (!_sourceArray) {
        _sourceArray = @[@"本地AES加解密", @"与Java后台AES加解密"];
    }
    return _sourceArray;
}
@end
