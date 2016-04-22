//
//  YYMyScoreListViewController.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/12.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYMyScoreListViewController.h"
#import "YYMyScoreViewCell.h"


#import "YYMyScoreList.h"
#import "YYMember.h"
#import "YYMemberTool.h"
@interface YYMyScoreListViewController ()
@property (strong, nonatomic) IBOutlet YYMyScoreViewCell *myScoreViewCell;
//存储数据的数组
@property (nonatomic, strong) NSMutableArray *arrM;

//登录的账号

@property (nonatomic, strong) YYMember *member;


@property (nonatomic, strong) UIImageView *noView;
@property (nonatomic, strong) UILabel *lbl1;
@end

@implementation YYMyScoreListViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"barBackImage"]forBarMetrics:UIBarMetricsDefault];
    
    
    
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
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
    
    title.text = @"会员积分";
    
    title.textAlignment = NSTextAlignmentCenter;
    
    title.textColor = [UIColor redColor];
    
    self.navigationItem.titleView = title;
    
    
    //自定义左键返回
    [self initLeft];
    
    //把分割线去掉
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.member=[YYMemberTool member];
    
    //加载数据的方法
    
    [self loadData];
}

//加载数据
-(void)loadData{

    self.arrM=[[NSMutableArray alloc]init];

        NSString *url=[NSString stringWithFormat:@"%@/app/memberScore?index=1&size=20&memberId=%@",BASE_URL,self.member.id];
        
//        NSLog(@"---url--%@",url);
    
        [YYNetWorking homeHeaderWithURL:url :^(id responsObjc) {
            
            NSDictionary *data = responsObjc[@"data"];
            
            NSArray *xdata = data[@"list"];
            
            
            for (NSDictionary *dic in xdata) {
                
                //提现的记录信息
                YYMyScoreList *model = [[YYMyScoreList alloc] initWithDictionary:dic];
                //需不需要保存这些信息呢
                
                //[YYOrderTool saveOrderList:model];
                
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
//没有订单的时候 加载的数据信息

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
    
    //label的
    UILabel *label1=[[UILabel alloc]init];
    self.lbl1=label1;
    label1.text=@"您还没有关注商品或店铺";
    label1.textAlignment=NSTextAlignmentCenter;
    [self.tableView addSubview:label1];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 30));
        make.top.equalTo(orderView.mas_bottom).offset(50);
        make.centerX.equalTo(self.tableView.mas_centerX);
        
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.arrM.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YYMyScoreList *scorelist=_arrM[indexPath.section];
    
    static NSString *ID=@"mycell";
    YYMyScoreViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell==nil) {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"YYMyScoreViewCell" owner:self options:nil];
        cell = [nibs lastObject];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        cell.scoreList=scorelist;
        
    }

        
    return cell;
}

//每个cell的高度

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;
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
