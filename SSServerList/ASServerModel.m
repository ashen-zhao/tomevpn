//
//  ASServerModel.m
//  SSServerList
//
//  Created by ashen on 2017/12/15.
//  Copyright © 2017年 <http://www.devashen.com> All rights reserved.
//

#import "ASServerModel.h"

@implementation ASServerModel
-(NSString *)bgImageUrl {
    return [NSString stringWithFormat:@"%@%@",@"https://global.ishadowx.net", _bgImageUrl];
}
@end
