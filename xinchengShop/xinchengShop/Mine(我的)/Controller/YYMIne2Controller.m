//
//  YYMIne2Controller.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/18.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYMIne2Controller.h"
#import "YYLoginController.h"
#import "YYMySelfInfoViewController.h"
#import "YYFocusProductAndShopViewController.h"

#import "YYMember.h"
#import "YYMemberTool.h"
#import "YYShop.h"


#import <Masonry.h>

@interface YYMIne2Controller ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YYMember *member;
@property (nonatomic, strong) YYShop *shop;
//头像
@property (nonatomic, strong) UIImageView *memIcon;
//用户名
@property (nonatomic, strong) UIButton *nameBtn;

@end

@implementation YYMIne2Controller

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    
//    _member=[YYMemberTool member];
//    
//    if (_member==nil) {
//        [self initFrame];
//    }
}
//初始化布局
-(void)initFrame{
      self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT+200)];
    //1.顶部的view
    UIImageView *topView=[[UIImageView   alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 185)];
    topView.image=[UIImage imageNamed:@"personal_info_bg_unlogin_noon"];
    topView.userInteractionEnabled=YES;
    
    [self.tableView.tableHeaderView addSubview:topView];
    
    //顶部视图里的一些控件
    //头像
    UIImageView *iconView=[[UIImageView alloc]init];
    self.memIcon=iconView;
    iconView.image=[UIImage imageNamed:@"personal_userhead2"];
    iconView.layer.masksToBounds=YES;
    iconView.layer.cornerRadius=25;
    [topView addSubview:iconView];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.top.equalTo(topView.mas_top).offset(38);
        make.centerX.equalTo(topView.mas_centerX);
    }];
    //用户名
    
    UIButton *nameBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    self.nameBtn=nameBtn;
    [nameBtn setTitle:@"正在登录" forState:UIControlStateNormal];
//    nameBtn.backgroundColor=[UIColor clearColor];
    [nameBtn setTintColor:[UIColor whiteColor]];
    nameBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [nameBtn addTarget:self action:@selector(clickNameBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:nameBtn];
    [nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.top.equalTo(topView.mas_top).offset(96);
        make.centerX.equalTo(topView.mas_centerX);
    }];
    
    //条状的view
    UIImageView *top3View=[[UIImageView alloc]init];
    top3View.userInteractionEnabled=YES;
    top3View.image=[UIImage imageNamed:@"personal_info_bg_unlogin_pm"];
    [topView addSubview:top3View];
    [top3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 53));
        make.top.equalTo(topView.mas_top).offset(137);
        make.left.equalTo(topView.mas_left);
    }];
    
    //条状上的两个按钮
    //lineview
    UIView *lineView=[[UIView alloc]init];
    
    lineView.backgroundColor=[UIColor redColor];
    
    [top3View addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, 30));
        make.top.equalTo(topView.mas_top).offset(148);
        make.centerX.equalTo(topView.mas_centerX);
    }];
    
    //产品
    UIButton *product=[UIButton buttonWithType:UIButtonTypeCustom];
    product.titleLabel.font=[UIFont systemFontOfSize:13.0];
    [product setTitle:@"关注的商品" forState:UIControlStateNormal];
    
    [product addTarget:self action:@selector(clickProductOrShop:) forControlEvents:UIControlEventTouchUpInside];
    [top3View addSubview:product];
    [product mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 30));
        make.right.equalTo(lineView.mas_left).offset(-60);
        make.top.equalTo(topView).offset(149);
    }];
    
    //商铺
    UIButton *shop=[UIButton buttonWithType:UIButtonTypeCustom];
    shop.titleLabel.font=[UIFont systemFontOfSize:13.0];
    [shop setTitle:@"关注的店铺" forState:UIControlStateNormal];
    [shop addTarget:self action:@selector(clickProductOrShop:) forControlEvents:UIControlEventTouchUpInside];
    [top3View addSubview:shop];
    [shop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 30));
        make.left.mas_equalTo(lineView.mas_right).offset(60);
        make.top.equalTo(topView).offset(149);
    }];
    
    
    
    //第二部分的view
    UIView *seconeView=[[UIView alloc]init];
    seconeView.backgroundColor=[UIColor redColor];
    [self.tableView.tableHeaderView addSubview:seconeView];
    
    [seconeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 180));
        make.left.equalTo(self.tableView.mas_left);
        make.top.equalTo(self.tableView.mas_top).offset(185);
    }];
    
    //第三部分view
    UIView *thridView=[[UIView alloc]init];
    thridView.backgroundColor=[UIColor redColor];
    [self.tableView.tableHeaderView addSubview:thridView];
    
    [thridView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 180));
        make.left.equalTo(self.tableView.mas_left);
        make.top.equalTo(seconeView.mas_bottom).offset(10);
    }];
    //最后一部分
    UIView *lastView=[[UIView alloc]init];
    lastView.backgroundColor =[UIColor blueColor];
    [self.tableView.tableHeaderView addSubview:lastView];
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 180));
        make.left.equalTo(self.tableView.mas_left);
        make.top.equalTo(thridView.mas_bottom).offset(2);
    }];

    
}
//登录成功后没有开店
-(void)initFrame2{
      self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT+300)];
    //1.顶部的view
    UIImageView *topView=[[UIImageView   alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 185)];
    topView.image=[UIImage imageNamed:@"personal_info_bg_unlogin_noon"];
    topView.userInteractionEnabled=YES;
    
    [self.tableView.tableHeaderView addSubview:topView];
    
    //顶部视图里的一些控件
    //头像
    UIImageView *iconView=[[UIImageView alloc]init];
    self.memIcon=iconView;
    iconView.image=[UIImage imageNamed:@"personal_userhead2"];
    iconView.layer.masksToBounds=YES;
    iconView.layer.cornerRadius=25;
    [topView addSubview:iconView];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.top.equalTo(topView.mas_top).offset(38);
        make.centerX.equalTo(topView.mas_centerX);
    }];
    //用户名
    
    UIButton *nameBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    self.nameBtn=nameBtn;
    [nameBtn setTitle:@"正在登录" forState:UIControlStateNormal];
    //    nameBtn.backgroundColor=[UIColor clearColor];
    [nameBtn setTintColor:[UIColor whiteColor]];
    nameBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [nameBtn addTarget:self action:@selector(clickNameBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:nameBtn];
    [nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.top.equalTo(topView.mas_top).offset(96);
        make.centerX.equalTo(topView.mas_centerX);
    }];
    
    //条状的view
    UIImageView *top3View=[[UIImageView alloc]init];
    top3View.userInteractionEnabled=YES;
    top3View.image=[UIImage imageNamed:@"personal_info_bg_unlogin_pm"];
    [topView addSubview:top3View];
    [top3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 53));
        make.top.equalTo(topView.mas_top).offset(137);
        make.left.equalTo(topView.mas_left);
    }];
    
    //条状上的两个按钮
    //lineview
    UIView *lineView=[[UIView alloc]init];
    
    lineView.backgroundColor=[UIColor redColor];
    
    [top3View addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, 30));
        make.top.equalTo(topView.mas_top).offset(148);
        make.centerX.equalTo(topView.mas_centerX);
    }];
    
    //产品
    UIButton *product=[UIButton buttonWithType:UIButtonTypeCustom];
    product.titleLabel.font=[UIFont systemFontOfSize:13.0];
    [product setTitle:@"关注的商品" forState:UIControlStateNormal];
    
    [product addTarget:self action:@selector(clickProductOrShop:) forControlEvents:UIControlEventTouchUpInside];
    [top3View addSubview:product];
    [product mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 30));
        make.right.equalTo(lineView.mas_left).offset(-60);
        make.top.equalTo(topView).offset(149);
    }];
    
    //商铺
    UIButton *shop=[UIButton buttonWithType:UIButtonTypeCustom];
    shop.titleLabel.font=[UIFont systemFontOfSize:13.0];
    [shop setTitle:@"关注的店铺" forState:UIControlStateNormal];
    [shop addTarget:self action:@selector(clickProductOrShop:) forControlEvents:UIControlEventTouchUpInside];
    [top3View addSubview:shop];
    [shop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 30));
        make.left.mas_equalTo(lineView.mas_right).offset(60);
        make.top.equalTo(topView).offset(149);
    }];
    
    
    
    //第二部分的view
    UIView *seconeView=[[UIView alloc]init];
    seconeView.backgroundColor=[UIColor redColor];
    [self.tableView.tableHeaderView addSubview:seconeView];
    
    [seconeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 180));
        make.left.equalTo(self.tableView.mas_left);
        make.top.equalTo(self.tableView.mas_top).offset(185);
    }];
    
    //第三部分view
    UIView *thridView=[[UIView alloc]init];
    thridView.backgroundColor=[UIColor redColor];
    [self.tableView.tableHeaderView addSubview:thridView];
    
    [thridView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 180));
        make.left.equalTo(self.tableView.mas_left);
        make.top.equalTo(seconeView.mas_bottom).offset(10);
    }];
    
    //再插入一块
    
    UIView *fourView=[[UIView alloc]init];
    fourView.backgroundColor=[UIColor redColor];
    [self.tableView.tableHeaderView addSubview:fourView];
    
    [fourView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 60));
        make.left.equalTo(self.tableView.mas_left);
        make.top.equalTo(thridView.mas_bottom).offset(2);
    }];
    
    //最后一部分的显示
    UIView *lastView=[[UIView alloc]init];
    lastView.backgroundColor =[UIColor blueColor];
    [self.tableView.tableHeaderView addSubview:lastView];
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 180));
        make.left.equalTo(self.tableView.mas_left);
        make.top.equalTo(fourView.mas_bottom).offset(2);
    }];

}

//登录成功后已经开店
-(void)initFrame3{
    
  self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT+400)];
    //1.顶部的view
    UIImageView *topView=[[UIImageView   alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 185)];
    topView.image=[UIImage imageNamed:@"personal_info_bg_unlogin_noon"];
    topView.userInteractionEnabled=YES;
    
    [self.tableView.tableHeaderView addSubview:topView];
    
    //顶部视图里的一些控件
    //头像
    UIImageView *iconView=[[UIImageView alloc]init];
    self.memIcon=iconView;
    iconView.image=[UIImage imageNamed:@"personal_userhead2"];
    iconView.layer.masksToBounds=YES;
    iconView.layer.cornerRadius=25;
    [topView addSubview:iconView];
    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.top.equalTo(topView.mas_top).offset(38);
        make.centerX.equalTo(topView.mas_centerX);
    }];
    //用户名
    
    UIButton *nameBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    self.nameBtn=nameBtn;
    [nameBtn setTitle:@"正在登录" forState:UIControlStateNormal];
    //    nameBtn.backgroundColor=[UIColor clearColor];
    [nameBtn setTintColor:[UIColor whiteColor]];
    nameBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [nameBtn addTarget:self action:@selector(clickNameBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:nameBtn];
    [nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.top.equalTo(topView.mas_top).offset(96);
        make.centerX.equalTo(topView.mas_centerX);
    }];
    
    //条状的view
    UIImageView *top3View=[[UIImageView alloc]init];
    top3View.userInteractionEnabled=YES;
    top3View.image=[UIImage imageNamed:@"personal_info_bg_unlogin_pm"];
    [topView addSubview:top3View];
    [top3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 53));
        make.top.equalTo(topView.mas_top).offset(137);
        make.left.equalTo(topView.mas_left);
    }];
    
    //条状上的两个按钮
    //lineview
    UIView *lineView=[[UIView alloc]init];
    
    lineView.backgroundColor=[UIColor redColor];
    
    [top3View addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, 30));
        make.top.equalTo(topView.mas_top).offset(148);
        make.centerX.equalTo(topView.mas_centerX);
    }];
    
    //产品
    UIButton *product=[UIButton buttonWithType:UIButtonTypeCustom];
    product.titleLabel.font=[UIFont systemFontOfSize:13.0];
    [product setTitle:@"关注的商品" forState:UIControlStateNormal];
    
    [product addTarget:self action:@selector(clickProductOrShop:) forControlEvents:UIControlEventTouchUpInside];
    [top3View addSubview:product];
    [product mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 30));
        make.right.equalTo(lineView.mas_left).offset(-60);
        make.top.equalTo(topView).offset(149);
    }];
    
    //商铺
    UIButton *shop=[UIButton buttonWithType:UIButtonTypeCustom];
    shop.titleLabel.font=[UIFont systemFontOfSize:13.0];
    [shop setTitle:@"关注的店铺" forState:UIControlStateNormal];
    [shop addTarget:self action:@selector(clickProductOrShop:) forControlEvents:UIControlEventTouchUpInside];
    [top3View addSubview:shop];
    [shop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70, 30));
        make.left.mas_equalTo(lineView.mas_right).offset(60);
        make.top.equalTo(topView).offset(149);
    }];
    
    
    
    //第二部分的view
    UIView *seconeView=[[UIView alloc]init];
    seconeView.backgroundColor=[UIColor redColor];
    [self.tableView.tableHeaderView addSubview:seconeView];
    
    [seconeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 180));
        make.left.equalTo(self.tableView.mas_left);
        make.top.equalTo(self.tableView.mas_top).offset(185);
    }];
    
    //第三部分
    UIView *thridView=[[UIView alloc]init];
    thridView.backgroundColor=[UIColor redColor];
    [self.tableView.tableHeaderView addSubview:thridView];
    
    [thridView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 180));
        make.left.equalTo(self.tableView.mas_left);
        make.top.equalTo(seconeView.mas_bottom).offset(10);
    }];

    
    //增加一组内容
    
    UIView *sectionView=[[UIView alloc]init];
    sectionView.backgroundColor=[UIColor yellowColor];
    [self.tableView.tableHeaderView addSubview:sectionView];
    
    [sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 180));
        make.left.equalTo(self.tableView.mas_left);
        make.top.equalTo(thridView.mas_bottom).offset(10);
    }];
    //最后一部分的显示
    UIView *lastView=[[UIView alloc]init];
    lastView.backgroundColor =[UIColor blueColor];
    [self.tableView.tableHeaderView addSubview:lastView];
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 180));
        make.left.equalTo(self.tableView.mas_left);
        make.top.equalTo(sectionView.mas_bottom).offset(10);
    }];

    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.title=@"我的";
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];

    
    [self initFrame];

    //监听通知
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userRefreshHandler) name:@"userRefresh" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initFrame) name:@"userRefresh2" object:nil];
 
   
}

//点击头像

-(void)clickNameBtn:(UIButton *)sender{
    
//    self.member=[YYMemberTool member];
 
    NSLog(@"我要登录");
    
    if (_member==nil) {
        
        UIStoryboard *login = [UIStoryboard storyboardWithName:@"YYLoginStoryboard" bundle:nil];
        
        YYLoginController *loginVc = [login instantiateViewControllerWithIdentifier:@"YYLogin"];
        
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVc];
        
        [self presentViewController:navigation animated:YES completion:nil];
        
    }else{
        
        UIStoryboard *my=[UIStoryboard storyboardWithName:@"YYMyselfInfo" bundle:nil];
        
        YYMySelfInfoViewController *mySelfInfo=[my instantiateViewControllerWithIdentifier:@"YYMyself" ];
        
        [self.navigationController pushViewController:mySelfInfo animated:YES];
        
        
    }

    
}

//点击商铺或产品
-(void)clickProductOrShop:(UIButton *)sender{

    [self clickShopAndProduct];
}
//登录或者是关注产品和店铺信息

-(void)clickShopAndProduct{
    
    if (_member==nil) {
        UIStoryboard *login = [UIStoryboard storyboardWithName:@"YYLoginStoryboard" bundle:nil];
        
        YYLoginController *loginVc = [login instantiateViewControllerWithIdentifier:@"YYLogin"];
        
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVc];
        [self presentViewController:navigation animated:YES completion:nil];
    }else{
        
        YYFocusProductAndShopViewController *focus=[[YYFocusProductAndShopViewController alloc]init];
        
        [self.navigationController pushViewController:focus animated:YES];
        
        
    }
    
}


//重新显示到我的界面上
-(void)userRefreshHandler{
    
    _member=[YYMemberTool member];
    [self.memIcon sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"default_picture_icon"]];
    if (_member!=nil) {
        
      //        self.balance.text=[NSString stringWithFormat:@"%f",_member.balance];
//        
//        self.memberPoint.text=[NSString stringWithFormat:@"%ld",(long)_member.memberPoint];
        
        _shop=[YYMemberTool shop];
        NSString *ste = [[NSString alloc] initWithFormat:@"%@",_shop.status ];
        
        if (_shop == nil || [ste isEqualToString:[NSString stringWithFormat:@"0"]]) {
            
           //插入一块view
            NSLog(@"---insert");
            [self initFrame2];
            
        }else if ( [ste isEqualToString:[NSString stringWithFormat:@"1"]]){
            
            //插入一组数据
            [self initFrame3];
        }
        
        NSString *imageFile = [NSString stringWithFormat:@"http://xinchengguangchang.com%@",_member.imageFile];
        [_memIcon sd_setImageWithURL:[NSURL URLWithString:imageFile] placeholderImage:[UIImage imageNamed:@"default_picture_icon"]];
        _nameBtn.titleLabel.text=_member.account;
     
        
    }else if (_member==nil){
    
    
        [self initFrame];
    }
    
  
    
}




@end
