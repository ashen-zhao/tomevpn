//
//  ASServerListCell.h
//  SSServerList
//
//  Created by ashen on 2017/12/15.
//  Copyright © 2017年 <http://www.devashen.com> All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASServerModel.h"
@interface ASServerListCell : UITableViewCell
@property (nonatomic, strong) UIButton *btnqrcode;

- (void)setupData:(ASServerModel *)model;

@end
