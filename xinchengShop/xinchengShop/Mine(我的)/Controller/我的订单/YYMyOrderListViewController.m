//
//  YYMyOrderListViewController.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/7.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYMyOrderListViewController.h"
#import "YYMyOrderDetailViewController.h"
#import  <MBProgressHUD.h>
#import <Masonry.h>

#import "YYMyOrderlist.h"
#import "SegmentView.h"
#import "YYNetWorking.h"
#import <Masonry.h>
#import "YYMyOrderDetail.h"
#import "YYMyOrderCell.h"
#import "YYOrderTool.h"

#import "YYMemberTool.h"
#import "YYMember.h"

#define titleHeight self.titleView.size.height

@interface YYMyOrderListViewController ()<UITableViewDelegate,UITableViewDataSource>
//存放标题
@property (nonatomic, strong) SegmentView *titleView;
//存放内容
@property (nonatomic, strong) UITableView *contentView;

//每条数据
@property (strong, nonatomic) IBOutlet YYMyOrderCell *OrderCell;



//存放数据
@property (nonatomic, strong) NSMutableArray *arrM;
@property (nonatomic, strong) NSMutableArray *arrDetail;


@property (nonatomic, strong) MBProgressHUD *progress;

//没有订单的时候的显示
@property (nonatomic, strong) UIImageView *noView;
@property (nonatomic, strong) UILabel *label1;


//会员
@property (nonatomic, strong) YYMember *member;

//使用的tableView

@property (nonatomic, strong) UITableView *tableView;


//记录点击了哪个按钮

@property (nonatomic, assign) NSInteger clickIndex;

@end

@implementation YYMyOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView=[[UITableView alloc]init];
    self.view=self.tableView;
    self.tableView.backgroundColor=[UIColor whiteColor];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.title=@"我的订单";
    
    
    //获取会员的member
   self.member=[YYMemberTool member];
    //初始化两个view的大小
    [self initFrame];
    //一进入程序就加载全部
//    NSString *url=[NSString stringWithFormat:@"%@/app/memberOrder_list?index=1&memberId=f066a2d199d54db9b5d08a6cda4ba0ff",BASE_URL];
    NSString *url=[NSString stringWithFormat:@"%@/app/memberOrder_list?index=1&memberId=%@&size=20",BASE_URL,self.member.id];
    
    NSLog(@"%@",url);
    [self loadOrderWithUrl:url];
    
    //切换数据
//    [self loadOrder];
    
    //下拉刷新的实现
//    self.clickIndex=nil;
    self.tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadOrder)];
    
}



//不断切换数据
-(void)loadOrder{

//    self.clickIndex=Nil;
    if (self.clickIndex==0) {
        
        NSLog(@"--刷新全部 ");
        NSString *url=[NSString stringWithFormat:@"%@/app/memberOrder_list?index=1&memberId=f066a2d199d54db9b5d08a6cda4ba0ff&size=20",BASE_URL];
        
        //            NSString *url=[NSString stringWithFormat:@"http://xinchengguangchang.com/app/memberOrder_list?%25index=1&%25memberId=f066a2d199d54db9b5d08a6cda4ba0ff&status=CREATE"];
        
        [self loadOrderWithUrl:url];

    }else if (self.clickIndex==1){
        NSLog(@"-----刷新待付款");
        NSString *url=[NSString stringWithFormat:@"http://xinchengguangchang.com/app/memberOrder_list?index=1&memberId=f066a2d199d54db9b5d08a6cda4ba0ff&status=CREATE"];
        
        //            NSString *url=[NSString stringWithFormat:@"http://xinchengguangchang.com/app/memberOrder_list?%25index=1&%25memberId=f066a2d199d54db9b5d08a6cda4ba0ff&status=CREATE"];
        
        [self loadOrderWithUrl:url];
        
    }else if (self.clickIndex==2){
        NSLog(@"-----刷新了待发货");
        
        NSString *url=[NSString stringWithFormat:@"http://xinchengguangchang.com/app/memberOrder_list?index=1&memberId=f066a2d199d54db9b5d08a6cda4ba0ff&status=PAY"];
        
        [self loadOrderWithUrl:url];
        
    }else if (self.clickIndex==3){
        
        NSLog(@"---刷新了待收货");
        
        NSString *url=[NSString stringWithFormat:@"http://xinchengguangchang.com/app/memberOrder_list?memberId=f066a2d199d54db9b5d08a6cda4ba0ff&status=DISPATCH"];
        [self loadOrderWithUrl:url];
        
    }else if (self.clickIndex==4){
        
        NSLog(@"----刷新了待评价");
        NSString *url=[NSString stringWithFormat:@"http://xinchengguangchang.com/app/memberOrder_list?memberId=f066a2d199d54db9b5d08a6cda4ba0ff&status=SUCCESS"];
        [self loadOrderWithUrl:url];
        
    }
    
}

//title的布局以及切换title方法实现
-(void)initFrame{

    //标题
    self.titleView=[[SegmentView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [self.tableView addSubview:self.titleView];
    
    //内容
   self.contentView=[[UITableView alloc]initWithFrame:CGRectMake(0,titleHeight-3, SCREEN_WIDTH, SCREEN_HEIGHT-titleHeight)];
    self.contentView.backgroundColor=[UIColor colorWithRed:238.0/255 green:238.0/255 blue:238.0/255 alpha:1.0];
    [self.tableView addSubview:self.contentView];
    
    self.contentView.showsVerticalScrollIndicator=NO;
    self.contentView.delegate=self;
    self.contentView.dataSource=self;
    

    self.titleView.titleList=@[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"];
    
    
    __block YYMyOrderListViewController *vc = self;
    [_titleView addBlock:^(NSInteger index) {
        
        NSLog(@"%ld",(long)index);
        
        vc.clickIndex=(NSInteger)index;
//        NSLog(@"----clickIndex--%@",vc.clickIndex);
        
        if (index == 0) {
            
            NSString *url=[NSString stringWithFormat:@"%@/app/memberOrder_list?index=1&memberId=f066a2d199d54db9b5d08a6cda4ba0ff&size=20",BASE_URL];
            
            //            NSString *url=[NSString stringWithFormat:@"http://xinchengguangchang.com/app/memberOrder_list?%25index=1&%25memberId=f066a2d199d54db9b5d08a6cda4ba0ff&status=CREATE"];
            
            [vc loadOrderWithUrl:url];
       
        }else if (index==1){
            NSLog(@"-----点击了代付款");
            NSString *url=[NSString stringWithFormat:@"http://xinchengguangchang.com/app/memberOrder_list?index=1&memberId=f066a2d199d54db9b5d08a6cda4ba0ff&status=CREATE"];
            
            //            NSString *url=[NSString stringWithFormat:@"http://xinchengguangchang.com/app/memberOrder_list?%25index=1&%25memberId=f066a2d199d54db9b5d08a6cda4ba0ff&status=CREATE"];
            
            [vc loadOrderWithUrl:url];
            
        }else if (index==2){
            NSLog(@"-----点击了待发货");
            
            NSString *url=[NSString stringWithFormat:@"http://xinchengguangchang.com/app/memberOrder_list?index=1&memberId=f066a2d199d54db9b5d08a6cda4ba0ff&status=PAY"];
            
            [vc loadOrderWithUrl:url];
            
        }else if (index==3){
            
            NSLog(@"---点击了待收货");
            
            NSString *url=[NSString stringWithFormat:@"http://xinchengguangchang.com/app/memberOrder_list?memberId=f066a2d199d54db9b5d08a6cda4ba0ff&status=DISPATCH"];
            [vc loadOrderWithUrl:url];
            
        }else if (index==4){
            
            NSLog(@"----点击了待评价");
            NSString *url=[NSString stringWithFormat:@"http://xinchengguangchang.com/app/memberOrder_list?memberId=f066a2d199d54db9b5d08a6cda4ba0ff&status=SUCCESS"];
            [vc loadOrderWithUrl:url];
            
        }
        
        
        
    }];
    

}

//加载订单数据
-(void)loadOrderWithUrl:(NSString *)url{
    
    
    NSLog(@"---我下拉刷新了");
    
    self.arrM=[[NSMutableArray alloc]init];
    self.arrDetail=[[NSMutableArray alloc]init];
    
    //创建一个蒙版
    _progress=[MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    _progress.labelText=@"正在加载";
    
    [self.noView removeFromSuperview];
    [self.label1 removeFromSuperview];
    
    
    [YYNetWorking homeHeaderWithURL:url :^(id responsObjc) {
       
        
        NSDictionary *data = responsObjc[@"data"];
        
        NSArray *xdata = data[@"list"];
        [_progress hide:YES afterDelay:1.0];

        for (NSDictionary *dic in xdata) {
            
            //订单信息
            YYMyOrderlist *model = [[YYMyOrderlist alloc] initWithDictionary:dic];
            //需不需要保存这些信息呢
            
            [YYOrderTool saveOrderList:model];
            
            //遍历订单详情的信息
            NSArray *xxdata=dic[@"list"];
            for (NSDictionary *dict in xxdata) {
                
                
                YYMyOrderDetail *detail=[[YYMyOrderDetail alloc]initWithDictionary:dict];
                //保存订单详情信息
                [YYOrderTool saveOrderDetail:detail];
                
                [self.arrDetail addObject:detail];
                
            }

            [self.arrM addObject:model];
        
        }
        
        if (xdata.count==0) {
            NSLog(@"----没有订单信息");
            self.contentView.separatorStyle= UITableViewCellSeparatorStyleNone;
            
            [self loadNewControl];
            
        }
        [self.contentView reloadData];
        
        }];
    //结束下拉刷新
    [self.tableView.mj_header endRefreshing];
}



//没有订单时显示下边的控件

-(void)loadNewControl{

    self.contentView.separatorStyle= UITableViewCellSeparatorStyleNone;
    //圆形
    UIImageView *orderView=[[UIImageView alloc]init];
    self.noView=orderView;
    //            orderView.image=[UIImage imageNamed:@"personal_icon_order"];
    orderView.layer.masksToBounds=YES;
    orderView.backgroundColor=[UIColor lightGrayColor];
    orderView.layer.cornerRadius=40;
    
    [self.contentView addSubview:orderView];
    [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.top.equalTo(self.contentView.mas_top).offset(80);
        make.centerX.equalTo(self.contentView.mas_centerX);
        
    }];
    
    //label
    
    UILabel *label1=[[UILabel alloc]init];
    self.label1=label1;
    label1.text=@"您还没有相关的订单";
    label1.textAlignment=NSTextAlignmentCenter;
    [self.contentView addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 30));
        make.top.equalTo(orderView.mas_bottom).offset(50);
        make.centerX.equalTo(self.contentView.mas_centerX);

    }];
    
}


#pragma mark tableviewdatasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    NSLog(@"%lu",(unsigned long)self.arrM.count);
    return _arrM.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    YYMyOrderlist *orderModel=_arrM[indexPath.section];
    YYMyOrderDetail *orderDetail=_arrDetail[indexPath.section];
    static NSString *MyIdentifier = @"MyIdentifier";

    
    YYMyOrderCell *cell=[tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell==nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"YYMyOrderCell" owner:self options:nil];
        cell = [nibs lastObject];
//        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        cell.orderModel=orderModel;
        cell.orderDetail=orderDetail;
        
        //给指定区域添加点击手势
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTap:)];
        
        [cell.clickView addGestureRecognizer:tap];
    }
    
    
    return cell;
    
}

//固定区域的点击事件
-(void)doTap:(UIView *)sender{

//    YYMyOrderDetailViewController *detailVC=[[YYMyOrderDetailViewController alloc]init];
//    
//    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}


//选中cell的时候
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"---选中了cell");
//    self 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 200;
}


//每个section之间的高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 2;
}

@end
