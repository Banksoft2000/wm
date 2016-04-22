//
//  YYConsumeConfigViewController.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/20.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYConsumeConfigViewController.h"
#import <Masonry.h>

@interface YYConsumeConfigViewController ()

@end

@implementation YYConsumeConfigViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"验证码";
    self.view.backgroundColor=[UIColor whiteColor];
    //初始化
    [self initFrame];
}

//初始化控件
-(void)initFrame{
    //输入框
    UITextField *code=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 40)];
    code.clearButtonMode= UITextFieldViewModeWhileEditing;
    code.borderStyle=UITextBorderStyleRoundedRect;
    code.placeholder=@"请输入验证码";
    [self.view addSubview:code];
    
    
    //验证码按钮
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor=[UIColor redColor];
    [btn setTitle:@"验证码" forState:UIControlStateNormal];
    btn.titleLabel.font=[UIFont systemFontOfSize:13.0];
    btn.layer.cornerRadius=5;
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(code.mas_bottom).offset(20);
        make.right.equalTo(code.mas_right);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    

}

//点击验证码

-(void)clickBtn:(UIButton *)sender{

    NSLog(@"发送验证码");
}

@end
