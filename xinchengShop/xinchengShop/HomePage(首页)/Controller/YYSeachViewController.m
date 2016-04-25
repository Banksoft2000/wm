//
//  YYSeachViewController.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/20.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYSeachViewController.h"
#import "YYXCViewController.h"

@interface YYSeachViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate> {
    
    UISearchBar *_searchBar;
    
    UITableView *_tableView;
    
    NSFileManager *_manager;
    NSString *_path;
    
    NSMutableArray *_dataArr;
    
    NSInteger _keyHeight;
}

@end

@implementation YYSeachViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (_searchBar) {
        
        [_searchBar becomeFirstResponder];
        
        _searchBar.text = nil;
    }
    
    if (_tableView) {
        
        [self getData];
        [_tableView reloadData];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = LIGHT_GRAY;
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];

    //文件地址
    NSString *home = NSHomeDirectory();
    _path = [NSString stringWithFormat:@"%@/Documents/search.plist",home];
    
    _manager = [[NSFileManager alloc] init];
   
    [self getData];

    [self initNavigationBar];
//
    [self initTableView];
    

    
}

- (void)getData {
    
    _dataArr = [[NSMutableArray alloc] initWithContentsOfFile:_path];
}

//获取键盘的高度
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    _tableView.height = SCREEN_HEIGHT - keyboardRect.size.height - 64;

}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];

}

#pragma mark - tableView
- (void)initTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _keyHeight) style:UITableViewStyleGrouped];
    
    [self.view addSubview:_tableView];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = LIGHT_GRAY;
    _tableView.showsVerticalScrollIndicator = NO;
}

#pragma mark - UITableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchCell"];
    }
    
    cell.textLabel.text = _dataArr[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //放到首位
    [_dataArr exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
    [_dataArr writeToFile:_path atomically:YES];
    
    [_searchBar resignFirstResponder];
    YYXCViewController *vc = [[YYXCViewController alloc] init];
    vc.url = [NSString stringWithFormat:@"name=%@",_dataArr[0]];
        vc.title = @"商品列表";
    [self.navigationController pushViewController:vc animated:YES];
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UILabel *header = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    
    header.text = @"   历史记录";
    header.textColor = [UIColor grayColor];
    
    return header;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *bgView = [[UIView alloc] init];
    UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
    
    delete.frame = CGRectMake(0, 10, 100, 20);
    delete.centerX = self.view.centerX;
    delete.backgroundColor = SHOPPING_DELETE_BG;
    delete.layer.cornerRadius = 10;
    [delete setTitle:@"清除记录" forState:UIControlStateNormal];
    delete.titleLabel.font = TITLE_FIF_FONT;
    [delete addTarget:self action:@selector(deleteHistroy:) forControlEvents:UIControlEventTouchUpInside];
    

    [bgView addSubview:delete];
    return bgView;
    
}

//清除历史记录
- (void)deleteHistroy:(UIButton *)sender {
    
   [_manager removeItemAtPath:_path error:nil];
    
    [_dataArr removeAllObjects];
    
    [_tableView reloadData];
 
}

#pragma mark - NavigationBar
- (void)initNavigationBar {

    UIView *barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    barView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NavBar64"]];
    self.navigationItem.titleView = barView;

    //搜索视图
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [barView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@44);
        make.width.equalTo(@44);
        make.right.equalTo(barView.mas_right).offset(0);
        make.centerY.equalTo(barView.mas_centerY);
    }];
    [rightBtn addTarget:self action:@selector(searchInfo) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    
    
    //返回视图
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [barView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.height.equalTo(@30);
        make.width.equalTo(@30);
        make.centerY.equalTo(barView.mas_centerY);
        
    }];
    
    [leftBtn addTarget:self action:@selector(dismissTosuper) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setImage:[UIImage imageNamed:@"title_back_icon"] forState:UIControlStateNormal];

    //搜索框
    _searchBar = [[UISearchBar alloc] init];
    [barView addSubview:_searchBar];
    _searchBar.placeholder = @"请输入关键字";
    _searchBar.delegate = self;
    _searchBar.backgroundColor = [UIColor clearColor];
    _searchBar.backgroundImage = [UIImage imageNamed:@"NavBar64"];

    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(rightBtn.mas_left).offset(-10);
        make.left.equalTo(barView.mas_left).offset(30);
         make.centerY.equalTo(barView.mas_centerY);
    }];
    
    [_searchBar becomeFirstResponder];
    _searchBar.returnKeyType = UIReturnKeySearch;

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self searchInfo];

}


//返回
- (void)dismissTosuper {
    
    [_searchBar resignFirstResponder];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//搜索
- (void)searchInfo {
    
    if (_searchBar.text.length < 1) {
        
        return;
    }
 

    if (!_dataArr) {
        
        _dataArr = [[NSMutableArray alloc] init];
    }
    
    //最新添加的数据放在首位
    [_dataArr insertObject:_searchBar.text atIndex:0];
    
    //最大存储量为20条数据
    if (_dataArr.count > 20) {
        
        [_dataArr removeLastObject];
    }

    [_searchBar resignFirstResponder];
    [_dataArr writeToFile:_path atomically:YES];
    
    YYXCViewController *vc = [[YYXCViewController alloc] init];
    
    vc.title = @"商品列表";
    NSString *value = _searchBar.text;
    vc.url = [NSString stringWithFormat:@"name=%@",value];

    [self.navigationController pushViewController:vc animated:YES];

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
