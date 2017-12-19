//
//  ASServerModel.h
//  SSServerList
//
//  Created by ashen on 2017/12/15.
//  Copyright © 2017年 <http://www.devashen.com> All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASServerModel : NSObject
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * ip;
@property (nonatomic, copy) NSString * port;
@property (nonatomic, copy) NSString * pwd;
@property (nonatomic, copy) NSString * style;
@property (nonatomic, copy) NSString * qrCodeUrl;
@property (nonatomic, copy) NSString * bgImageUrl;
@property (nonatomic, assign) NSInteger ping;
@end
