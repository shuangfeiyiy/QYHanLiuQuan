//
//  focusView.m
//  HallyuTest
//
//  Created by qingyun on 14-8-11.
//  Copyright (c) 2014年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYAutoScrollFocusView.h"
#import "UIViewExt.h"

@interface QYAutoScrollFocusView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, assign) NSInteger totalPageCount;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *animationTimer;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, retain) UIButton *btn;

@end

CGFloat titleLabelOgHigh = 20;

static NSTimeInterval setpTime;
@implementation QYAutoScrollFocusView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame withImageArray:(NSArray *)imgArr andStepTime:(NSTimeInterval)time
{
    self = [super initWithFrame:frame];
    if (self) {
        setpTime = time;
        _imgArray = [NSMutableArray arrayWithCapacity:0];
        if (imgArr.count > 0) {
            [_imgArray addObject:[imgArr lastObject]];
            for (UIImage *img in imgArr) {
                [_imgArray addObject:img];
            }
            NSLog(@"imgArr.count %lu",(unsigned long)imgArr.count);
            [_imgArray addObject:[imgArr objectAtIndex:0]];
        }
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //加载图片
    [self composition];
}

- (void)composition
{
    //防止传入的图片数组为空时，程序会崩溃
    if ((_imgArray == nil) || (_imgArray.count == 0)) {
        _totalPageCount = 1;
    }
    else
    {
        _totalPageCount = _imgArray.count;
    }
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    _scrollView.height -= titleLabelOgHigh;
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(self.width * _totalPageCount, _scrollView.height);
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    [_scrollView setContentOffset:CGPointMake(_scrollView.width, 0) animated:NO];
    [self addSubview:_scrollView];
    
    
    //将数组中的图片一次添加到scrollView上
    [self addImageToScrollView];
    
    //为scrollView添加轻击手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageViewAction:)];
    [_scrollView addGestureRecognizer:tapGesture];
    
    //添加图片主题简介
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _scrollView.bottom, self.width, self.height - _scrollView.height)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = (_titleFont == nil ? [UIFont systemFontOfSize:17.0] : _titleFont);
    if (_focusTitleArr.count != 0) {
        _titleLabel.text = _focusTitleArr[0];
    }else{
        _titleLabel.text = @"";
    }
    
    [self addSubview:_titleLabel];
}

- (void)addImageToScrollView
{
    for (int i = 0; i < _imgArray.count; i ++)
    {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(_scrollView.width * i, 0, _scrollView.width, _scrollView.height)];
        imgView.userInteractionEnabled = NO;
        imgView.image = _imgArray[i];
        [_scrollView addSubview:imgView];
    }
}

#pragma mark - action
//计时器循环事件
- (void)animationTimerDidFired:(NSTimer *)timer
{
    CGPoint newOffset = CGPointZero;
    //如果当前为最后一页，则滚动到第一页
    if (_scrollView.contentOffset.x != _scrollView.width * (_totalPageCount - 1))
    {
        int contentX = (int)(_scrollView.contentOffset.x/_scrollView.width);
//        _titleLabel.text = _focusTitleArr[contentX%(_totalPageCount-2)];
        newOffset = CGPointMake(contentX * _scrollView.width + _scrollView.width, _scrollView.contentOffset.y);
    }
    [self.scrollView setContentOffset:newOffset animated:YES];
}

//启动定时器
- (void)startTimer
{
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:setpTime target:self selector:@selector(animationTimerDidFired:) userInfo:nil repeats:YES];
}

//注销定时器
- (void)stopTimer
{
    [_animationTimer invalidate];
}

//点击scrollView的事件，并回调代理
- (void)tapImageViewAction:(UITapGestureRecognizer *)tapGesture
{
    NSInteger tapIndex = [tapGesture locationInView:_scrollView].x/(_scrollView.width);
    if ([self.delegate respondsToSelector:@selector(tapFocusSrcollViewAtIndex:)] && _imgArray && _imgArray.count != 0) {
        [self.delegate tapFocusSrcollViewAtIndex:tapIndex - 2];
    }
}

//开始拖动时，关闭定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}

//拖动结束后，重新开启定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

//循环图片
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //选title的数组
    int contentX = (int)(_scrollView.contentOffset.x/_scrollView.width);
    contentX = contentX%(_totalPageCount-2)  -1;
    if (contentX<0) {
        contentX = _totalPageCount-3;
    }
    if (_focusTitleArr.count != 0 && _imgArray.count != 0 && _imgArray != nil) {
        _titleLabel.text = _focusTitleArr[contentX];
    }
    
    if (scrollView.contentOffset.x == 0) {
        [scrollView setContentOffset:CGPointMake(scrollView.width * (_totalPageCount - 2), 0) animated:NO];
    }
    if (scrollView.contentOffset.x >= _scrollView.width * (_totalPageCount - 1) ) {
        [scrollView setContentOffset:CGPointMake(_scrollView.width, 0) animated:NO];
    }
    
}
@end
