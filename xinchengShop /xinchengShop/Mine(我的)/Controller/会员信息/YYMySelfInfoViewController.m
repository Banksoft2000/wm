//
//  YYMySelfInfoViewController.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/30.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYMySelfInfoViewController.h"
#import "YYMemberTool.h"

@interface YYMySelfInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *mail;
@property (weak, nonatomic) IBOutlet UIButton *exit;

@end

@implementation YYMySelfInfoViewController


-(void)viewDidLoad{

    self.navigationItem.title=@"个人信息";
    self.view=[[[NSBundle mainBundle]loadNibNamed:@"YYMySelfInfoViewController" owner:self options:nil]lastObject];

    
    [self initData];
    
    //点击退出按钮
    [_exit addTarget:self action:@selector(exitLogin) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 30, 30);
//    btn.backgroundColor=[UIColor clearColor];
//    btn.alpha=0;
    [btn setImage:[UIImage imageNamed:@"title_back_icon"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)back:(UIButton *)sender{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"userRefresh"  object:@(YES)];
    
    [self.navigationController popViewControllerAnimated:YES];

    
}

//点击登录按钮
-(void)exitLogin{
    
    

    [YYMemberTool saveMember:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"userRefresh"  object:@(YES)];
    
    [self.navigationController popViewControllerAnimated:YES];
}


//获取数据
-(void)initData{

    _member=[YYMemberTool member];
    [self setMyInfoView ];
    
    
    
}

-(void)setMyInfoView{

    if (_member !=nil) {
        _userName.text=_member.account;
        _phoneNumber.text=_member.telephone;
        _mail.text=_member.email;
    }
}




@end
