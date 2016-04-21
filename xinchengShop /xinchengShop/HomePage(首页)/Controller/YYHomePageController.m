//
//  YYHomePageController.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/22.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYHomePageController.h"
#import "YYHomeTableView.h"
#import "YYNetWorking.h"
#import "YYMessageViewController.h"
#import "YYXCViewController.h"

#import "YYCXHomeModel.h"
#import "YYClearanceModel.h"
#import "YYCarouselModel.h"
#import "YYSeachViewController.h"
@interface YYHomePageController ()
{
    
    NSMutableArray *_headerArr; //轮播数据
    YYHomeTableView *_homeTab;
    
    NSMutableArray *_dataArr;   //主题街
    NSMutableArray *_listArr; //甩卖
    
    UISearchBar *_searchBar;
}

@end

@implementation YYHomePageController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self initNavigation];
}
- (void)viewDidLoad {
    [super viewDidLoad];

//    [self initNavigationBar];
//    [self initNavigation];
    _homeTab = [[YYHomeTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49)];
    
    [self.view addSubview:_homeTab];
    
    [self initData];
    [self initBodyData];
    [self initDetailData];
    [self refresh];

   
}

//刷新
- (void)refresh {
    
    _homeTab.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(initData)];
//    _homeTab.mj_footer=[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(initData)];
    
//    [_homeTab.mj_header endRefreshing];

}
#pragma mark - NavigationBar


- (void)initNavigation {
    
测试使用
    
    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    barView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NavBar64"]];
    self.navigationItem.titleView = barView;
    
   
    //消息转载视图
    UIView *leftBtn = [[UIView alloc] init];
    [barView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.equalTo(barView.mas_right).offset(-10);
        make.top.equalTo(barView.mas_top).offset(5);
        make.height.equalTo(@44);
        make.width.equalTo(@30);
        
    }];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn addSubview:button];
    [button setImage:[UIImage imageNamed:@"message_w_meitu_3"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.left.equalTo(leftBtn.mas_left);
        make.top.equalTo(leftBtn.mas_top);
        make.height.equalTo(@20);
        make.width.equalTo(@20);
    }];

    UILabel *label = [[UILabel alloc] init];
    [leftBtn addSubview:label];
    label.text = @"消息";
    label.textAlignment  = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = [UIColor whiteColor];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(leftBtn.mas_left);
        make.width.equalTo(button.mas_width);
        make.height.equalTo(@20);
        make.top.equalTo (button.mas_bottom).offset(-3);
        
    }];

    _searchBar = [[UISearchBar alloc] init];
    [barView addSubview:_searchBar];
    
//    [_searchBar resignFirstResponder];
    
    _searchBar.placeholder = @"请输入关键字";
    _searchBar.delegate = self;
    _searchBar.backgroundColor = [UIColor clearColor];
    _searchBar.backgroundImage = [UIImage imageNamed:@"NavBar64"];
    
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(leftBtn.mas_left).offset(-10);
        make.left.equalTo(barView.mas_left).offset(10);
        make.top.equalTo(barView.mas_top);
    }];
    

//    _searchBar.returnKeyType = UIReturnKeySearch;
    
}

#pragma mark - UISearchBarDelegate


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
//    [searchBar resignFirstResponder];
    YYSeachViewController *seach = [[YYSeachViewController alloc] init];
    
    UINavigationController  *na = [[UINavigationController alloc] initWithRootViewController:seach];
    
    [self presentViewController:na animated:YES completion:nil];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(tapGestureAction:)];
    
//    [self.view addGestureRecognizer:tap];
    
    return YES;
}
/*
- (void)tapGestureAction:(UIGestureRecognizer *)tap {
    
    [_searchBar resignFirstResponder];
    
    [self.view removeGestureRecognizer:tap];
    
}
*/



//NavigationBarLeftitem --message点击事件
- (void)leftBtnAction:(UIButton *)sender {
    
    YYMessageViewController *messageVC = [YYMessageViewController new];
    
    [self.navigationController pushViewController:messageVC animated:YES];
    
}



#pragma mark - 请求数据
//轮播数据
- (void)initData {
    
    _headerArr = [[NSMutableArray alloc] init];

    NSString *urlStr = [NSString stringWithFormat:@"%@/app/_advertisement?no=app-1",BASE_URL];
    
    [YYNetWorking homeHeaderWithURL:urlStr :^(id responsObjc) {
        
        NSArray *data = responsObjc[@"data"];
        
        for (NSDictionary *dic in data) {
          
            YYCarouselModel *model = [[YYCarouselModel alloc] initWithDictionary:dic];
            
            [_headerArr addObject:model];
            
        }
        _homeTab.headerArr = _headerArr;
        
    }];
    
    [_homeTab.mj_header endRefreshing];
    
}

//主题街数据
- (void)initBodyData {
    
    _dataArr = [[NSMutableArray alloc] init];
    
   
    NSString *urlStr = [NSString stringWithFormat:@"%@/app/productTypeList_list?grade=1",BASE_URL];
    
    [YYNetWorking homeHeaderWithURL:urlStr :^(id responsObjc) {
        
        NSDictionary *data = responsObjc[@"data"];
        NSArray *list = data[@"list"];
       
        for (NSDictionary *dic in list) {

            YYCXHomeModel *model = [[YYCXHomeModel alloc] initWithDictionary:dic];
       
            [_dataArr addObject:model];

        }
        
        _homeTab.themeArr = _dataArr;
        
    }];
  
}

//甩卖数据
- (void)initDetailData {

    _listArr = [[NSMutableArray alloc] init];
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@/app/searchProduct_list?active=0",BASE_URL];

    
    [YYNetWorking homeHeaderWithURL:urlStr :^(id responsObjc) {
        
        NSDictionary *data = responsObjc[@"data"];
        NSArray *list = data[@"list"];
        
        for (NSDictionary *dic in list) {

            YYClearanceModel *model = [[YYClearanceModel alloc] initWithDictionary:dic];
            [_listArr addObject:model];
        }
        
        _homeTab.detailArr = _listArr;
        
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
