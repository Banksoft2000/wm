//
//  YYcombineLoginController.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/5.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYcombineLoginController.h"
#import "YYMember.h"
#import "YYMemberTool.h"
#import "YYRegisterViewController.h"
#import "YYConnetLoadViewController.h"
#import <Masonry.h>
#import "YYSanfangTool.h"
#import "YYsanfangModel.h"

#import <UIImageView+WebCache.h>


#define font15 [UIFont systemFontOfSize:15]
@interface YYcombineLoginController ()

@property (nonatomic, strong) YYsanfangModel *model;
@property (nonatomic, strong) UIImageView *iconImage;

@end

@implementation YYcombineLoginController



- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor=[UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];
    
    self.model=[YYsanfangTool sanfang];
    
    self.navigationItem.title=@"联合登录";
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 30, 30);
    //    btn.backgroundColor=[UIColor clearColor];
    //    btn.alpha=0;
    [btn setImage:[UIImage imageNamed:@"title_back_icon"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    [btn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];

    
    [self initLayout];
    
   
}
-(void)back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];

}

//界面的控件布局
-(void)initLayout{

   
    
    //头像
    UIImageView *iconView=[[UIImageView alloc]init];
    [self.view addSubview:iconView];
    [iconView sd_setImageWithURL:self.model.icon];
//    iconView.backgroundColor=[UIColor redColor];
    iconView.layer.masksToBounds=YES;
    iconView.layer.cornerRadius=50;
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 100));
        make.top.equalTo(self.view.mas_top).offset(20);
        
    }];
    
    //用户名
    UILabel *nameLabel=[[UILabel alloc]init];
    nameLabel.text=@"亲爱的用户:";
    nameLabel.textColor=[UIColor lightGrayColor];
//    nameLabel.font=font15;
    [self.view addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view.mas_left).offset(20);
        make.top.equalTo(iconView.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    //获取的用户名
    UILabel *nameLbl2=[[UILabel alloc]init];
    nameLbl2.text=self.model.userName;
    nameLbl2.textColor=[UIColor redColor];
//    nameLbl2.backgroundColor=[UIColor blueColor];
    [self.view addSubview:nameLbl2];
    [nameLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(nameLabel.mas_right);
        make.top.equalTo(iconView.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    //展示的那句好
    UILabel *nameLbl3=[[UILabel alloc]init];
    nameLbl3.text=@"为了给您更好的服务,请关联一个商城账号";
    nameLbl3.font=font15;
    [self.view addSubview:nameLbl3];
    [nameLbl3 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(nameLabel);
        make.top.equalTo(nameLabel.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(300, 30));
    }];
    
    //还没有账号
    UILabel *accoutLbl=[[UILabel alloc]init];
    accoutLbl.text=@"还没有京东账号?";
//    accoutLbl.font=font15;
    accoutLbl.textColor=[UIColor lightGrayColor];
    [self.view addSubview:accoutLbl];
    [accoutLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLbl3);
        make.top.equalTo(nameLbl3).offset(30);
        make.size.mas_equalTo(CGSizeMake(200, 30));
        
    }];
    
    //注册按钮
    UIButton *regiBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    regiBtn.backgroundColor=[UIColor redColor];
    [regiBtn setTitle:@"快速注册" forState:UIControlStateNormal];
    regiBtn.layer.cornerRadius=3.0;
    [self.view addSubview:regiBtn];
    [regiBtn addTarget:self action:@selector(registBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [regiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(accoutLbl);
        make.top.equalTo(accoutLbl.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-40, 48));
        
    }];
    //关联按钮
    
    UIButton *conetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    conetBtn.backgroundColor=[UIColor whiteColor];
    [conetBtn setTitle:@"立即关联" forState:UIControlStateNormal];
    [conetBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    //    regiBtn.titleLabel.font=font15;
    conetBtn.layer.cornerRadius=3.0;
    [self.view addSubview:conetBtn];
    [conetBtn addTarget:self action:@selector(connectAccount:) forControlEvents:UIControlEventTouchUpInside];
    [conetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(accoutLbl);
        make.top.equalTo(regiBtn.mas_bottom).offset(50);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-40, 48));
        
    }];

}



//点击了立即注册按钮
-(void)registBtnClick:(UIButton *)sender{

    YYRegisterViewController *registVC=[[YYRegisterViewController alloc]init];
    
    [self.navigationController pushViewController:registVC animated:YES];
    
}

//点击了立即关联按钮
-(void)connectAccount:(UIButton *)sender{

    YYConnetLoadViewController *connectVc=[[YYConnetLoadViewController alloc]init];
    [self.navigationController pushViewController:connectVc animated:YES];
}

@end
