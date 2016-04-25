//
//  YYPayTabView.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/11.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYPayTabView.h"
#import "YYHeadView.h"
#import "YYPayTableViewCell.h"
#import "YYHttpRequest.h"
#import "YYDistributionModel.h"

#define DEFA_CELL_HEIGHT 44
@implementation YYPayTabView
{
    YYHeadView *_header;
    
    NSInteger textFielHei;  //点击的textfile在_view上的origin。Y
    
    BOOL isHiden;       //键盘是否隐藏
    
    UITextField *_message;
    
    UIView *_distriView;   //配送方式
    
    UIView *_magerView;       //遮罩视图
    
    YYBaseTableView *_distriTab; //配送方式
    
    NSMutableArray *_distriData;  //配送数据
    
    NSString *_distriStr;           //配送数据
    
    CGPoint selfContentSet;
    


}
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
  
    if (self = [super initWithFrame:frame style:style]) {
      
        isHiden = NO;
        [self initDetails];
        
        self.dataSource = self;
        self.delegate = self;
        
        self.showsVerticalScrollIndicator = NO;
        
        //显示的时候添加监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selfKeyBoardShow:) name:UIKeyboardWillShowNotification object:nil];
        //隐藏的时候添加监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selfKeyBoardHidden) name:UIKeyboardWillHideNotification object:nil];
        
        if ([self respondsToSelector:@selector(setSeparatorInset:)]){
            
            [self setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([self respondsToSelector:@selector(setLayoutMargins:)])
        {
            
            [self setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    
    return self;
}

- (void)initDetails {
    
    _header = [[[NSBundle mainBundle] loadNibNamed:@"YYHeadView" owner:nil options:nil] lastObject];
    
    self.tableHeaderView = _header;
    
}

//为头视图赋值
- (void)setModel:(YYAddressModel *)model {
    
    _model = model;
    _header.model = _model;
    

    
}

- (void)setDataArr:(NSArray *)dataArr {
    
    _dataArr = dataArr;
    
    _distriArr = [[NSMutableArray alloc] init];
    _messageArr = [[NSMutableArray alloc] init];
    
    [self reloadData];
}

#pragma mark - 键盘
//键盘显示
- (void)selfKeyBoardShow:(NSNotification *)notification {
   
    NSValue *value = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect rect = [value CGRectValue];
    CGFloat keyBoardHeight = rect.size.height;

    selfContentSet = self.contentOffset;
    NSLog(@"%.f---%ld",keyBoardHeight - (SCREEN_HEIGHT -textFielHei)+150,textFielHei);
    if (SCREEN_HEIGHT - textFielHei-50 < keyBoardHeight) {

        self.contentOffset = CGPointMake(0, self.contentOffset.y + keyBoardHeight - (SCREEN_HEIGHT -textFielHei)+150);
    }
     isHiden = YES;
}

//键盘隐藏
- (void)selfKeyBoardHidden {
    
    
    self.contentOffset = selfContentSet;
    
    self.tableFooterView = [UIView new];

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView.tag == 4300) {
        
        return 1;
    }
    
    return _dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView.tag == 4300) {
        
        return _distriData.count;
    }
    
    NSArray *product = _dataArr[section];
    
    return product.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 4300) {
        
        UITableViewCell *distriCell = [tableView dequeueReusableCellWithIdentifier:@"distriCell"];
        
        if (!distriCell) {
            
            distriCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"distriCell"];
        }
        
        YYDistributionModel *model = _distriData[indexPath.row];
        UILabel *titler = [[UILabel alloc] init];
        [distriCell.contentView addSubview:titler];
        
        titler.text = model.name;
        titler.font = TEXT_FONT;
        [titler mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(distriCell.mas_left).offset(10);
            make.width.equalTo(@100);
            make.height.equalTo(distriCell.mas_height);
            make.centerY.equalTo(distriCell.mas_centerY);
        }];
        
        UILabel *price = [[UILabel alloc] init];
        [distriCell.contentView addSubview:price];
        
        price.text = [NSString stringWithFormat:@"%ld",model.price];
        price.textAlignment = NSTextAlignmentRight;
        price.font = TEXT_FONT;
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(distriCell.mas_right).offset(-60);
            make.width.equalTo(@100);
            make.height.equalTo(distriCell.mas_height);
            make.centerY.equalTo(distriCell.mas_centerY);
            
        }];
   
        UIButton *check = [UIButton buttonWithType:UIButtonTypeCustom];
        [distriCell.contentView addSubview:check];
        
        check.tag = 4400 + indexPath.row;
        [check setImage:[UIImage imageNamed:@"cp_checkbox_on"] forState:UIControlStateSelected];
        [check setImage:[UIImage imageNamed:@"common_ic_radiobox_off"] forState:UIControlStateNormal];
        [check addTarget:self action:@selector(distributoinAct:) forControlEvents:UIControlEventTouchUpInside];
        [check mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(distriCell.mas_right).offset(-10);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
            make.centerY.equalTo(distriCell.mas_centerY);
            
        }];
        
        distriCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return distriCell;
    }
   
    //产品cell
    YYPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"payCell"];
    //配送方式cell
    UITableViewCell *cellDefa = [tableView dequeueReusableCellWithIdentifier:@"defaCell"];
    //留言cell
    UITableViewCell *sayCell = [tableView dequeueReusableCellWithIdentifier:@"sayCell"];
    
    NSArray *product = _dataArr[indexPath.section];
    if (indexPath.row < product.count) {
        
        if (!cell) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"YYPayTableViewCell" owner:nil options:nil] lastObject];
        }
        
        cell.model = product[indexPath.row];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
         return cell;

    }else {
        if (!cellDefa) {
            
            cellDefa = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"defaCell"];
        }
        
        if (!sayCell) {
            
            sayCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sayCell"];
        }

        if (indexPath.row == product.count) {
          
            UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, DEFA_CELL_HEIGHT)];
            [cellDefa.contentView addSubview:text];
            text.text = @"配送方式";
            text.font = TITLE_FONT;
            
            UILabel *distributelab = [[UILabel alloc] initWithFrame:CGRectMake(text.width , 0, SCREEN_WIDTH - text.width - 30, DEFA_CELL_HEIGHT)];
            [cellDefa.contentView addSubview:distributelab];
            
            distributelab.textAlignment = NSTextAlignmentRight;
            distributelab.text = @"免费";
            distributelab.font = TITLE_FONT;
            
            distributelab.tag = 4500 + indexPath.section;
            
            cellDefa.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cellDefa.selectionStyle = UITableViewCellSeparatorStyleNone;

            [_distriArr addObject:distributelab.text];
            return cellDefa;
            
        }else if (indexPath.row == product.count + 1) {
            
            UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 70, DEFA_CELL_HEIGHT)];
            [sayCell.contentView addSubview:text];
            
            text.text = @"买家留言";
            text.font = TITLE_FONT;
            
           UITextField *msg = [[UITextField alloc] initWithFrame:CGRectMake(text.width, 0, SCREEN_WIDTH - text.width -30, DEFA_CELL_HEIGHT)];
            [sayCell.contentView addSubview:msg];
            
            msg.placeholder = @"选填，可填写您与卖家达成一致的要求";
            msg.font = TITLE_FONT;

            msg.tag = 4200 + indexPath.section;
            msg.delegate = self;
            sayCell.accessoryType = UITableViewCellAccessoryNone;
            
            [_messageArr addObject:msg.text];
            return sayCell;
        }
        
    }
   
    return nil;
     
}

//运费小圆点的点击事件
- (void)distributoinAct:(UIButton *)sender {
    
    for (int i = 0;  i < _distriData.count; i ++) {
        
        UIButton *button  = [_distriTab viewWithTag:4400 + i];
        
        button.selected = NO;
    }
    
    sender.selected = YES;
    
    YYDistributionModel *model = _distriData[sender.tag - 4400];
    _distriStr = [NSString stringWithFormat:@"%@ %ld",model.name,model.price];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    _message = textField;
    
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {

    //获得当前textfile在 主view 上的 坐标 和 高度
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 500)];
    
    CGRect frame = [textField.superview convertRect:textField.frame toView:self.viewController.view];
    textFielHei = frame.origin.y;

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    //后台需要的参数
    [_messageArr replaceObjectAtIndex:textField.tag - 4200 withObject:textField.text];
    
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
 
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - 配送方式
- (void)showDistributionMode:(NSInteger)section withRow:(NSInteger)row {

    _distriView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-64, SCREEN_WIDTH, 300)];
    
    [self.superview addSubview:_distriView];
    [self.superview bringSubviewToFront:_distriView];
    
    _distriView.backgroundColor = [UIColor orangeColor];

    [UIView animateWithDuration:.35 animations:^{
        
        _distriView.transform = CGAffineTransformTranslate(_distriView.transform, 0, -_distriView.height);
    }];
    
    //title
    UILabel *title = [[UILabel alloc] init];
    [_distriView addSubview:title];
    
    title.text = @"配送方式";
    title.textAlignment = NSTextAlignmentCenter;

    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(_distriView.mas_width);
        make.height.equalTo(@50);
        make.top.equalTo(_distriView.mas_top);
        make.left.equalTo(_distriView.mas_left);
        
    }];
    
    //tableView
    _distriTab = [[YYBaseTableView alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, _distriView.width - 50 - 50-10)] ;
    _distriTab.tag = 4300;
    [_distriView addSubview:_distriTab];
    
    _distriTab.tableFooterView = [UIView new];
    _distriTab.bounces = NO;
    
    _distriTab.delegate = self;
    _distriTab.dataSource = self;
    
    //确定
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.backgroundColor = SHOPPING_DELETE_BG;
    [_distriView addSubview:sureBtn];
    sureBtn.tag = 4600 + section;
    
    [sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(_distriView.mas_width);
        make.height.equalTo(@50);
        make.bottom.equalTo(_distriView.mas_bottom);
        make.left.equalTo(_distriView.mas_left);
        
    }];
    
    [sureBtn addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //遮罩视图
    _magerView = [[UIView alloc] initWithFrame:self.superview.bounds];
    [self.superview insertSubview:_magerView belowSubview:_distriView];
    
    _magerView.backgroundColor = [UIColor blackColor];
    _magerView.alpha = 0.5;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [_magerView addGestureRecognizer:tap];

    [self distriTabData:section withRow:row];
}

//配送方式的数据
- (void)distriTabData:(NSInteger)section withRow:(NSInteger)row {
   
    NSArray *product = _dataArr[section];

    //传递的参数
    NSInteger money = 0;
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    NSString *shopId = nil;
    for (int i = 0; i < product.count; i ++) {
        
        YYShoppingModel *productModel = product[i];
        
        money += [productModel.number integerValue] * [productModel.price integerValue];
        NSMutableDictionary *productDic = (NSMutableDictionary *)[productModel dictionaryFromModel];
        
        [productDic removeObjectForKey:STAIC];
        [productDic removeObjectForKey:STOCK];
        
        for (NSString *key in productDic) {
            
            NSString *str = [NSString stringWithFormat:@"dataList[%d].%@",i,key];
         
            [paramDic setObject:productDic[key] forKey: str];

            if ([key isEqualToString:SHOP_ID]) {
                
                shopId = productDic[key];
            }
            
        }
    }

    [paramDic setObject:shopId forKey:SHOP_ID];
    [paramDic setObject:@"2222" forKey:@"dataList[0].price"];
    [paramDic setObject:@"2222" forKey:@"dataList[0].total"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,@"/app/expressModule_find"];

    _distriData = [[NSMutableArray alloc] init];
    [YYNetWorking postwithURL:url withParam:paramDic withHeader:nil success:^(id responsObjc) {
        
        
        NSDictionary *data = responsObjc[@"data"];
        NSArray *list = data[@"list"];
        
        for (NSDictionary *dic in list) {
            
            YYDistributionModel *model = [[YYDistributionModel alloc] initWithDictionary:dic];
            
            [_distriData addObject:model];
        }
        
        [_distriTab reloadData];
    }];
}

//配送方式  确定
- (void)sureBtnAction:(UIButton *)sender {
 
    UILabel *distriLab = [self viewWithTag:4500+(sender.tag - 4600)];
    
    distriLab.text = _distriStr;
 
    [self tapGesture];

}
//tap手势
- (void)tapGesture {
    //隐藏临时视图和遮罩视图
    [UIView animateWithDuration:.35 animations:^{
        
        _distriView.transform = CGAffineTransformIdentity;
        
        [_magerView removeFromSuperview];
        
    } completion:^(BOOL finished) {
        
        [_distriView removeFromSuperview];
        
    }];
    
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [_message resignFirstResponder];
  
    if (tableView.tag == 4300) {
        
        for (int i = 0;  i < _distriData.count; i ++) {
            
            UIButton *sender  = [tableView viewWithTag:4400 + i];
            
            sender.selected = NO;
        }
        
        UIButton *sender  = [tableView viewWithTag:4400 + indexPath.row];
        sender.selected = YES;
       
        //传递给self 的某个分组的配送
        YYDistributionModel *model = _distriData[sender.tag - 4400];
        _distriStr = [NSString stringWithFormat:@"%@ %ld",model.name,model.price];
        //后台需要的参数
        [_distriArr replaceObjectAtIndex:sender.tag - 4400 withObject:_distriStr];
        
        return;
        
    }
    NSArray *product = _dataArr[indexPath.section];
    if (indexPath.row == product.count) {
        
        [self showDistributionMode:indexPath.section withRow:indexPath.row];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 4300) {
        
        return 44;
    }
    
    NSArray *product = _dataArr[indexPath.section];
    if (indexPath.row < product.count) {
        
        return 100;
        
    }else {
        
        return DEFA_CELL_HEIGHT;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  
    if (tableView.tag == 4300) {
        
        return 0;
    }
    
    return DEFA_CELL_HEIGHT +10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    if (tableView.tag == 4300) {
        
        return 0;
    }
    return DEFA_CELL_HEIGHT;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSArray *product = _dataArr[section];
    YYShoppingModel *model = product[0];
    
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 10, 44)];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, DEFA_CELL_HEIGHT)];
    [view addSubview:image];
    image.image = [UIImage imageNamed:@"line"];
    image.userInteractionEnabled = YES;
    image.transform = CGAffineTransformMakeRotation(M_PI);
    
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 25, 25)];
    [view addSubview:iconView];
    iconView.centerY = view.centerY + 10;
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,model.shopImg];
    [iconView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:DEFA_IMAGE];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(40, 10,view.width-iconView.width, view.height)];
    [view addSubview:name];
    name.text = model.shopName;
    name.font = TITLE_FONT;
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    NSArray *product = _dataArr[section];
    
    UIView *view =[[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"line"]];
    
    UILabel *money = [[UILabel alloc] init];
    [view addSubview:money];
    
    int moneys = 0;
    for (YYShoppingModel *model in product) {
        
        int price = [model.price intValue];
        int number = [model.number intValue];
        
        moneys += price * number;
    }
    NSString *oldPrice = [NSString stringWithFormat:@"合计：￥%d元",moneys];
    
    NSUInteger length = [oldPrice length];
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:oldPrice attributes:@{NSFontAttributeName:BUTTON_FONT}];
    
    [attri addAttribute:NSForegroundColorAttributeName value:PRICE_TEXT_RED range:NSMakeRange(3, length-4)];
    [attri addAttribute:NSFontAttributeName value:TITLE_FONT range:NSMakeRange(0, 3)];
    [attri addAttribute:NSFontAttributeName value:TITLE_FONT range:NSMakeRange(length-1, 1)];
    [money setAttributedText:attri];
  
    CGSize size = [money.text sizeWithAttributes:@{NSFontAttributeName:TITLE_FONT}];
    money.width = size.width + 40;
    money.frame = CGRectMake(SCREEN_WIDTH - money.width, 0, money.width, DEFA_CELL_HEIGHT);
  
    UILabel *number = [[UILabel alloc] init];
    [view addSubview:number];
    
    number.text = [NSString stringWithFormat:@"共%d件商品",product.count];
    number.font = TEXT_FONT;
    number.textAlignment = NSTextAlignmentRight;
    [number mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(view.mas_height);
        make.right.equalTo(money.mas_left).offset(-10);
        make.left.equalTo(view.mas_left);
        make.top.equalTo(view.mas_top).offset(3);
       
    }];
   
    return view;
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


//释放第一响应者
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    if (isHiden == YES) {
        
        [_message resignFirstResponder];
        
        self.contentOffset = selfContentSet;
    }
    

}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
}

@end
