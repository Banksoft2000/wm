//
//  YYMyAccountListViewController.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/12.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYMyAccountListViewController.h"

#import "YYAccountViewCell.h"
#import "YYMemberTool.h"
#import "YYMember.h"
#import "YYAccountList.h"
#import "YYWithDrawList.h"

#import "SegmentView.h"
#import <MJRefresh.h>
#import <MBProgressHUD.h>

@interface YYMyAccountListViewController ()<UITableViewDelegate,UITableViewDataSource>

//标题的titleView
@property (nonatomic, strong) SegmentView *titleView;
//创建的一个member
@property (nonatomic, strong) YYMember *member;
//自定义的cell
@property (strong, nonatomic) IBOutlet YYAccountViewCell *accountCell;

//圆形图片

@property (nonatomic, strong) UIImageView *noView;
@property (nonatomic, strong) UILabel *label1;

//存放充值数据的临时数组
@property (nonatomic, strong) NSMutableArray *arrM;
//存放提现数据的临时数组
@property (nonatomic, strong) NSMutableArray *WithDrawArr;

@end

@implementation YYMyAccountListViewController

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"barBackImage"]forBarMetrics:UIBarMetricsDefault];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //自定义左键返回
    [self initLeft];
    //自定义标题
    [self initFrame];
    
    self.member=[[YYMember alloc]init];
    self.member=[YYMemberTool member];
    
    
    self.tableView.tableFooterView=[UIView new];
    
    //直接调用方法
    [self  checkAccountList];
}

//自定义左键
-(void)initLeft{
    
    //自定义左键返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"wopc_arrow"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0, -20, 30, 30);
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem=left;
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --   自定义控制器标题

-(void)initFrame{
    
    //控制器标题的
    self.titleView=[[SegmentView alloc]initWithFrame:CGRectMake(0, 0, 180, 40)];
    self.navigationItem.titleView=self.titleView;
    self.titleView.titleList=@[@"充值明细",@"提现记录"];
    
    //titileView处理点击事件
    __block YYMyAccountListViewController *vc = self;
    
    [_titleView addBlock:^(NSInteger index) {
        NSLog(@"点击了--%ld",(long)index);
//        vc.selectIndex=index;
        
        if (index==0) {
            NSLog(@"点击了 账户明细");
            //加载账户明细
            [vc checkAccountList];
            
            
        }else if (index==1){
            
            NSLog(@"点击了提现记录");
            //加载提现记录
            [vc checkWithDrawList];
            
        }
        
    }];
    
}

//查看充值明细记录
-(void)checkAccountList{

    NSLog(@"---我下拉刷新了");
    self.WithDrawArr=nil;
    self.arrM=[[NSMutableArray alloc]init];
    //    self.arrDetail=[[NSMutableArray alloc]init];
    
    //创建一个蒙版
//    _progress=[MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
//    _progress.labelText=@"正在加载";
    
    NSString *url=[NSString stringWithFormat:@"%@/app/memberMoney_list?index=1&size=20&memberId=%@",BASE_URL,self.member.id];
    
    [YYNetWorking homeHeaderWithURL:url :^(id responsObjc) {
        
        NSDictionary *data = responsObjc[@"data"];
        
        NSArray *xdata = data[@"list"];

        
        for (NSDictionary *dic in xdata) {
            
            //关注的商品信息
            YYAccountList *model = [[YYAccountList alloc] initWithDictionary:dic];
            //需不需要保存这些信息呢
            
            //            [YYOrderTool saveOrderList:model];
            
            
            [self.arrM addObject:model];
            
        }
        
        if (xdata.count==0) {
            NSLog(@"----没有订单信息");
            
             [self loadNewControl];
            
        }
        [self.tableView reloadData];
        
    }];
    //结束下拉刷新
    [self.tableView.mj_header endRefreshing];
}
//查看提现记录明细
-(void)checkWithDrawList{

    NSLog(@"---我下拉刷新了");
        self.arrM=nil;
    self.WithDrawArr=[[NSMutableArray alloc]init];
    //创建一个蒙版
    //    _progress=[MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    //    _progress.labelText=@"正在加载";
    
    NSString *url=[NSString stringWithFormat:@"%@/app/withdraw_list?index=1&size=20&memberId=%@",BASE_URL,self.member.id];
    
    NSLog(@"---url--%@",url);
    
    [YYNetWorking homeHeaderWithURL:url :^(id responsObjc) {
        
        NSDictionary *data = responsObjc[@"data"];
        
        NSArray *xdata = data[@"list"];
        
        
        for (NSDictionary *dic in xdata) {
            
            //提现的记录信息
            YYWithDrawList *model = [[YYWithDrawList alloc] initWithDictionary:dic];
            //需不需要保存这些信息呢
            
            //[YYOrderTool saveOrderList:model];
            
            
            [self.WithDrawArr addObject:model];
            
        }
        
        if (xdata.count==0) {
            NSLog(@"----没有订单信息");
            
            [self loadNewControl];
            
        }
        [self.tableView reloadData];
        
    }];
    //结束下拉刷新
    [self.tableView.mj_header endRefreshing];
}

//没有相关信息的是调用
-(void)loadNewControl{
    
    //圆形
    UIImageView *orderView=[[UIImageView alloc]init];
    self.noView=orderView;
    //            orderView.image=[UIImage imageNamed:@"personal_icon_order"];
    orderView.layer.masksToBounds=YES;
    orderView.backgroundColor=[UIColor lightGrayColor];
    orderView.layer.cornerRadius=40;
    
    [self.tableView addSubview:orderView];
    [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.top.equalTo(self.tableView.mas_top).offset(80);
        make.centerX.equalTo(self.tableView.mas_centerX);
        
    }];
    
    //label
    
    UILabel *label1=[[UILabel alloc]init];
    self.label1=label1;
    label1.text=@"您还没有关注商品或店铺";
    label1.textAlignment=NSTextAlignmentCenter;
    [self.tableView addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 30));
        make.top.equalTo(orderView.mas_bottom).offset(50);
        make.centerX.equalTo(self.tableView.mas_centerX);
        
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (_WithDrawArr==nil) {
        return _arrM.count;
    }else {
    
        return _WithDrawArr.count;
    }


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YYAccountList *accountList=_arrM[indexPath.row];
    
    YYWithDrawList *withDrawList=_WithDrawArr[indexPath.row];
    
    static NSString *MyIdentifier=@"MyIdentifie";
    
    YYAccountViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier ];
    
    if (cell==nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"YYAccountViewCell" owner:self options:nil];
        cell = [nibs lastObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (accountList==nil) {
            cell.withDrawList=withDrawList;
        }else if (withDrawList==nil){
        cell.accountList=accountList;
        }
    }
    
    
    
    return cell;
}

//每一行的高度

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 60;
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
