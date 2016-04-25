//
//  YYXCViewController.m
//  xinchengShop
//
//  Created by harry_robin on 16/3/30.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYXCViewController.h"
#import "YYThemeTableView.h"

#import "YYClearanceModel.h"  //与清仓甩卖同一个model
@interface YYXCViewController ()

{
    
    UIView *_bgView;            //筛选视图
    UIImageView *_btnImg;       //综合排序下拉三角
    YYThemeTableView *_themeTab;
    
    NSMutableArray *_dataArr;   //数据
    
    YYBaseTableView *_selectTab;
    NSArray *_selectArr;
    UIButton *_fristSelecBtn;
    
    UIView *_maskView;
   
}

@end

static NSString *_selectKey = nil;
@implementation YYXCViewController


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
//    self.title = @"精品热卖";
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
 
    
    //排序视图
    [self initChooseView];
    [self initTableView];
    
    _selectKey = @"shopservertype=shop_sale";
    [self initData];
    
    
    [self refresh];
    [self initNavigationBar];
}

#pragma mark - NavigationBar
- (void)initNavigationBar {
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(0, 0, 30, 30);
    
    [back setImage:[UIImage imageNamed:@"title_back_icon"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    
    [back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)back:(UIButton *)sender {
 
    [self.navigationController popViewControllerAnimated:YES];
}

//刷新
- (void)refresh {
    
    _themeTab.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(initData)];
    
    [_themeTab.mj_header beginRefreshing];
}

//筛选视图
- (void)initChooseView {
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    [self.view addSubview:_bgView];
    
    NSArray *titleArr = @[@"综合排序",@"人气最高",@"销量优先"];
    int i = 0;

    for (NSString *title in titleArr) {
        
        UIButton *chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bgView addSubview:chooseBtn];
        chooseBtn.frame = CGRectMake(i*SCREEN_WIDTH/3, 0, SCREEN_WIDTH/3, _bgView.height);
        [chooseBtn setTitle:title forState:UIControlStateNormal];
        chooseBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [chooseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

        if (i == 0) {
            
            _fristSelecBtn = chooseBtn;
            _btnImg = [[UIImageView alloc] init];
            
            [_fristSelecBtn addSubview:_btnImg];
            [_btnImg mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.height.equalTo(@4);
                make.width.equalTo(@7);
                make.centerY.equalTo(chooseBtn.mas_centerY);
                make.centerX.equalTo(chooseBtn.mas_centerX).offset(45);
            }];
            
            _btnImg.image = [UIImage imageNamed:@"ic_arrow_down"];
            [chooseBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            _fristSelecBtn.tag = 1300;
        }else {
            
            chooseBtn.tag = 1300 + i;
            
        }
        
        [chooseBtn addTarget:self action:@selector(chooseBtnAct:) forControlEvents:UIControlEventTouchUpInside];
        i ++;
    }
    
}

//筛选视图的点击事件
- (void)chooseBtnAct:(UIButton *)sender {
  
    if (sender.tag == 1300) {
        
        sender.selected = !sender.selected;
        
        if (sender.selected == YES) {
            
            [self initSelectView];
        }else {
            
            //将 筛选 遮罩 视图移除
            [_maskView removeFromSuperview];
            [_selectTab removeFromSuperview];
        }
        
        //下拉三角动画
        [UIView animateWithDuration:.35 animations:^{
            
            _btnImg.transform = CGAffineTransformRotate(_btnImg.transform, M_PI);
        }];
       
        //添加下拉视图
        
    }else if (sender.tag == 1301) {
        
        _fristSelecBtn.selected = NO;
       //刷新界面
        //将下拉三角返回原状
        [UIView animateWithDuration:.35 animations:^{
            
            _btnImg.transform = CGAffineTransformIdentity;
        }];
        
        //将 筛选 遮罩 视图移除
        [_maskView removeFromSuperview];
        [_selectTab removeFromSuperview];
        
        //请求数据
        _selectKey = @"ordercol=collectionorder";
        [self initData];
        
    }else if (sender.tag == 1302) {
        
        _fristSelecBtn.selected = NO;
        //刷新界面
        //将下拉三角返回原状
        [UIView animateWithDuration:.35 animations:^{
            
            _btnImg.transform = CGAffineTransformIdentity;
        }];
        
        //将 筛选 遮罩 视图移除
        [_maskView removeFromSuperview];
        [_selectTab removeFromSuperview];
        
        _selectKey = @"ordercol=salerder";
        [self initData];
    }
    
    //点击的btn颜色变为红色，其他的变为黑丝
    for (UIButton *btn in _bgView.subviews) {
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    [sender setTitleColor:PRICE_TEXT_RED forState:UIControlStateNormal];

}



//筛选列表
- (void)initSelectView {
    
    _selectArr = @[@"综合排序",@"价格从低到高",@"价格从高到低",@"信用排序"];
    _selectTab = [[YYBaseTableView alloc] initWithFrame:CGRectMake(0, _bgView.height, SCREEN_WIDTH, 44*_selectArr.count)];
    
    if ([_selectTab respondsToSelector:@selector(setSeparatorInset:)]){
        
        [_selectTab setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([_selectTab respondsToSelector:@selector(setLayoutMargins:)])
    {
        
        [_selectTab setLayoutMargins:UIEdgeInsetsZero];
    }
    
    _selectTab.bounces = NO;
    [self.view addSubview:_selectTab];
    _selectTab.dataSource = self;
    _selectTab.delegate = self;
    
    
    _maskView = [[UIView alloc] init];
    [self.view addSubview:_maskView];
    _maskView.backgroundColor = MYGRAYCOLOR;
    _maskView.alpha = 0.5;
    [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_selectTab.mas_bottom);
        make.height.equalTo(@SCREEN_HEIGHT);
        make.width.equalTo(@SCREEN_WIDTH);

    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    //将 筛选 遮罩 视图移除
    [_maskView removeFromSuperview];
    [_selectTab removeFromSuperview];
    _fristSelecBtn.selected = NO;
    
}

#pragma mark - SelectTableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _selectArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.selectionStyle = UITableViewCellStyleDefault;
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 100, cell.height)];
    text.text = _selectArr[indexPath.row];
    
    [cell.contentView addSubview:text];
    text.font = [UIFont systemFontOfSize:13];
    
    for (UIButton *button in _bgView.subviews) {
        
        if ([button.titleLabel.text isEqual:_selectArr[indexPath.row]]) {
            
            text.textColor = PRICE_TEXT_RED;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
 
            _selectKey = @"ordercol=scoreOrder";
            break;
        case 1:
            
            _selectKey = @"ordercol=priceOrder&ordertype=desc";
            break;
        case 2:
            
            _selectKey = @"ordercol=priceOrder&ordertype=asc";
            break;
        case 3:
            
            _selectKey = @"ordercol=scoreOrder";
            break;
            
        default:
            break;
    }
    
    _themeTab.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(initData)];
    [_themeTab.mj_header beginRefreshing];

    //将 筛选 遮罩 视图移除
    [_maskView removeFromSuperview];
    [_selectTab removeFromSuperview];

    _fristSelecBtn.selected = NO;
    [_fristSelecBtn setTitle:_selectArr[indexPath.row] forState:UIControlStateNormal];
    
    //将下拉三角返回原状
    [UIView animateWithDuration:.35 animations:^{
        
        _btnImg.transform = CGAffineTransformIdentity;
    }];
    

    
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

#pragma mark - HomeTableView;
- (void)initTableView {
    
    _themeTab = [[YYThemeTableView alloc] initWithFrame:CGRectMake(0, _bgView.height, SCREEN_WIDTH, SCREEN_HEIGHT - _bgView.height - 49)];
    [self.view addSubview:_themeTab];
    
}

//搜索key
- (void)setUrl:(NSString *)url {
    
    _url = url;
    
    _selectKey = _url;
   

    _themeTab.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(searchData)];
    [_themeTab.mj_header beginRefreshing];

}

- (void)searchData {
    
    if (!_dataArr) {
        
        _dataArr = [[NSMutableArray alloc] init];
    }else {
        
        [_dataArr removeAllObjects];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/app/searchProduct_list",BASE_URL];

    NSArray *aim = [_selectKey componentsSeparatedByString:@"="];
    
    NSDictionary *dic = @{aim[0]:aim[1]};
    
    [YYNetWorking getWithURL:url withParam:dic :^(id responsObjc) {
        
        
        NSDictionary *dataDic = responsObjc[@"data"];
        NSArray *listArr = dataDic[@"list"];
        
        for (NSDictionary *dic in listArr) {
            
            YYClearanceModel *model = [[YYClearanceModel alloc] initWithDictionary:dic];
            [_dataArr addObject:model];
        }
        
        _themeTab.dataArr = _dataArr;
        
        [_themeTab reloadData];
        
    }];
    [_themeTab.mj_header endRefreshing];
    
    
}

//首次获取数据
- (void)initData{

    if (!_dataArr) {
        
         _dataArr = [[NSMutableArray alloc] init];
    }else {
        
        [_dataArr removeAllObjects];
    }
    
   
    NSString *url = [NSString stringWithFormat:@"%@/app/searchProduct_list?%@",BASE_URL,_selectKey];
    

    [YYNetWorking homeHeaderWithURL:url :^(id responsObjc) {

        NSDictionary *dataDic = responsObjc[@"data"];
        NSArray *listArr = dataDic[@"list"];
  
        for (NSDictionary *dic in listArr) {
            
            YYClearanceModel *model = [[YYClearanceModel alloc] initWithDictionary:dic];
            [_dataArr addObject:model];
        }
        
        _themeTab.dataArr = _dataArr;
        
        [_themeTab reloadData];

    }];
    [_themeTab.mj_header endRefreshing];
    
    
}




@end
