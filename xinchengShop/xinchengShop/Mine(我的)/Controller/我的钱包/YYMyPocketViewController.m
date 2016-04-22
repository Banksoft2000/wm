//
//  YYMyPocketViewController.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/11.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYMyPocketViewController.h"
#import "YYMyScoreListViewController.h"
#import "YYMyAccountListViewController.h"
#import "YYMemberTool.h"
#import "YYMember.h"

#import "YYMypocketViewCell.h"

@interface YYMyPocketViewController ()<UITableViewDelegate,UITableViewDataSource>

//显示会员的账户余额
@property (nonatomic, strong) YYMember *member;
@property (strong, nonatomic) IBOutlet YYMypocketViewCell *MyPocketCell;

@end

@implementation YYMyPocketViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]){
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"我的钱包";

    self.tableView.backgroundColor=[UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0];
    self.member=[[YYMember alloc]init];
    self.member=[YYMemberTool member];

    self.tableView.tableFooterView=[UIView new];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *MyIdentifier=@"MyIdentifier";
    
    YYMypocketViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    
    if (cell==nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"YYMypocketViewCell" owner:self options:nil];
        cell = [nibs lastObject];

    }
    
    if (indexPath.row==0) {
        
        cell.iconView.image=[UIImage imageNamed:@"personal_icon_order"];
        cell.title.text=@"账号余额";
        cell.detail.text=[NSString stringWithFormat:@"%f",self.member.balance];
    }else if (indexPath.row==1){
    
    
        cell.iconView.image=[UIImage imageNamed:@"android_my_jd_account_safe"];
        cell.title.text=@"会员积分";
        cell.detail.text=[NSString stringWithFormat:@"%ld",(long)self.member.memberPoint];
        cell.danwei.text=@"分";
    }

    
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 10;
}

//当选中cell的时候
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row==0) {
      
        
        //跳转到资金账户明细界面
        
        YYMyAccountListViewController *accountVc=[[YYMyAccountListViewController alloc]init];
        [self.navigationController pushViewController:accountVc animated:YES];
        
    }else if (indexPath.row==1){
    
        //跳转到积分账户界面
        
        YYMyScoreListViewController *scoreVc=[[YYMyScoreListViewController alloc]init];
        
        [self.navigationController pushViewController:scoreVc animated:YES];
        
    }

    
}


-  (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


@end
