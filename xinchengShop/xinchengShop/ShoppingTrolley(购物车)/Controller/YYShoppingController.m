//
//  YYShoppingController.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/22.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYShoppingController.h"
#import "YYSectionView.h"
#import "YYShoppingDownView.h"
#import "YYMyData.h"
#import "YYShoppingModel.h"
#import "YYPayViewController.h"

#define DOWN_HEIGHT 50

@interface YYShoppingController ()

{
    
    YYShoppingDownView *_downView;

    //是否编辑
//    NSMutableArray *_sectionArr;    // 产品的编辑状态--YES的时候编辑界面隐藏
    NSMutableArray *_sectionEdit;   // bool 类型--- section的编辑状态
    //数据
    NSMutableArray *_sectionData;
    
    NSMutableArray *_sectionSelect;    //section 的选中状态
    NSMutableArray *_productSelect;     // 产品的选中状态
    
    YYEditView *_editView;                    //编辑界面
    int buyNum;                            //购买的数量
    UILabel *_numLab;                       //购买数量Label

    NSMutableArray *payStoreArr;        //payVC  店铺
    NSMutableArray *payProductArr;      //payVC  产品
  
    NSInteger _money;                    //合计
}

@end

@implementation YYShoppingController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self initData];
    
    _downView.select.selected = YES;
    _downView.price.text = @"合计：0元";
    
   
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [_downView.select setImage:[UIImage imageNamed:@"ccr_ic_repay_result_begin"] forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
 

    buyNum = 1;

    [self initData];
    [self initTableView];
    [self initDownView];
    [self refresh];
}

- (void)refresh {
    
    _tableView.mj_header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(initData)];
    [_tableView.mj_header beginRefreshing];
  
}

#pragma mark - 获取数据
- (void)initData {
    
    if (!_sectionData) {
        
        _sectionData = [[NSMutableArray alloc] init];
        
        _sectionEdit = [[NSMutableArray alloc] init];
        
        _productSelect = [[NSMutableArray alloc] init];
        
        _sectionSelect = [[NSMutableArray alloc] init];
        
    }else {
        
        [_sectionData removeAllObjects];
        [_sectionEdit removeAllObjects];
        [_sectionSelect removeAllObjects];
        [_productSelect removeAllObjects];
        
    }

    YYMyData *data = [[YYMyData alloc] init];

    NSArray *dataArr =[data getData];
   
    for (NSArray *productArr in dataArr) {
        
        //   产品   ------  是否编辑或全选
        NSMutableArray *productData = [[NSMutableArray alloc] init];
        NSMutableArray *isEditArr = [[NSMutableArray alloc] init];
        
        //productArr----店铺
        //dic ---- 产品
        for (NSDictionary *dic in productArr) {
            
            YYShoppingModel *model = [[YYShoppingModel alloc] initWithDictionary:dic];
            
            [productData addObject:model];
            [isEditArr addObject:@"YES"];
        }
        //数据
        [_sectionData addObject:productData];
        
        //编辑
        [_sectionEdit addObject:@"YES"];
        
        //全选  ---- row  ----   section
        [_productSelect addObject:isEditArr];
        [_sectionSelect addObject:@"YES"];
 
    }
    
    if (_tableView) {
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
    }


}

#pragma mark - DownView
- (void)initDownView {
    
    _downView = [[[NSBundle mainBundle] loadNibNamed:@"YYShoppingDownView" owner:nil options:nil] lastObject];
    
    [self.view addSubview:_downView];
    [_downView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(_tableView.mas_bottom).offset(-49);
        make.height.equalTo(@DOWN_HEIGHT);
  
    }];
    
    [_downView.select setImage:[UIImage imageNamed:@"ccr_ic_repay_result_begin"] forState:UIControlStateNormal];
    //全选
    [_downView.checkBtn addTarget:self action:@selector(makeAllSelect:) forControlEvents:UIControlEventTouchUpInside];
    //支付
    [_downView.payBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addPriceWithDownView];
    
}

//支付
- (void)payAction:(UIButton *)sender {
    
    for (NSArray *arr in payStoreArr) {
        
        if (arr.count > 0) {
            
            YYPayViewController *vc = [YYPayViewController payViewController];
            
            vc.shopArr = payStoreArr;
            vc.money = _money;
            [self.navigationController pushViewController:vc animated:YES];
            
            return;
        }else {
            
            [self showAlert:@"你没有需要付款的产品"];
        }
    }
}
- (void)showAlert:(NSString *)titler {
    
    NSString *sure = @"确定";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titler message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:sure style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:^{
        
        
    }];
    
}

//合计
- (void)addPriceWithDownView {

    //需要付款的商店集合
    payStoreArr = [[NSMutableArray alloc] init];
    
    //根据cell的select判断
    for (int i = 0; i < _productSelect.count; i ++) {
        
        NSArray *productArr = _productSelect[i];
        
        //商店的产品集合
        NSMutableArray *products = [[NSMutableArray alloc] init];
        
        for (int j = 0; j < productArr.count; j ++) {
            
            NSString *select = productArr[j];
            
            if ([select isEqualToString:@"NO"]) {
                
                NSArray *data = _sectionData[i];
                YYShoppingModel *model = data[j];
                
                int numberInt= [model.number intValue];
                int price = [model.price intValue];
                
                _money += numberInt * price;
        
                //添加产品
                [products addObject:model];
            }
        }
        //给payvc 传递的商店集合
        [payStoreArr addObject:products];
    }
  
    _downView.price.text = [NSString stringWithFormat:@"合计：%ld元",_money];
}



//downView全选按钮点击事件
- (void)makeAllSelect:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected == YES) {

        [_downView.select setImage:[UIImage imageNamed:@"cp_checkbox_on"] forState:UIControlStateNormal];

        //section
        for (int i = 0; i < _sectionSelect.count; i ++) {
            
            [_sectionSelect replaceObjectAtIndex:i withObject:@"NO"];
        }
        
        //row
        for (NSMutableArray *select in _productSelect) {
            
            for (int i = 0; i < select.count; i ++) {
               
                [select replaceObjectAtIndex:i withObject:@"NO"];
            }
        }
       
    }else {
        
        [_downView.select setImage:[UIImage imageNamed:@"ccr_ic_repay_result_begin"] forState:UIControlStateNormal];
        
        //section
        for (int i = 0; i < _sectionSelect.count; i ++) {
            
            [_sectionSelect replaceObjectAtIndex:i withObject:@"YES"];
        }
        
        //row
        for (NSMutableArray *select in _productSelect) {
            
            for (int i = 0; i < select.count; i ++) {
                
                [select replaceObjectAtIndex:i withObject:@"YES"];
            }
        }
      
        _money = 0;
      
    }
    
    [self addPriceWithDownView];
    
    [_tableView reloadData];
    
}

#pragma mark - downView全选
//判断是否全选
- (void)allSelectWithDownView {
    
    NSMutableSet *isSel = [[NSMutableSet alloc] init];
    for (NSArray *selectArr in _productSelect) {
        
        NSSet *selectSet = [NSSet setWithArray:selectArr];
        
        if (selectSet.count == 1) {
            
            NSString *isSelect = selectArr[0];
            
            [isSel addObject:isSelect];
        }
    }
   
    if (isSel.count == 1 && [[isSel anyObject] isEqualToString:@"NO"]) {
      
        //全选
        _downView.checkBtn.selected = YES;
        
        [_downView.select setImage:[UIImage imageNamed:@"cp_checkbox_on"] forState:UIControlStateNormal];
        
    }else {
        
        //不全选
        _downView.checkBtn.selected = NO;
        [_downView.select setImage:[UIImage imageNamed:@"ccr_ic_repay_result_begin"] forState:UIControlStateNormal];
    }
   
    [self addPriceWithDownView];
}

#pragma mark - UITableView
- (void)initTableView {
    
    _tableView = [[YYBaseTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - DOWN_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.clipsToBounds = YES;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
    return _sectionData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *product = _sectionData[section];
    
    return product.count;
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *identifual = @"shoppingCell";
    
    YYShoppingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifual];
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYShoppingTableViewCell" owner:nil options:nil] lastObject];
    }
    
    //cell前端 的小圆圈
    NSArray *select = _productSelect[indexPath.section];
    NSString *selectStr = select[indexPath.row];
    cell.select.selected = [selectStr boolValue];
    
    [cell.select setImage:[UIImage imageNamed:@"cp_checkbox_on"] forState:UIControlStateNormal];
    [cell.select setImage:[UIImage imageNamed:@"ccr_ic_repay_result_begin"] forState:UIControlStateSelected];
    
    //给cell赋值
    NSArray *product = _sectionData[indexPath.section];
    YYShoppingModel *model = product[indexPath.row];
    cell.model = model;
   
    //编辑视图
    UIView *leftView = [[UIView alloc] init];
    [cell.contentView addSubview:leftView];
    
    //显示编辑状态
    NSString *isEditStr = _sectionEdit[indexPath.section];
    leftView.hidden = [isEditStr boolValue];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(cell.mas_right);
        make.left.equalTo(cell.icon.mas_right);
        make.top.equalTo(cell.mas_top);
        make.bottom.equalTo(cell.mas_bottom);

    }];
    
    _editView = [[[NSBundle mainBundle] loadNibNamed:@"YYEditView" owner:nil options:nil] lastObject];
    
    _editView.frame = leftView.bounds;
    [leftView addSubview:_editView];
    
    [_editView initNumberView];
    
    _editView.staic.text = model.staic;
    _editView.buyNum = [model.number intValue];
    _editView.model = model;
  
    _editView.section = indexPath.section;
    _editView.row = indexPath.row;
    _editView.editDelegate = self;
    
    cell.cellDelegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    cell.section = indexPath.section;
    cell.row = indexPath.row;

    

    return cell;
}

#pragma mark - CellDelegate --- cell的小圆圈点击代理
- (void)cellWithSection:(NSInteger)section withRow:(NSInteger)row {
    
    //获取到点击的小圆圈
    NSMutableArray *select = _productSelect[section];
    
    NSString *isSelect = select[row];

    if ([isSelect isEqualToString:@"YES"]) {
       
        [select replaceObjectAtIndex:row withObject:@"NO"];
     
        NSSet *set = [NSSet setWithArray:select];
        
        //如果都选中的话 将section的前端小圆圈设置为 ---选中状态
        if (set.count == 1) {
            
              [_sectionSelect replaceObjectAtIndex:section withObject:@"NO"];
        }
   
    }else {
        
        [select replaceObjectAtIndex:row withObject:@"YES"];
        //设置section 前端 小圆圈的选中状态
        [_sectionSelect replaceObjectAtIndex:section withObject:@"YES"];
  
    }
    //判断是否全选
    [self allSelectWithDownView];
    [_tableView reloadData];
 
}

#pragma mark - EditDelegate
- (void)productModel:(YYShoppingModel *)model withSection:(NSInteger)section withRow:(NSInteger)row {
   
    //将数据从数据源移除
    NSMutableArray *product = _sectionData[section];

    if (product.count == 1) {
        
        //移除分组
        [_sectionEdit removeObjectAtIndex:section];
        [_sectionSelect removeObjectAtIndex:section];
        [_sectionData removeObjectAtIndex:section];
        
    }
    
    [product removeObjectAtIndex:row];

    //section全选  获取到点击的小圆圈
    //如果删除数据后整个分组都被选中则改变section的小圆圈状态
    NSMutableArray *select = _productSelect[section];
    [select removeObjectAtIndex:row];
    NSSet *set = [NSSet setWithArray:select];
    
    if (set.count == 1 && [[set anyObject] isEqualToString:@"NO"]) {
   
        [_sectionSelect replaceObjectAtIndex:section withObject:@"NO"];
        
    }
    
    NSSet *sectionSet = [[NSSet alloc] initWithArray:_sectionSelect];
    
    if (sectionSet.count == 1) {
        
        if ([[sectionSet anyObject] isEqualToString:@"NO"]) {
            
            [self allSelectWithDownView];
        }
    }

    [_tableView reloadData];
    
    //从数据库中移除数据
    YYMyData *data = [[YYMyData alloc] init];
    
    [data changeData:model];
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    YYSectionView *sectionView = [[[NSBundle mainBundle] loadNibNamed:@"YYSectionView" owner:nil options:nil] lastObject];

    NSArray *product = _sectionData[section];
    sectionView.model = product[0];
    
    sectionView.editBtn.tag = 4000 + section;
    sectionView.select.tag = 5000 + section;
    
    //编辑
    [sectionView.editBtn addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    //全选
    [sectionView.select addTarget:self action:@selector(cellSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [sectionView.select setImage:[UIImage imageNamed:@"cp_checkbox_on"] forState:UIControlStateNormal];
    [sectionView.select setImage:[UIImage imageNamed:@"ccr_ic_repay_result_begin"] forState:UIControlStateSelected];
    
    //改变编辑的选中状态
    BOOL isEdit = [_sectionEdit[section] boolValue];
    sectionView.editBtn.selected = isEdit;
    
    //改变全选的选中状态
    BOOL isSelect = [_sectionSelect[section] boolValue];
    sectionView.select.selected = isSelect;
    
    if (sectionView.select.selected == YES) {
        
        sectionView.select.backgroundColor = [UIColor clearColor];

        
    }else {
        
        sectionView.select.backgroundColor = MYGRAYCOLOR;
    }
 
 
    return sectionView;
}

#pragma mark - 编辑
//编辑
- (void)editAction:(UIButton *)sender {

    //index就是点击的section位置
    NSInteger index = sender.tag - 4000;
    
    //编辑
    if (sender.selected == YES) {
        
        [_sectionEdit replaceObjectAtIndex:index withObject:@"NO"];
        
    }else {

        //完成
        [_sectionEdit replaceObjectAtIndex:index withObject:@"YES"];
    }
    
    [_tableView reloadData];
   
}
/*
- (void)getData {

    YYMyData *data = [[YYMyData alloc] init];
    
    NSArray *dataArr =[data getData];
    
    [_sectionData removeAllObjects];
  
    for (NSArray *productArr in dataArr) {
        
        NSMutableArray *productData = [[NSMutableArray alloc] init];
        NSMutableArray *isEditArr = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in productArr) {
            
            YYShoppingModel *model = [[YYShoppingModel alloc] initWithDictionary:dic];
            
            [productData addObject:model];
            [isEditArr addObject:@"YES"];
        }
        
        [_sectionData addObject:productData];
        [_sectionEdit addObject:@"NO"];
    }
    
    [_tableView reloadData];

}
*/
//section中点击全选   将全部的选中状态设为 YES / NO
- (void)cellSelectAction:(UIButton *)sender {
    
    //index就是点击的section位置
    NSInteger index = sender.tag - 5000;
    
    NSMutableArray *isEditArr = _productSelect[index];
    
    if (sender.selected == YES) {
        
        [_sectionSelect replaceObjectAtIndex:index withObject:@"NO"];
        
        for (int i = 0; i < isEditArr.count; i ++) {
            
            [isEditArr replaceObjectAtIndex:i withObject:@"NO"];
        }
        //downView全选
        [self allSelectWithDownView];
        
        
    }else {
        
        [_sectionSelect replaceObjectAtIndex:index withObject:@"YES"];

        for (int i = 0; i < isEditArr.count; i ++) {
            
            [isEditArr replaceObjectAtIndex:i withObject:@"YES"];
  
        }
        //downView 取消全选
        _downView.checkBtn.selected = NO;
        [_downView.select setImage:[UIImage imageNamed:@"ccr_ic_repay_result_begin"] forState:UIControlStateNormal];
        
        _downView.price.text = @"合计：0元";
    }
    
    
    
    [_tableView reloadData];
   
}

@end
