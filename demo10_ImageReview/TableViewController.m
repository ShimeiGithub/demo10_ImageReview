//
//  TableViewController.m
//  demo10_ImageReview
//
//  Created by LuoShimei on 16/5/12.
//  Copyright © 2016年 罗仕镁. All rights reserved.
//

#import "TableViewController.h"
#import "DetailViewController.h"

@interface TableViewController ()
@property(nonatomic,strong) NSArray *imageNames;
@end

@implementation TableViewController
/** 懒加载 */
- (NSArray *)imageNames{
    if (_imageNames == nil) {
        _imageNames = @[@"鲜花",@"菜椒",@"水母",@"日落",@"小孩",@"滑板少年"];
    }
    return _imageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageNames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.imageNames[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *imageNetPath = [NSString stringWithFormat:@"http://images.apple.com/v/iphone-5s/gallery/a/images/download/photo_%ld.jpg",indexPath.row + 1];
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    detailVC.imageNetPath = imageNetPath;
    detailVC.imageName = self.imageNames[indexPath.row];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
