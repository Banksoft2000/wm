//
//  YYConnetLoadViewController.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/5.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYConnetLoadViewController.h"
#import <Masonry.h>
#import <MBProgressHUD.h>
#import "Utils.h"
#import "YYLoginNetTool.h"
#import "YYMember.h"
#import "YYMemberTool.h"
#import "YYSanfangTool.h"
#import "YYsanfangModel.h"

#define font15  [UIFont systemFontOfSize:15.0]


@interface YYConnetLoadViewController ()
@property (nonatomic, strong) UITextField *pwdTextField;
@property (nonatomic, strong) UITextField *accountField;
@property (nonatomic, strong) MBProgressHUD *progress;
@property (nonatomic, strong) YYMember *member;
@property (nonatomic, strong) YYsanfangModel *sanfangModel;
@end

@implementation YYConnetLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=[UIColor colorWithRed:248.0/255 green:248.0/255 blue:248.0/255 alpha:1.0];
    self.navigationItem.title=@"立即关联";
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 30, 30);
    //    btn.backgroundColor=[UIColor clearColor];
    //    btn.alpha=0;
    [btn setImage:[UIImage imageNamed:@"title_back_icon"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    

    self.sanfangModel=[YYsanfangTool sanfang];
    [self layout];
    
}
-(void)back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
//页面布局

-(void)layout{

    //关联已有账号
    UILabel *lbl1=[[UILabel alloc]init];
    lbl1.text=@"关联已有账号";
    lbl1.textColor=[UIColor lightGrayColor];
    lbl1.font=font15;
    [self.view addSubview:lbl1];
    [lbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(self.view.mas_top).offset(25);
        make.size.mas_offset(CGSizeMake(150, 30));
        
    }];
    
    //账号密码
    UITextField *accountField=[[UITextField alloc]init];
    accountField.placeholder=@"请输入用户名/邮箱/已验证手机";
    accountField.font=font15;
    accountField.borderStyle=UITextBorderStyleRoundedRect;
    [self.view addSubview:accountField];
    [accountField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lbl1);
        make.top.equalTo(lbl1.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-40, 50));
    }];
    
    
    UITextField *pwdField=[[UITextField alloc]init];
    self.pwdTextField=pwdField;
    
    pwdField.placeholder=@"请输入密码";
    
    pwdField.rightViewMode=UITextFieldViewModeAlways;
    pwdField.rightView=[[UIView alloc]initWithFrame:CGRectMake(140, 160, 60, 40)];
    
     UIButton *btnSwitch =[UIButton buttonWithType:UIButtonTypeCustom];
    btnSwitch.frame=CGRectMake(0, 5, 50, 30);
    
    [btnSwitch setImage:[UIImage imageNamed:@"switch_in_hide"] forState:UIControlStateNormal];
    
    [btnSwitch addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [pwdField.rightView addSubview:btnSwitch];

    pwdField.secureTextEntry = YES;
    [self.view addSubview:pwdField];
    pwdField.font=font15;
    pwdField.borderStyle=UITextBorderStyleRoundedRect;
    [pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(accountField);
        make.top.equalTo(accountField.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-40, 50));
    }];
    
    
    
    //关联后。。。。
    UILabel *btnLbl=[[UILabel alloc]init];
    btnLbl.text=@"关联后，您的两个账号都能登录";
    btnLbl.textColor=[UIColor lightGrayColor];
    btnLbl.font=[UIFont systemFontOfSize:13.0];
    [self.view addSubview:btnLbl];
    [btnLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(pwdField.mas_left);
        make.top.equalTo(pwdField.mas_bottom).offset(40);
        make.size.mas_equalTo(CGSizeMake(200, 20));
        
    }];
    
    //登录按钮
    UIButton *loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    loginBtn.layer.cornerRadius=4.0;
    loginBtn.backgroundColor=[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
    loginBtn.titleLabel.font=font15;
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(clickLogInBtn:) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(btnLbl.mas_bottom).offset(5);
        make.left.equalTo(btnLbl.mas_left);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-40, 48));
    }];
    
    
    //找回密码
    
    UIButton *backPwd=[UIButton buttonWithType:UIButtonTypeCustom];
    [backPwd setTitle:@"找回密码" forState:UIControlStateNormal];
    [backPwd setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    backPwd.titleLabel.font=[UIFont systemFontOfSize:13.0];
//    backPwd.titleLabel.textAlignment=UITextAlignmentRight;
    [self.view addSubview:backPwd];
    [backPwd mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(loginBtn.mas_right);
        make.top.equalTo(loginBtn.mas_bottom).offset(30);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    
}

//切换密码输入状态
-(void)clickBtn:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [sender setImage:[UIImage imageNamed:@"switch_in_show"] forState:UIControlStateNormal];
        self.pwdTextField.secureTextEntry=NO;
    }else {
        [sender setImage:[UIImage imageNamed:@"switch_in_hide"] forState:UIControlStateNormal];
        self.pwdTextField.secureTextEntry=YES;
    }
}

//点击登录按钮
-(void)clickLogInBtn:(UIButton *)sender{
    
    _progress=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *userName = self.accountField.text;
    NSString *pwd=self.pwdTextField.text;
    _progress.labelText=@"正在登录";
    
    NSString *passwordStr = [Utils getMd5_32Bit:pwd];
    
//    http://xinchengguangchang.com/app/thirdLogin_login?Account=15563068869&Password=96e79218965eb72c92a549dd5a330112&type=QQ&openId=43FD31309CA6E1E797B981121E19F06B
    
    NSString *url=[NSString stringWithFormat:@"%@/app/shopLogin?Account=%@&Password=%@?type=%@&openId=%@",BASE_URL,userName,passwordStr,self.sanfangModel.type,self.sanfangModel.openId];
//    NSString *url= [NSString stringWithFormat:@"http://xinchengguangchang.com/app/thirdLogin_login?Account=15563068869&Password=96e79218965eb72c92a549dd5a330112&type=QQ&openId=43FD31309CA6E1E797B981121E19F06B"];
    
    NSLog(@"%@",url);
    
    [YYLoginNetTool logInWithURL:url :^(id responsObjc) {
        
        [_progress hide:YES afterDelay:1];
        
        NSDictionary *data = responsObjc[@"data"];
        
        NSDictionary *xdata = data[@"member"];
        
        NSString *success=[NSString stringWithFormat:@"%@",responsObjc[@"success"]];
        
        NSString *msg= responsObjc[@"msg"];
        
        
        if ([success isEqualToString:[NSString stringWithFormat:@"1"]] ) {
            
            self.member = [[YYMember alloc] initWithDictionary:xdata];
            [self dismissViewControllerAnimated:YES completion:nil];
            //登录成功后保存数据
            [YYMemberTool saveMember: self.member];
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"userRefresh" object:@(YES)];
            
        }else{
            
            [Utils createAllTextHUB:msg];
            
        }
        
    }];

    
    
}


@end
