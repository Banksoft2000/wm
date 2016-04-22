//
//  YYProductMangerViewController.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/20.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYProductMangerViewController.h"
#import "YYProductReleaseController.h"

#import "YYProductManagerCell.h"
#import "YYMemberTool.h"
#import "YYShop.h"

#import "SegmentView.h"
#import <Masonry.h>
#import <MBProgressHUD.h>

@interface YYProductMangerViewController ()<UISearchBarDelegate,UISearchDisplayDelegate,UITableViewDataSource,UITableViewDelegate>

//切换标题的view
@property (nonatomic, strong) SegmentView *titleView;
@property (strong, nonatomic) IBOutlet YYProductManagerCell *productManagerCell;

@property (nonatomic, strong) MBProgressHUD *progress;
@property (nonatomic, strong) NSMutableArray *arrM;
//店铺

@property (nonatomic, strong) YYShop *shop;
@property (nonatomic, strong) UIImageView *noView;
@property (nonatomic, strong) UILabel *label1;

@end

@implementation YYProductMangerViewController

-(void)viewWillAppear:(BOOL)animated{

    self.view.backgroundColor=[UIColor colorWithRed:236.0/255 green:236.0/255 blue:236.0/255 alpha:1.0];
//    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title=@"产品管理";
    //右边的商品发布
    [self rightBtn];
    self.tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 95)];
    self.tableView.tableFooterView=[UIView new];
    self.tableView.showsVerticalScrollIndicator=NO;
    //添加搜索框和顶部的滑动view
    
    [self initFrame];

    
    self.shop=[YYMemberTool shop];
    
    NSString *url=[NSString stringWithFormat:@"%@/app/_shopProduct?shopId=%@&selfTypeNo=&Status=true&size=20&index=1",BASE_URL,self.shop.id];
    [self loadProductWithUrl:url];
    
   
}
//自定义右边的商品发布
-(void)rightBtn{
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.backgroundColor=[UIColor redColor];
    [rightBtn setTitle:@"商品发布" forState:UIControlStateNormal];
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:13.0];
    rightBtn.frame = CGRectMake(350, 2, 75, 35);
   
    [rightBtn addTarget:self action:@selector(clickProduct:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=right;
    
}

#pragma mark ---初始化界面
-(void)initFrame{
    
    //添加搜索框
    UISearchBar *searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    searchBar.placeholder=@"搜索商品名称";
    searchBar.backgroundImage=[self imageWithColor:[UIColor clearColor] size:searchBar.bounds.size];
    searchBar.delegate=self;
    [searchBar becomeFirstResponder];
    [self.tableView.tableHeaderView addSubview:searchBar];
    //添加头部选择view
    //控制器标题的
    self.titleView=[[SegmentView alloc]initWithFrame:CGRectMake(2, 55, SCREEN_WIDTH-4, 40)];
    self.titleView.backgroundColor=[UIColor whiteColor];
    [self.tableView.tableHeaderView addSubview:self.titleView];
    self.titleView.titleList=@[@"出售中",@"仓库中"];
    
    //titileView处理点击事件
    __block YYProductMangerViewController *vc = self;
    
    [_titleView addBlock:^(NSInteger index) {
        NSLog(@"点击了--%ld",(long)index);
        //        vc.selectIndex=index;
        
        if (index==0) {
            NSLog(@"点击了 出售中");
            NSString *url=[NSString stringWithFormat:@"%@/app/_shopProduct?shopId=%@&selfTypeNo=&Status=true&size=20&index=1",BASE_URL,vc.shop.id];

            [vc loadProductWithUrl:url];
            
            
        }else if (index==1){
            
            NSLog(@"点击了仓库中");
            NSString *url=[NSString stringWithFormat:@"%@/app/_shopProduct?shopId=%@&selfTypeNo=&Status=false&size=20&index=1",BASE_URL,vc.shop.id];

            [vc loadProductWithUrl:url];
            
        }
        
    }];
    
}

#pragma mark --加载 商品
-(void)loadProductWithUrl:(NSString *)url{

    NSLog(@"---我下拉刷新了");
//    self.shopArr=nil;
    self.arrM=[[NSMutableArray alloc]init];
    //    self.arrDetail=[[NSMutableArray alloc]init];
    
    //创建一个蒙版
    _progress=[MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    _progress.labelText=@"正在加载";
    
    
    [YYNetWorking homeHeaderWithURL:url :^(id responsObjc) {
        
        NSDictionary *data = responsObjc[@"data"];
        
        NSArray *xdata = data[@"list"];
        [_progress hide:YES afterDelay:1.0];
        
        for (NSDictionary *dic in xdata) {
            
            //关注的商品信息
            YYOnSell *model = [[YYOnSell alloc] initWithDictionary:dic];
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
#pragma mark --没有信息的时候显示

-(void)loadNewControl{

    self.tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
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
    label1.text=@"您还没有相关的订单";
    label1.textAlignment=NSTextAlignmentCenter;
    [self.tableView addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 30));
        make.top.equalTo(orderView.mas_bottom).offset(50);
        make.centerX.equalTo(self.tableView.mas_centerX);
        
    }];

}


#pragma mark --取消搜索框的背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark --  点击商品发布按钮
-(void)clickProduct:(UIButton *)sender{
    
    UIStoryboard *productRelease = [UIStoryboard storyboardWithName:@"YYProductRelease" bundle:nil];
    
    YYProductReleaseController *release = [productRelease instantiateViewControllerWithIdentifier:@"release"];


    
    [self.navigationController pushViewController:release animated:YES];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _arrM.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    YYOnSell *onSell=_arrM[indexPath.section];
    
    static NSString *MyIdentifier = @"MyIdentifier";
    
    YYProductManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell==nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"YYProductManagerCell" owner:self options:nil];
        cell = [nibs lastObject];
        cell.shopProduct=onSell;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}


//行高

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 87;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section==0) {
        UIView *header=[[UIView alloc]initWithFrame:CGRectMake(0, 95, SCREEN_WIDTH, 2)];
        header.backgroundColor=[UIColor redColor];
        return header;
    }
    return nil;
}
@end
