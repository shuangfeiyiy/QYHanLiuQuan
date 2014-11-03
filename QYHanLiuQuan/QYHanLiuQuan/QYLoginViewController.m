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
#import "AFNetworking.h"

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
    [self.navigationController popViewControllerAnimated:YES];
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
    [UIView animateWithDuration:timerInterval
                          delay:0.0f
                        options:animationOptions
                     animations:^{
                         
        
    } completion:nil];
    
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

- (IBAction)onLogginButton:(UIButton *)sender {
    //如果用户输入的账号不是手机号， 或者手机号非法，则禁止登录， 并提示用户
    if (![self validateMobile:self.accountNumField.text]) {
        [self showAlertViewWithTitle:@"请输入正确的手机号码"];
        return;
    }
    
    //验证不能有空白输入
    if (self.accountNumField.text.length == 0||self.passwordField.text.length == 0) {
        [self showAlertViewWithTitle:@"用户名或密码不能为空"];
        return;
    }
    
    if (self.passwordField.text.length < 8) {
        [self showAlertViewWithTitle:@"密码不能小于8位！"];
        return;
    }
    [self doLoginWithUserName:self.accountNumField.text andPassword:self.passwordField.text];
    
}

- (void)doLoginWithUserName:(NSString*)name andPassword:(NSString*)password
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"phone": name, @"passcode":password};
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:HLQ_STR_URL_LOGIN parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if (responseObject != nil) {
            NSString *reSuccess = [NSString stringWithFormat:@"%@",responseObject[@"success"]];
            if ([reSuccess isEqualToString:kHLQServerResponseSuccess]) {
                
                NSDictionary *responseData = responseObject[@"data"];
                NSLog(@"recv login info:%@",responseData);
//                登录成功后，回到应用程序主界面
                [self.navigationController popViewControllerAnimated:YES];
                [NSUD setBool:YES forKey:kIsAuthorOK];
            }else{
                UIAlertView *reUser = [[UIAlertView alloc]initWithTitle:@"登录失败" message:@"用户名或密码错误" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [reUser show];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView *reUser =[[UIAlertView alloc]initWithTitle:@"登录失败" message:@"网络不给力" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [reUser show];
    }];
    

}

- (void)showAlertViewWithTitle:(NSString *)title
{
    UIAlertView *alertView =  [[UIAlertView alloc] initWithTitle:@"错误" message:title delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

//[A-Z0-9a-z._%+-]+是表示 @ 符号之前的字符串是由 小写字母、大写字母、数字、下划线、中划线多个字符组成字符串，但不能是换行
//[A-Za-z0-9.-]是表示@ 符号之后的字符串是由 小写字母、大写字母、数字、下划线、中划线多个字符组成字符串，但不能是换行
//\.[a-zA-Z0-9_-] 表示由小黑点和小写字母、大写字母、数字、下划线、中划线多个字符组成字符串
//验证邮箱地址是否是正确的地址
-(BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
    
}

//根据传入的字符串手机号码，确认是否是合法的手机号
//返回YES:表示手机号合法
//返回NO:表示手机号非法
-(BOOL)validateMobile:(NSString*)mobile
{
    //手机号以13,15,18开头, 八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    NSLog(@"phoneTest is %@",phoneTest);
    
    return [phoneTest evaluateWithObject:mobile];
    
} 


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
