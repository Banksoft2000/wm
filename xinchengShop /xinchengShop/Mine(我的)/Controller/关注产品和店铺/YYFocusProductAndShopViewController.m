//
//  YYFocusProductAndShopViewController.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/11.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYFocusProductAndShopViewController.h"
#import "YYproductAndShopView.h"

#import <Masonry.h>
#import <MJRefresh.h>
#import <MBProgressHUD.h>
@interface YYFocusProductAndShopViewController ()
//标题的view
@property (nonatomic, strong) YYproductAndShopView *titleView;
@property (nonatomic, strong) NSMutableArray *arrM;
//提示的蒙版
@property (nonatomic, strong) MBProgressHUD *progress;

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
    
    self.tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    
    //下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    

}


-(void)loadNewData{

    [self.tableView.mj_header endRefreshing];

    
}

//自定义控制器标题

-(void)initFrame{

    //控制器标题的
    self.titleView=[[YYproductAndShopView alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.navigationItem.titleView=self.titleView;
    self.titleView.titleList=@[@"商品",@"店铺"];
    
    //titileView处理点击事件
    [_titleView addBlock:^(NSInteger index) {
        NSLog(@"点击了--%ld",(long)index);
        
        if (index==0) {
            NSLog(@"点击了 商品");
        }else if (index==1){
        
        
            NSLog(@"点击了关注的店铺");
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




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
