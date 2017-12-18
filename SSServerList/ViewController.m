//
//  ViewController.m
//  SSServerList
//
//  Created by ashen on 2017/12/15.
//  Copyright © 2017年 Ashen. All rights reserved.
//

#import "ViewController.h"
#import "ASGETServerList.h"
#import "ASServerListCell.h"
#import "ASPreviewingController.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,UIViewControllerPreviewingDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSources;
@end

@implementation ViewController


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [ASGETServerList getlist:^(NSArray *list) {
        [self.dataSources addObjectsFromArray:list];
        [self.tableView reloadData];
    }];
    
    [self.tableView registerClass:ASServerListCell.class forCellReuseIdentifier:@"serverIden"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSources.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 220;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASServerListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"serverIden" forIndexPath:indexPath];
    ASServerModel * model = self.dataSources[indexPath.row];
    [cell setupData:model];
    if ([self respondsToSelector:@selector(traitCollection)]) {
        if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
            if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
                [self registerForPreviewingWithDelegate:self sourceView:cell];
            }
        }
    }
    return cell;
}

#pragma mark - peek pop Delegate
//peek(预览)
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    //获取按压的cell所在行，[previewingContext sourceView]就是按压的那个视图
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell* )[previewingContext sourceView]];
    ASServerModel *model = self.dataSources[indexPath.row];
    //设定预览的界面
    ASPreviewingController *childVC = [[ASPreviewingController alloc] init];
    childVC.servermodel = model;
    childVC.preferredContentSize = CGSizeMake(0, 220);    
    return childVC;
}

//pop（按用点力进入）
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
//    [self showViewController:viewControllerToCommit sender:self];
}

#pragma mark - lazyload

- (NSMutableArray *)dataSources {
    if (_dataSources) {
        return  _dataSources;
    }
    _dataSources = [NSMutableArray array];
    return _dataSources;
}

- (UITableView *)tableView {
    if(_tableView) {
        return  _tableView;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, self.view.frame.size.width, self.view.frame.size.height + 20) style:UITableViewStylePlain];
    return _tableView;
}

@end
