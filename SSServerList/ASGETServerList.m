//
//  ASGETServerList.m
//  SSServerList
//
//  Created by ashen on 2017/12/15.
//  Copyright © 2017年 <http://www.devashen.com> All rights reserved.
//

#import "ASGETServerList.h"

const static NSString *serverURL = @"https://global.ishadowx.net";
@implementation ASGETServerList

+ (void)getlist:(void(^)(NSArray *))success {
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:serverURL]];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error == nil) {
               NSString *responseObject = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                [self regexHtmlstr:responseObject success:success];
            }
        });
    }];
    [task resume];
}
+ (void)regexHtmlstr:(NSString *)html success:(void(^)(NSArray *))success {
//    <h4>IP Address:.+?>(.*?)</span>[\w\W]+?Port:.+?>(.*?)\n</span>[\w\W]+?Password:.+?>(.*?)\n</span>[\w\W]+?Method:(.*?)</h4>[\w\W]+?<h4><a href="(.*?)"[\w\W]+?<img src="(.*?)"
    NSString * regex = @"<h4>IP Address:.+?>(.*?)</span>[\\w\\W]+?Port:.+?>(.*?)\n</span>[\\w\\W]+?Password:.+?>(.*?)\n</span>[\\w\\W]+?Method:(.*?)</h4>[\\w\\W]+?<h4><a href=\"(.*?)\"[\\w\\W]+?<img src=\"(.*?)\"";
    NSRegularExpression * regular = [[NSRegularExpression alloc] initWithPattern:regex options:NSRegularExpressionCaseInsensitive error:nil];

    NSArray * matchs = [regular matchesInString:html options:NSMatchingReportProgress range:NSMakeRange(0, html.length)];
    
    NSMutableArray * lists = [NSMutableArray array];
    
    for (NSTextCheckingResult * match in matchs) {
        ASServerModel * model = [[ASServerModel alloc] init];
        model.name = [html substringWithRange:[match rangeAtIndex:1]];
        model.ip = [html substringWithRange:[match rangeAtIndex:1]];
        model.port = [html substringWithRange:[match rangeAtIndex:2]];
        model.pwd = [html substringWithRange:[match rangeAtIndex:3]];
        model.style = [html substringWithRange:[match rangeAtIndex:4]];
        model.qrCodeUrl = [NSString stringWithFormat:@"%@/%@",serverURL,[html substringWithRange:[match rangeAtIndex:5]]];
        model.bgImageUrl = [html substringWithRange:[match rangeAtIndex:6]];
        [lists addObject:model];
    }
    success(lists);
}
@end
