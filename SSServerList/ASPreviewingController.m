//
//  ASPreviewingController.m
//  SSServerList
//
//  Created by ashen on 2017/12/18.
//  Copyright © 2017年 <http://www.devashen.com>. All rights reserved.
//

#import "ASPreviewingController.h"
#import "ASServerView.h"
#import "UIImageView+WebCache.h"
@interface ASPreviewingController ()

@end

@implementation ASPreviewingController

- (void)viewDidLoad {
    [super viewDidLoad];
    ASServerView * view = [[ASServerView alloc] initWithFrame:self.view.bounds];
    [view setupData:_servermodel];
    [self.view addSubview:view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:[NSString stringWithFormat:@"复制IP:%@",_servermodel.ip] style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = _servermodel.ip;
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:[NSString stringWithFormat:@"复制密码:%@",_servermodel.pwd] style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = _servermodel.pwd;
    }];
    
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:[NSString stringWithFormat:@"复制端口:%@",_servermodel.port] style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = _servermodel.port;
    }];
    
    UIPreviewAction *action4 = [UIPreviewAction actionWithTitle:@"保存二维码" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        UIImageView * temp = [[UIImageView alloc] init];
        NSURL * url = [NSURL URLWithString:_servermodel.qrCodeUrl];
        [temp sd_setImageWithURL:url];
        UIImageWriteToSavedPhotosAlbum(temp.image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    }];
    
    NSArray *actions = @[action1,action2,action3,action4];
    
    return actions;
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error == nil) {
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
