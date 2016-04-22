//
//  YYFocusProductAndShopViewController.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/11.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYFocusProductAndShopViewController.h"
#import "YYproductAndShopView.h"

#import "YYProductList.h"
#import "YYShopList.h"
#import "YYMember.h"
#import "YYFocusViewCell.h"


#import <Masonry.h>
#import <MJRefresh.h>
#import <MBProgressHUD.h>
#import "YYMemberTool.h"
@interface YYFocusProductAndShopViewController ()<UITableViewDelegate,UITableViewDataSource>
//标题的view
@property (nonatomic, strong) YYproductAndShopView *titleView;
@property (nonatomic, strong) NSMutableArray *arrM;
@property (nonatomic, strong) NSMutableArray *shopArr;
//提示的蒙版
@property (nonatomic, strong) MBProgressHUD *progress;

@property (nonatomic, strong) YYMember *member;

//自定义的cell

@property (strong, nonatomic) IBOutlet YYFocusViewCell *focusCell;

//没有订单的时候的显示
@property (nonatomic, strong) UIImageView *noView;
@property (nonatomic, strong) UILabel *label1;

//保存选中的是商品或店铺
@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation YYFocusProductAndShopViewController

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
    //把tableview的分割线去掉
    self.tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    //获取memberId
    self.member=[[YYMember alloc]init];
    self.member=[YYMemberTool member];
    
    //默认加载商品的列表
    
    [self loadProduct];
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
}

//上拉刷新方法
-(void)loadNewData{

    if (self.selectIndex==0) {
        [self loadProduct];
    }else if (self.selectIndex==1){
    
        [self loadShop];
    }

}

//自定义控制器标题

-(void)initFrame{

    //控制器标题的
    self.titleView=[[YYproductAndShopView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.navigationItem.titleView=self.titleView;
    self.titleView.titleList=@[@"商品",@"店铺"];
    
    //titileView处理点击事件
    
    
    __block YYFocusProductAndShopViewController *vc = self;

    [_titleView addBlock:^(NSInteger index) {
        NSLog(@"点击了--%ld",(long)index);
        
        vc.selectIndex=index;
        
        if (index==0) {
            NSLog(@"点击了 商品");
            //加载产品的信息
            [vc loadProduct];
            
            
        }else if (index==1){
        
        
            NSLog(@"点击了关注的店铺");
            //加载关注的店铺信息
            [vc loadShop];
            
        }
        
    }];

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


//加载商品对应的信息
-(void)loadProduct{

    NSLog(@"---我下拉刷新了");
    self.shopArr=nil;
    self.arrM=[[NSMutableArray alloc]init];
//    self.arrDetail=[[NSMutableArray alloc]init];
    
    //创建一个蒙版
    _progress=[MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    _progress.labelText=@"正在加载";
    
    NSString *url=[NSString stringWithFormat:@"%@/app/productCollection_list?index=1&size=20&memberId=%@",BASE_URL,self.member.id];
    
    [YYNetWorking homeHeaderWithURL:url :^(id responsObjc) {
        
        NSDictionary *data = responsObjc[@"data"];
        
        NSArray *xdata = data[@"list"];
        [_progress hide:YES afterDelay:1.0];
        
        for (NSDictionary *dic in xdata) {
            
            //关注的商品信息
            YYProductList *model = [[YYProductList alloc] initWithDictionary:dic];
            //需不需要保存这些信息呢
            
//            [YYOrderTool saveOrderList:model];
            
            
            [self.arrM addObject:model];
            
        }
        
        if (xdata.count==0) {
            NSLog(@"----没有订单信息");
            
//            [self loadNewControl];
            
        }
        [self.tableView reloadData];
        
    }];
    //结束下拉刷新
    [self.tableView.mj_header endRefreshing];
}

//加载shop的数据信息

-(void)loadShop{

    NSLog(@"---我下拉刷新了");
    self.arrM=nil;
    self.shopArr=[[NSMutableArray alloc]init];

    
    //创建一个蒙版
    _progress=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _progress.labelText=@"正在加载";
    
    NSString *url=[NSString stringWithFormat:@"%@/app/shopCollection_list?index=1&size=20&memberId=%@",BASE_URL,self.member.id];
    
    [YYNetWorking homeHeaderWithURL:url :^(id responsObjc) {
        
        NSDictionary *data = responsObjc[@"data"];
        
        NSArray *xdata = data[@"list"];
        [_progress hide:YES afterDelay:1.0];
        
        for (NSDictionary *dic in xdata) {
            
            //关注的商品信息
            YYShopList *model = [[YYShopList alloc] initWithDictionary:dic];
            //需不需要保存这些信息呢
            
            // [YYOrderTool saveOrderList:model];
            
            
            [self.shopArr addObject:model];
            
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


//当没有关注的信息的时候调用

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

    
    if (_arrM==nil) {
        return _shopArr.count;
    }else{
    
        return _arrM.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YYProductList *product=_arrM[indexPath.section];
    YYShopList *shop=_shopArr[indexPath.section];
    
    static NSString *MyIdentifier = @"MyIdentifier";

    YYFocusViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell==nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"YYFocusViewCell" owner:self options:nil];
        cell = [nibs lastObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (product==nil) {
            cell.shop=shop;
        }else{
        
            cell.product=product;
        }

    }

    
    return cell;
}

//每个cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 120;
}

//每个section的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 2;
}

@end
