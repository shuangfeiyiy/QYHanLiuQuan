//
//  QYUserGuideViewController.m
//  QYHanLiuQuan
//
//  Created by QingYun on 14-10-28.
//  Copyright (c) 2014年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYUserGuideViewController.h"
#import "QYViewControllerManager.h"

@interface QYUserGuideViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation QYUserGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(320*5, self.view.bounds.size.height);
    
    for (int i = 0 ;  i < 5; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(320*i, 0, 320, self.view.bounds.size.height)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_features_%d.jpg",i+1]];
        [self.scrollView addSubview:imageView];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int offSet = 320*4+100;
    if (scrollView.contentOffset.x - offSet > 0) {
        [QYViewControllerManager presentQYController:QYViewControllerTypeMainTabBar];
    }
}

@end
