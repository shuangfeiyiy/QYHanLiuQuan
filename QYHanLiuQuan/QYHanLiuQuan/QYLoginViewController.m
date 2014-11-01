//
//  QYLoginViewController.m
//  QYHanLiuQuan
//
//  Created by QingYun on 14-10-28.
//  Copyright (c) 2014年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYLoginViewController.h"
#import "QYCommonDefine.h"
#import "QYConstDefine.h"

@interface QYLoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *inputBGV;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *accountNumField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
//记录当前的UITextField对象， 主要控制点击非编辑区的时候键盘的隐藏
@property (strong ,nonatomic) UITextField *currentTextField;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *microblogBtn;
@property (nonatomic, retain) UISwipeGestureRecognizer *swipGesture;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;

@end

@implementation QYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
}

- (IBAction)onBackBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //注册登录客户端成功后通知事件，事件响应方法是loginSuccess：
    [QYNSDC addObserver:self selector:@selector(loginSuccess:) name:kQYNotificationNameLogin object:nil];
    //注册系统键盘将要显示的通知事件，事件响应方法是keyBoardWillShow：
    [QYNSDC addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //注册系统键盘将要隐藏的通知事件，事件响应方法是keyBoardWillHide：
    [QYNSDC addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];

}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    //在界面将要消失的时候， 需要将在该界面将要消失的时候，反注册的相应的通知事件
    [QYNSDC removeObserver:self name:kQYNotificationNameLogin object:nil];
    [QYNSDC removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [QYNSDC removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}

#pragma mark -
#pragma mark HanLiuQuan 登录成功通知事件
- (void)loginSuccess:(NSNotification *)notification
{
    NSLog(@"%s",__func__);
}

#pragma mark -
#pragma mark UIKeyboard notification
- (void)keyBoardWillShow:(NSNotification*)nofication
{
    //键盘弹出的时候， 在view上添加一个手势，当点击除键盘之外的任何区域，让键盘消失
    self.swipGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onUserTappedViewWithKeybboarShow:)];
    self.swipGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:self.swipGesture];
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onUserTappedViewWithKeybboarShow:)];
    [self.view addGestureRecognizer:self.tapGesture];
    
    NSDictionary *userInfo = nofication.userInfo;
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat timerInterval = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationOptions animationOptions = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
}

- (void)onUserTappedViewWithKeybboarShow:(UISwipeGestureRecognizer*)gesture
{
    [self.currentTextField resignFirstResponder];
}

- (void)keyBoardWillHide:(NSNotification*)nofication
{
    [self.view removeGestureRecognizer:self.swipGesture];
    NSDictionary *userInfo = nofication.userInfo;
    CGFloat timerInterval = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationOptions animationOptions = [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:timerInterval
                          delay: 0.0
                        options: animationOptions
                     animations:^{
                         
                     }
                     completion:nil];
}


#pragma mark -
#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.currentTextField = textField;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
