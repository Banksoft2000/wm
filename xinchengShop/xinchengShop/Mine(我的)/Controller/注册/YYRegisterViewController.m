//
//  YYRegisterViewController.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/30.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYRegisterViewController.h"
#import <Masonry.h>
#import <MBProgressHUD.h>
#import "YYRegisterData.h"
#import "YYRegisterNetTool.h"

@interface YYRegisterViewController ()<UITextFieldDelegate>

@property (nonatomic, retain)UITextField *userNameTextField;
@property (nonatomic, retain)UITextField *pwdTextField;
@property (nonatomic, retain)UITextField *configPwdTextField;
@property (nonatomic, retain)UITextField *mailTextField;
@property (nonatomic, retain)UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (nonatomic, strong) UIImageView *logoImage;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *securityCodeBtn;

@property (nonatomic, assign) CGFloat *transformY;

@property (nonatomic, strong) MBProgressHUD *progress;

@end

@implementation YYRegisterViewController

-(void)viewDidAppear:(BOOL)animated{

//    self.view.backgroundColor=[UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.navigationItem.title = @"会员注册";

    [self register];
    
    self.configPwdTextField.delegate=self;
    self.mailTextField.delegate=self;
    self.phoneNumberTextField.delegate=self;
    self.userNameTextField.delegate=self;
    self.pwdTextField.delegate=self;
 
}
//开始编辑输入框的时候软键盘出现
-(void)textFieldDidBeginEditing:(UITextField *)textField{

    CGRect frame = textField.frame;
    int offset = frame.origin.y + 45 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    NSLog(@"%d",offset);
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset >0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

//当用户按下return或回车键的时候keyboard会消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

    [textField resignFirstResponder];
    return YES;
}

//输入框完成编辑之后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField{

    self.view.frame=CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
}

//注册界面的搭建
-(void)register{

//    //自定义左键返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"title_back_icon"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, -20, 30, 30);
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=left;
    
    
    //logo图片框
    self.logoImage=[[UIImageView alloc]init];
//                    WithFrame:CGRectMake(49, 59, 215, 52)];
    self.logoImage.image=[UIImage imageNamed:@"logo_black"];
    
    [self.view addSubview:self.logoImage];
    
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view.mas_left).offset(50);
        make.top.equalTo(self.view.mas_top).offset(60);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-100, 50));
        
    }];
    
    
    
    
    
    //用户名输入框
    self.userNameTextField=[[UITextField alloc]initWithFrame:CGRectMake(10, 150,SCREEN_WIDTH - 20 , 45)];
    self.userNameTextField.placeholder = @"用户名";
    self.userNameTextField.borderStyle= UITextBorderStyleRoundedRect;
    [self.view addSubview:self.userNameTextField];
    
    //密码输入框
    self.pwdTextField=[[UITextField alloc]initWithFrame:CGRectMake(10, 200, SCREEN_WIDTH - 20, 45)];
    self.pwdTextField.placeholder = @"密码";
    self.pwdTextField.borderStyle= UITextBorderStyleRoundedRect;
    [self.view addSubview:self.pwdTextField];
    //确认密码输入框
    self.configPwdTextField=[[UITextField alloc]initWithFrame:CGRectMake(10, 250, SCREEN_WIDTH - 20, 45)];
    self.configPwdTextField.placeholder = @"确认密码";
    self.configPwdTextField.borderStyle= UITextBorderStyleRoundedRect;
    [self.view addSubview:self.configPwdTextField];
    //邮箱输入框
    self.mailTextField=[[UITextField alloc]initWithFrame:CGRectMake(10, 300, SCREEN_WIDTH - 20, 45)];
    self.mailTextField.placeholder = @"邮箱";
    self.mailTextField.borderStyle= UITextBorderStyleRoundedRect;
    [self.view addSubview:self.mailTextField];
    //输入手机输入框
    self.phoneNumberTextField=[[UITextField alloc]initWithFrame:CGRectMake(10, 350, SCREEN_WIDTH - 120 , 45)];
    self.phoneNumberTextField.placeholder = @"请输入手机号";
    self.phoneNumberTextField.borderStyle= UITextBorderStyleRoundedRect;
    [self.view addSubview:self.phoneNumberTextField];

    
    //发送验证码按钮
    
    self.securityCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.securityCodeBtn.frame = CGRectMake(SCREEN_WIDTH - 100, 350,90, 45);
//    self.securityCodeBtn.layer.cornerRadius = 10;
    [self.securityCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.securityCodeBtn.titleLabel.font=[UIFont systemFontOfSize:15.0f];
    self.securityCodeBtn.showsTouchWhenHighlighted = YES;
    self.securityCodeBtn.backgroundColor=[UIColor redColor];
    [self.securityCodeBtn addTarget:self action:@selector(clickToGetVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.securityCodeBtn];
    
    
    //注册按钮
    self.registerBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 410, SCREEN_WIDTH - 20, 60)];
    [self.registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    self.registerBtn.backgroundColor =[UIColor redColor];
    [self.registerBtn addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.registerBtn];
    
    
}

//获取验证码
-(void)clickToGetVerificationCode:(UIButton *)sender{

     _progress=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.phoneNumberTextField.placeholder=@"请输入验证码";
    NSString *phoneNumber = self.phoneNumberTextField.text;

    
    NSString *url=[NSString stringWithFormat:@"%@/front/smsUtil_mobileSend?mobilePhone=%@",BASE_URL,phoneNumber];
    
    
    [YYRegisterNetTool registerWithURL:url :^(id responsObjc) {
       
        NSString *success=[NSString stringWithFormat:@"%@",responsObjc[@"success"]];

         NSString *msg= responsObjc[@"msg"];
        
        if ([success isEqualToString:[NSString stringWithFormat:@"1"]]) {
         
            
            _progress.labelText=@"短信发送成功";
            [_progress hide:YES afterDelay:1.0];
            [self.phoneNumberTextField setText:@""];
        }else{
        
            if (self.phoneNumberTextField.text.length==0) {
                
                _progress.labelText=@"请输入手机号";
                [_progress hide:YES afterDelay:1.0];
            }else{

            
            _progress.labelText=[NSString stringWithFormat:@"%@",msg];
            [_progress hide:YES afterDelay:1.0];
                
            }
        }
        
        
    }];
    
    
   
    
    
}

//添加完就设计移除
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//点击注册按钮
-(void)registerButtonClick:(UIButton *)button{

    _progress=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *userName = self.userNameTextField.text;
    NSString *pwd= self.pwdTextField.text;
    NSString *mobileCode = self.phoneNumberTextField.text;
    NSString *mail=self.mailTextField.text;
    
    
    NSString *url=[NSString stringWithFormat:@"%@/app/_memberRegister?data.account=%@&data.password=%@&data.email=%@&mobileCode=%@",BASE_URL,userName,pwd,mail,mobileCode];
    [YYRegisterNetTool registerWithURL:url :^(id responsObjc) {
        
        NSString *success=[NSString stringWithFormat:@"%@",responsObjc[@"success"]];
        
        NSString *msg= responsObjc[@"msg"];
        
        if ([success isEqualToString:[NSString stringWithFormat:@"1"]]) {
            
            
            _progress.labelText=@"注册成功";
            [_progress hide:YES afterDelay:1.0];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            
            _progress.labelText=[NSString stringWithFormat:@"%@",msg];
            [_progress hide:YES afterDelay:1.0];
        }
       
    }];
    
    
    
    
    
    
}

//返回上一级登录界面
-(void)back{

    [self.navigationController popViewControllerAnimated:YES];
}




-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}

@end
