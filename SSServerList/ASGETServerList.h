//
//  ASGETServerList.h
//  SSServerList
//
//  Created by ashen on 2017/12/15.
//  Copyright © 2017年 <http://www.devashen.com> All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASServerModel.h"
@interface ASGETServerList : NSObject
+ (void)getlist:(void(^)(NSArray *))success;
@end
