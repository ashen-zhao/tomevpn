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
#import "MBProgressHud.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,UIViewControllerPreviewingDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSources;

#pragma mark - Refresh
@property (nonatomic, strong) UIView * refreshView;
@property (nonatomic, strong) UILabel * lblStatus;
@property (nonatomic, strong) UIActivityIndicatorView * indicator;
@end

@implementation ViewController


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:ASServerListCell.class forCellReuseIdentifier:@"serverIden"];
    [self.refreshView addSubview:self.indicator];
    [self.refreshView addSubview:self.lblStatus];
    [self.tableView addSubview:self.refreshView];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self refreshData:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Methods
- (void)refreshData:(void(^)(void))success {
    
    [ASGETServerList getlist:^(NSArray *list) {
        [self.dataSources removeAllObjects];
        [self.dataSources addObjectsFromArray:list];
        [self.tableView reloadData];
        if (success) {
            success();
        }
    }];
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y > -64.0f && scrollView.contentOffset.y < 0.0f) {
        self.lblStatus.text = @"下拉刷新";
        [_indicator stopAnimating];
    } else if ([@"下拉刷新" isEqualToString:self.lblStatus.text] && scrollView.contentOffset.y < -64.0f ) {
        self.lblStatus.text = @"释放刷新";
        [_indicator stopAnimating];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y <= -64.0) {
        self.lblStatus.text = @"加载中";
        [_indicator startAnimating];
        scrollView.contentInset = UIEdgeInsetsMake(64.0f, 0.0f, 0.0f, 0.0f);
        [self refreshData:^{
            [UIView animateWithDuration:0.318 animations:^{
                scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
            }];
        }];
    }
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
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    return _tableView;
}

- (UIView *)refreshView {
    if (_refreshView) {
        return _refreshView;
    }
    _refreshView = [[UILabel alloc] initWithFrame:CGRectMake(0, -64, self.tableView.frame.size.width, 64)];
    return _refreshView;
}

- (UIActivityIndicatorView *)indicator {
    if (_indicator) {
        return _indicator;
    }
    _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    _indicator.center = CGPointMake(self.refreshView.center.x - 40, self.refreshView.center.y + 64);
    [_indicator setHidesWhenStopped:NO];
    return _indicator;
}

- (UILabel *)lblStatus {
    if (_lblStatus) {
        return _lblStatus;
    }
    _lblStatus = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.indicator.frame)+15, 0, 70, 64)];
    _lblStatus.font = [UIFont systemFontOfSize:15];
    _lblStatus.textColor = [UIColor grayColor];
    return _lblStatus;
}

@end
