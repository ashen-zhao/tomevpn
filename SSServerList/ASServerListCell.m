//
//  ASServerListCell.m
//  SSServerList
//
//  Created by ashen on 2017/12/15.
//  Copyright © 2017年 <http://www.devashen.com> All rights reserved.
//

#import "ASServerListCell.h"
#import "UIImageView+WebCache.h"

static const CGFloat LblY = 7;
static const CGFloat QRSize = 150;

@interface ASServerListCell()
@property (nonatomic, strong) UILabel *lblPing;
@property (nonatomic, strong) UIImageView *bgImage;
@property (nonatomic, strong) UIImageView *qrImage;
@property (nonatomic, strong) UIView *borderView;
@property (nonatomic, strong) UILabel *lblIP;
@property (nonatomic, strong) UILabel *lblPort;
@property (nonatomic, strong) UILabel *lblPwd;
@property (nonatomic, strong) UILabel *lblMethod;
@end

@implementation ASServerListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.bgImage];
        self.bgImage.userInteractionEnabled = YES;
        [self.bgImage addSubview:self.borderView];
        [self.bgImage addSubview:self.lblIP];
        [self.bgImage addSubview:self.lblPort];
        [self.bgImage addSubview:self.lblPwd];
        [self.bgImage addSubview:self.lblMethod];
        [self.bgImage addSubview:self.qrImage];
        [self.bgImage addSubview:self.btnqrcode];
        [self.contentView addSubview:self.lblPing];
        
        [self.btnqrcode addTarget:self action:@selector(modeQR) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(modeQR)];
        self.qrImage.userInteractionEnabled = YES;
        [self.qrImage addGestureRecognizer:tap];
//        UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(press)];
//        [self.qrImage addGestureRecognizer:press];
    }
    return self;
}

- (void)press {
    UIImageWriteToSavedPhotosAlbum(self.qrImage.image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
}

- (void)modeQR {
    if (self.qrImage.frame.origin.x == _bgImage.frame.size.width - 30) {
        [UIView animateWithDuration:0.618 animations:^{
            self.qrImage.frame = CGRectMake((self.bgImage.frame.size.width - QRSize)/2, (self.bgImage.frame.size.height - QRSize)/2, QRSize, QRSize);
        }];
    } else {
        [UIView animateWithDuration:0.618 animations:^{
            _qrImage.frame = CGRectMake(_bgImage.frame.size.width - 30, CGRectGetMaxY(_lblMethod.frame) + 20, 0, 0);
        }];
    }
}

- (void)layoutSubviews {
    _lblPing.frame = CGRectMake(20, 15, 100, 30);
    _bgImage.frame = CGRectMake(8, 5, self.contentView.frame.size.width - 16, self.contentView.frame.size.height - 10);
    _borderView.frame = CGRectMake(5, 5, self.bgImage.frame.size.width - 10, self.bgImage.frame.size.height - 10);
    _lblIP.frame = CGRectMake(0, LblY + 10, self.bgImage.frame.size.width, 30);
    _lblPort.frame = CGRectMake(0, CGRectGetMaxY(self.lblIP.frame) + LblY, self.bgImage.frame.size.width, 30);
    _lblPwd.frame = CGRectMake(0, CGRectGetMaxY(self.lblPort.frame) + LblY, self.bgImage.frame.size.width, 30);
    _lblMethod.frame = CGRectMake(0, CGRectGetMaxY(self.lblPwd.frame) + LblY, self.bgImage.frame.size.width, 30);
    _btnqrcode.frame = CGRectMake(_bgImage.frame.size.width - 50, CGRectGetMaxY(_lblMethod.frame), 35, 35);
    _qrImage.frame = CGRectMake(_bgImage.frame.size.width - 30, CGRectGetMaxY(_lblMethod.frame) + 20, 0, 0);
}


#pragma mark - methods
- (void)setupData:(ASServerModel *)model {
    self.lblPing.text = [NSString stringWithFormat:@"Ping:%ldms",model.ping];
    NSURL * bgurl = [NSURL URLWithString:model.bgImageUrl];
    [self.bgImage sd_setImageWithURL:bgurl];
    NSURL * qrurl = [NSURL URLWithString:model.qrCodeUrl];
    [self.qrImage sd_setImageWithURL:qrurl];
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
    _bgImage = [[UIImageView alloc] init];
    return _bgImage;
}

- (UIView *)borderView {
    if (_borderView) {
        return _borderView;
    }
    _borderView = [[UIView alloc] init];
    _borderView.backgroundColor = [UIColor clearColor];
    _borderView.layer.borderColor = [[UIColor whiteColor] CGColor];
    _borderView.layer.borderWidth = 1;
    return _borderView;
}

- (UILabel *)lblIP {
    if (_lblIP) {
        return _lblIP;
    }
    _lblIP = [[UILabel alloc] init];
    [self setupLabelStyle:_lblIP];
    return _lblIP;
}

- (UILabel *)lblPort {
    if (_lblPort) {
        return _lblPort;
    }
    
    _lblPort = [[UILabel alloc] init];
    [self setupLabelStyle:_lblPort];
    return _lblPort;
}

- (UILabel *)lblPwd {
    if (_lblPwd) {
        return _lblPwd;
    }
    _lblPwd = [[UILabel alloc] init];
    [self setupLabelStyle:_lblPwd];
    return _lblPwd;
}

- (UILabel *)lblMethod {
    if (_lblMethod) {
        return _lblMethod;
    }
    _lblMethod = [[UILabel alloc] init];
    [self setupLabelStyle:_lblMethod];
    return _lblMethod;
}

- (UIButton *)btnqrcode {
    if (_btnqrcode) {
        return _btnqrcode;
    }
    _btnqrcode = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btnqrcode setImage:[UIImage imageNamed:@"qrcode"] forState:UIControlStateNormal];
    return _btnqrcode;
}

- (UIImageView *)qrImage {
    if (_qrImage) {
        return _qrImage;
    }
    _qrImage = [[UIImageView alloc] init];
    _qrImage.frame = CGRectMake(_bgImage.frame.size.width - 30, CGRectGetMaxY(_lblMethod.frame) + 20, 0, 0);

    return _qrImage;
}

- (UILabel *)lblPing {
    if (_lblPing) {
        return  _lblPing;
    }
    _lblPing = [[UILabel alloc] init];
    [self setupLabelStyle:_lblPing];
    _lblPing.textAlignment = NSTextAlignmentLeft;
    return _lblPing;
}


@end
