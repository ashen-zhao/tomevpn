//
//  ASServerView.m
//  SSServerList
//
//  Created by ashen on 2017/12/18.
//  Copyright © 2017年 <http://www.devashen.com>. All rights reserved.
//

#import "ASServerView.h"
#import "UIImageView+WebCache.h"

static const CGFloat LblY = 7;

@interface ASServerView()
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) UILabel *lblIP;
@property (nonatomic, strong) UILabel *lblPort;
@property (nonatomic, strong) UILabel *lblPwd;
@property (nonatomic, strong) UILabel *lblMethod;
@end

@implementation ASServerView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.bgImage];
        [self.bgImage addSubview:self.borderView];
        [self.bgImage addSubview:self.lblIP];
        [self.bgImage addSubview:self.lblPort];
        [self.bgImage addSubview:self.lblPwd];
        [self.bgImage addSubview:self.lblMethod];
    }
    return self;
}


#pragma mark - methods
- (void)setupData:(ASServerModel *)model {
    NSURL * url = [NSURL URLWithString:model.bgImageUrl];
    [self.bgImage sd_setImageWithURL:url];
    self.lblIP.text = [NSString stringWithFormat:@"IP: %@", model.ip];
    self.lblPort.text = [NSString stringWithFormat:@"Port: %@", model.port];
    self.lblPwd.text = [NSString stringWithFormat:@"Pwd: %@", model.pwd];
    self.lblMethod.text = [NSString stringWithFormat:@"Method: %@", model.style];
}

- (void)setupLabelStyle:(UILabel *)lbl {
    lbl.textColor = [UIColor whiteColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
}


#pragma mark - Lazy Loading
- (UIImageView *)bgImage {
    if (_bgImage) {
        return _bgImage;
    }
    _bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width, 220)];
    _bgImage.layer.cornerRadius = 10;
    _bgImage.layer.masksToBounds = YES;
    return _bgImage;
}

- (UIView *)borderView {
    if (_borderView) {
        return _borderView;
    }
    _borderView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, self.bgImage.frame.size.width - 10, self.bgImage.frame.size.height - 10)];
    _borderView.backgroundColor = [UIColor clearColor];
    _borderView.layer.borderColor = [[UIColor whiteColor] CGColor];
    _borderView.layer.borderWidth = 1;
    return _borderView;
}

- (UILabel *)lblIP {
    if (_lblIP) {
        return _lblIP;
    }
    _lblIP = [[UILabel alloc] initWithFrame:CGRectMake(0, LblY + 10, self.bgImage.frame.size.width, 30)];
    [self setupLabelStyle:_lblIP];
    return _lblIP;
}

- (UILabel *)lblPort {
    if (_lblPort) {
        return _lblPort;
    }
    
    _lblPort = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lblIP.frame) + LblY, self.bgImage.frame.size.width, 30)];
    [self setupLabelStyle:_lblPort];
    return _lblPort;
}

- (UILabel *)lblPwd {
    if (_lblPwd) {
        return _lblPwd;
    }
    _lblPwd = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lblPort.frame) + LblY, self.bgImage.frame.size.width, 30)];
    [self setupLabelStyle:_lblPwd];
    return _lblPwd;
}

- (UILabel *)lblMethod {
    if (_lblMethod) {
        return _lblMethod;
    }
    _lblMethod = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.lblPwd.frame) + LblY, self.bgImage.frame.size.width, 30)];
    [self setupLabelStyle:_lblMethod];
    return _lblMethod;
}


@end
