//
//  YYLoginController.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/30.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYLoginController.h"
#import "YYRegisterViewController.h"
#import "YYHttpRequest.h"
#import <MBProgressHUD.h>
#import "YYLoginNetTool.h"
#import "Utils.h"
#import <Masonry.h>
#import "YYMemberTool.h"
#import "YYShop.h"

#import "YYcombineLoginController.h"
#import "YYsanfangModel.h"
#import "YYSanfangTool.h"

#import "UMSocial.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"


@interface YYLoginController ()

@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, retain) UITextField *userTextField;
@property (nonatomic, retain) UITextField *pwdTextField;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UIButton *pwdSwitch;
@property (nonatomic, strong) MBProgressHUD *progress;
@property (strong, nonatomic)  UIButton *forgetPwd;
@property (strong, nonatomic)  UIButton *registerBtn;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *line2View;
@property (nonatomic, strong) UILabel *lineLabel;

@property (nonatomic, strong) UIButton *qqBtn;
@property (nonatomic, strong) UIButton *wxBtn;
@property (nonatomic, strong) UIButton *weiboBtn;

//登录成功后的组员信息
@property (nonatomic, strong) YYMember *model;
//登录返回的店铺信息
@property (nonatomic, strong) YYShop *shop;


@property (nonatomic, strong) YYsanfangModel *sanfangModel;

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation YYLoginController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.title = @"登陆";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:0 target:self action:@selector(back)];
    
    self.tableView=[[UITableView alloc]init];
    self.tableView.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.tableView.backgroundColor=[UIColor whiteColor];
    
    self.view=self.tableView;
    self.tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    
//    UIColor *backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"btn_checkbox_pressed"]];
    
//    [self.tableView setBackgroundColor:backgroundColor];
    
    //标志图片

    self.logoView=[[UIImageView alloc]init];
    self.logoView.image=[UIImage imageNamed:@"nc_login_pic"];
//    self.logoView.backgroundColor=[UIColor redColor];
    [self.tableView addSubview:self.logoView];
    
    self.logoView.backgroundColor=[UIColor redColor];
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {

        
        make.top.equalTo(self.tableView.mas_top);
        make.left.equalTo(self.tableView.mas_left);
        make.right.equalTo(self.tableView.mas_right);
        make.height.equalTo(@150);
    }];

    
    
    //用户名输入框
    self.userTextField=[[UITextField alloc]init];
    self.userTextField.placeholder=@"用户名/手机号/邮箱";
    self.userTextField.borderStyle=UITextBorderStyleRoundedRect;
    self.userTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    
    [self.tableView addSubview:self.userTextField];
    
    [self.userTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.tableView.mas_left);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 48));
        make.top.equalTo(self.logoView.mas_bottom).offset(10);
    }];
    
    
    //密码输入框
    self.pwdTextField=[[UITextField alloc]init];
    self.pwdTextField.placeholder=@"密码";
    self.pwdTextField.borderStyle=UITextBorderStyleRoundedRect;
    self.pwdTextField.rightViewMode=UITextFieldViewModeAlways;
    self.pwdTextField.rightView=[[UIView alloc]initWithFrame:CGRectMake(140, 160, 60, 40)];

    self.pwdSwitch=[UIButton buttonWithType:UIButtonTypeCustom];
    self.pwdSwitch.frame=CGRectMake(0, 5, 50, 30);
    
    [self.pwdSwitch setImage:[UIImage imageNamed:@"switch_in_hide"] forState:UIControlStateNormal];

    [self.pwdSwitch addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.pwdTextField.rightView addSubview:self.pwdSwitch];
    
    self.pwdTextField.secureTextEntry=YES;
    [self.tableView addSubview:self.pwdTextField];
    
    [self.pwdTextField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.userTextField);
        make.size.equalTo(self.userTextField);
        make.top.equalTo(self.userTextField.mas_bottom);
    }];
    
    
//    登录按钮
    self.loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];

    self.loginBtn.layer.cornerRadius=10;
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.backgroundColor=[UIColor redColor];
    self.loginBtn.showsTouchWhenHighlighted=YES;
    [self.loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:self.loginBtn];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 48));
        make.right.equalTo(self.tableView.mas_right).offset(-10);
        make.left.equalTo(self.tableView.mas_left).offset(10);
        make.top.equalTo(self.pwdTextField.mas_bottom).offset(20);
        make.height.mas_equalTo(48);
        
    }];
//    忘记密码按钮
    self.forgetPwd=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.forgetPwd setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.forgetPwd setTitle:@"忘记密码" forState:UIControlStateNormal];
    self.forgetPwd.titleLabel.font=[UIFont systemFontOfSize:15.0];
    
    [self.tableView addSubview:self.forgetPwd];
    [self.forgetPwd mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(66, 30));
        make.left.equalTo(self.loginBtn.mas_left).offset(10);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(10);
        
    }];
////    注册按钮
    self.registerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.registerBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.registerBtn setTitle:@"点击注册" forState:UIControlStateNormal];
    
    self.registerBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    
    [self.registerBtn addTarget:self action:@selector(registerUser:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView addSubview:self.registerBtn];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.loginBtn.mas_right).offset(-10);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(66, 30));
    }];
    
    
////    画的分割线
    self.lineView=[[UIView alloc]init];
    
    [self.tableView addSubview:self.lineView];
    
    self.lineView.backgroundColor=[UIColor lightGrayColor];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.loginBtn.mas_left);
        make.size.mas_equalTo(CGSizeMake(100, 0.5));
        make.top.equalTo(self.loginBtn.mas_bottom).offset(60);
    }];
//
////    第二根分割线
    self.line2View=[[UIView alloc]init];
    [self.tableView addSubview:self.line2View];
    
    self.line2View.backgroundColor=[UIColor lightGrayColor];
    [self.line2View mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.equalTo(self.loginBtn.mas_right);
        make.size.mas_equalTo(CGSizeMake(100, 0.5));
        make.top.equalTo(self.loginBtn.mas_bottom).offset(60);
    }];
//
////    线之间的文字
    self.lineLabel=[[UILabel alloc]init];
    self.lineLabel.text=@"合作账号登陆";
    self.lineLabel.textColor=[UIColor lightGrayColor];
    self.lineLabel.font=[UIFont systemFontOfSize:13.0];
    
    [self.tableView addSubview:self.lineLabel];
    
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        

        make.top.equalTo(self.loginBtn.mas_bottom).offset(54);
        make.centerX.mas_equalTo(self.tableView.mas_centerX);

    }];
//
//    
////    第三方登录的三个btn
    self.qqBtn=[[UIButton alloc]init];
    [self.qqBtn setImage:[UIImage imageNamed:@"nc_icon_qq"] forState:UIControlStateNormal];
    [self.tableView addSubview:self.qqBtn];
    [self.qqBtn addTarget:self action:@selector(logQQ:) forControlEvents:UIControlEventTouchUpInside];
    [self.qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.equalTo(self.tableView.mas_left).offset(30);
        make.top.equalTo(self.loginBtn.mas_top).offset(160);
    }];
//
////    微信登录
    self.wxBtn=[[UIButton alloc]init];
    [self.wxBtn setImage:[UIImage imageNamed:@"nc_icon_wx"] forState:UIControlStateNormal];
    [self.tableView addSubview:self.wxBtn];
    [self.wxBtn addTarget:self action:@selector(logWX:) forControlEvents:UIControlEventTouchUpInside];
    [self.wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qqBtn);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.centerX.mas_equalTo(self.tableView.mas_centerX);
    }];

////    微博登录
    self.weiboBtn=[[UIButton alloc]init];
    [self.weiboBtn setImage:[UIImage imageNamed:@"nc_icon_weibo"] forState:UIControlStateNormal];
    [self.tableView addSubview:self.weiboBtn];
    [self.weiboBtn addTarget:self action:@selector(logSina:) forControlEvents:UIControlEventTouchUpInside];
    [self.weiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tableView.mas_right).offset(-30);
        make.top.equalTo(self.wxBtn);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
}

//qq登录
-(void)logQQ:(UIButton *)sender{

    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@,openid is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL,snsAccount.openId);
            
            NSString *url=[NSString stringWithFormat:
                           @"%@/app/_thirdLogin?type=QQ&openId=%@",BASE_URL,snsAccount.openId];
            [YYLoginNetTool logInWithURL:url :^(id responsObjc) {
                
                //                [_progress hide:YES afterDelay:1];
                
                NSDictionary *data = responsObjc[@"data"];
                
                NSDictionary *xdata = data[@"member"];
                
                NSString *success=[NSString stringWithFormat:@"%@",responsObjc[@"success"]];
                
                NSString *msg= responsObjc[@"msg"];
                
                
                if ([success isEqualToString:[NSString stringWithFormat:@"1"]] ) {
                    
                    self.model = [[YYMember alloc] initWithDictionary:xdata];
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    //登录成功后保存数据
                    [YYMemberTool saveMember: self.model];
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"userRefresh" object:@(YES)];
                    
                }else{
                    
                                        [Utils createAllTextHUB:msg];
                    
                    //把获得的qq头像和用户名保存下来
                    
                    self.sanfangModel=[[YYsanfangModel alloc]init];
                    
                    self.sanfangModel.userName=snsAccount.userName;
                    self.sanfangModel.icon=snsAccount.iconURL;
                    self.sanfangModel.type=@"QQ";
                    self.sanfangModel.openId=snsAccount.openId;
                    
                    [YYsanfangTool saveModel:self.sanfangModel];
                    
                    YYcombineLoginController *combine=[[YYcombineLoginController alloc]init];
                    
                    [self.navigationController pushViewController:combine animated:YES];
                    
                }
                
            }];
            
        }});

    
}


//登录微信
-(void)logWX:(UIButton *)sender{

    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@,openId is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL,snsAccount.openId);
            
            
            
            NSString *url=[NSString stringWithFormat:
                           @"%@/app/_thirdLogin?type=WEIXIN&openId=%@",BASE_URL,snsAccount.openId];
            [YYLoginNetTool logInWithURL:url :^(id responsObjc) {
                
                //                [_progress hide:YES afterDelay:1];
                
                NSDictionary *data = responsObjc[@"data"];
                
                NSDictionary *xdata = data[@"member"];
                
                NSString *success=[NSString stringWithFormat:@"%@",responsObjc[@"success"]];
                
                NSString *msg= responsObjc[@"msg"];
                
                
                if ([success isEqualToString:[NSString stringWithFormat:@"1"]] ) {
                    
                    self.model = [[YYMember alloc] initWithDictionary:xdata];
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    //登录成功后保存数据
                    [YYMemberTool saveMember:self.model];
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"userRefresh" object:@(YES)];
                    
                }else{
                    
                                        [Utils createAllTextHUB:msg];
                    
                    //把获得的qq头像和用户名保存下来
                    
                    self.sanfangModel=[[YYsanfangModel alloc]init];
                    
                    self.sanfangModel.userName=snsAccount.userName;
                    self.sanfangModel.icon=snsAccount.iconURL;
                    self.sanfangModel.type=@"WEIXIN";
                    self.sanfangModel.openId=snsAccount.openId;
                    
                    [YYsanfangTool saveModel:self.sanfangModel];
                    
                    YYcombineLoginController *combine=[[YYcombineLoginController alloc]init];
                    
                    [self.navigationController pushViewController:combine animated:YES];
                    
                }
                
            }];
            
        }});
}

//新浪微博登录

-(void)logSina:(UIButton *)sender{

    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
//            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL,snsAccount.openId);
            
            NSString *url=[NSString stringWithFormat:
                           @"%@/app/_thirdLogin?type=WEIBO&openId=%@",BASE_URL,snsAccount.openId];
            [YYLoginNetTool logInWithURL:url :^(id responsObjc) {
                
                //                [_progress hide:YES afterDelay:1];
                
                NSDictionary *data = responsObjc[@"data"];
                
                NSDictionary *xdata = data[@"member"];
                
                NSString *success=[NSString stringWithFormat:@"%@",responsObjc[@"success"]];
                
                NSString *msg= responsObjc[@"msg"];
                
                
                if ([success isEqualToString:[NSString stringWithFormat:@"1"]] ) {
                    
                    self.model = [[YYMember alloc] initWithDictionary:xdata];
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    //登录成功后保存数据
                    [YYMemberTool saveMember: self.model];
                    //发送通知
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"userRefresh" object:@(YES)];
                    
                }else{
                    
                        [Utils createAllTextHUB:msg];
                    
                    //把获得的qq头像和用户名保存下来
                    
                    self.sanfangModel=[[YYsanfangModel alloc]init];
                    
                    self.sanfangModel.userName=snsAccount.userName;
                    self.sanfangModel.icon=snsAccount.iconURL;
                    self.sanfangModel.type=@"WEIBO";
                    self.sanfangModel.openId=snsAccount.openId;
                    
                    [YYsanfangTool saveModel:self.sanfangModel];
                    
                    YYcombineLoginController *combine=[[YYcombineLoginController alloc]init];
                    
                    [self.navigationController pushViewController:combine animated:YES];
                    
                }
                
            }];
        }});
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

///  返回登陆
-(void)back{

    [self dismissViewControllerAnimated:YES completion:nil];

}

//点击注册按钮
- (IBAction)registerUser:(id)sender {
    
    UIStoryboard *regist= [UIStoryboard storyboardWithName:@"YYRegisterControllerStoryboard" bundle:nil];
    
    YYRegisterViewController *regiVc = [regist instantiateViewControllerWithIdentifier:@"YYRegister"];
    
    [self.navigationController pushViewController:regiVc animated:YES];
    
}
//点击登录按钮

-(void)login:(UIButton *)sender{
    
    _progress=[MBProgressHUD showHUDAddedTo:self.tableView animated:YES];

    NSString *userName = self.userTextField.text;
    NSString *pwd=self.pwdTextField.text;
    _progress.labelText=@"正在登录";

     NSString *passwordStr = [Utils getMd5_32Bit:pwd];

//    NSString *url=[NSString stringWithFormat:@"http://xinchengguangchang.com/app/shopLogin?Account=%@&Password=%@",userName,passwordStr];

//    NSLog(@"---passwordstr ---%@",passwordStr);
    
     NSString *url=[NSString stringWithFormat:@"http://xinchengguangchang.com/app/shopLogin?Account=test222&Password=e10adc3949ba59abbe56e057f20f883e"];
    
//     NSString *url=[NSString stringWithFormat:@"http://xinchengguangchang.com/app/shopLogin?Account=15563068869&Password=96e79218965eb72c92a549dd5a330112"];
    
    [YYLoginNetTool logInWithURL:url :^(id responsObjc) {
       
        [_progress hide:YES afterDelay:1];
        
        NSDictionary *data = responsObjc[@"data"];
        
        NSDictionary *xdata = data[@"member"];
        
        NSDictionary *shop=data[@"shop"];
        
        NSString *success=[NSString stringWithFormat:@"%@",responsObjc[@"success"]];
        
        NSString *msg= responsObjc[@"msg"];
    
        
        if ([success isEqualToString:[NSString stringWithFormat:@"1"]] ) {
            
            self.model = [[YYMember alloc] initWithDictionary:xdata];
            
            
            self.shop= nil;
            
           self.shop = [[YYShop alloc]initWithDictionary:shop];
            

//            NSLog(@"%@",_shop.status);
            [self dismissViewControllerAnimated:YES completion:nil];
            //登录成功后保存数据
            [YYMemberTool saveMember: self.model];
            [YYMemberTool saveShop:self.shop];
            
            
            //发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"userRefresh" object:@(YES)];
            
        }else{
            
            [Utils createAllTextHUB:msg];
            
        }
     }];
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.tableView endEditing:YES];

}

@end
