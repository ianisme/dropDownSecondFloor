//
//  DropDownSecondFloorView.m
//  dropDownSecondFloor
//
//  Created by quy21 on 2019/2/14.
//

#import "DropDownSecondFloorView.h"
#import "UIView+HHAddition.h"
#import <UIImageView+WebCache.h>

@interface DropDownSecondFloorView()

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation DropDownSecondFloorView


#pragma mark - private method

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        [self configView];
    }
    return self;
}

- (void)configView
{
    _imageView = [[UIImageView alloc] init];
    [self addSubview:_imageView];
    _imageView.frame = CGRectMake(0, 0, self.width, self.height);
    
    _tipLabel = [[UILabel alloc] init];
    [_imageView addSubview:_tipLabel];
    _tipLabel.frame = CGRectMake(0, _imageView.height - 21, _imageView.width, 12);
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.font = [UIFont systemFontOfSize:9.0f];
    _tipLabel.textColor = [UIColor whiteColor];
}

- (void)removeMyImageView
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.imageView.alpha = 0.0;
        [strongSelf.imageView setFrame:CGRectMake(-self.width/20, -self.height/20, 1.1*self.width, 1.1*self.height)];
        strongSelf.alpha = 0.0;
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf removeFromSuperview];
        if (self.imageFinish) {
            self.imageFinish();
        }
    }];
}


#pragma mark - setter and getter

- (void)setTip:(NSString *)tip
{
    _tip = tip;
    _tipLabel.text = tip;
}

- (void)setPicUrl:(NSString *)picUrl
{
    _picUrl = picUrl;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:picUrl]];
}


@end
