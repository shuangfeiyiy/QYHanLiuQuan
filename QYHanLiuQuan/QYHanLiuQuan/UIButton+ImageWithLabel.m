//
//  UIButton.m
//  QYHanLiuQuan
//
//  Created by QingYun on 14-10-28.
//  Copyright (c) 2014年 河南青云信息技术有限公司. All rights reserved.
//

#import "UIButton+ImageWithLabel.h"
@implementation UIButton (UIButtonImageWithLabel)

- (void)setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType{

    CGSize titleSize = [title sizeWithFont:[UIFont systemFontOfSize:16.0F]];
    [self.imageView setFrame:CGRectMake(0, 0, 30, 30)];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self setImageEdgeInsets:UIEdgeInsetsMake(.0, 5.0, 0.0, -titleSize.width-image.size.width)];
    [self setImage:image forState:stateType];
    
    [self.titleLabel setContentMode:UIViewContentModeCenter];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self.titleLabel setFont:[UIFont boldSystemFontOfSize:16.0f]];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0.0,
                                              -image.size.width-titleSize.width,
                                              0.0,
                                              0.0)];
    [self setTitle:title forState:stateType];
}
@end
