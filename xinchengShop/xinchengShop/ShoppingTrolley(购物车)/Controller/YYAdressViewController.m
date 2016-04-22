//
//  YYAdressViewController.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/11.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYAdressViewController.h"
#import "YYAreaViewController.h"
//#import "YYAddressData.h"

@interface YYAdressViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    YYBaseTableView *adressTabl;
   
    NSArray *data; //列表的提示信息
    
    //存储的数据
    NSMutableDictionary *_dataDic;
    
    //请选择区域
    NSMutableString *_adressArea;
    
    //详细地址
    NSMutableString *_adressDetail;
    
    //请选择区域
    UIButton *_addBtn;
    
    UITextField *_textField;
}

@end

@implementation YYAdressViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    if (_isAdd == YES) {
        
        _isAdd = NO;
        _model = nil;

        [adressTabl reloadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!_dataDic) {
        
        _dataDic = [[NSMutableDictionary alloc] init];
    }

    data = @[@"请输入收件人姓名",@"请输入联系电话",@"邮政编码",@"请选择区域",@"详细地址",@"默认地址"];

    [self initTable];
    
    [self downView];

}

- (void)setModel:(YYAddressModel *)model {
    
    _model = model;
    
    if (!_dataDic) {
        
        _dataDic = [[NSMutableDictionary alloc] init];
    }

    _dataDic = (NSMutableDictionary *)[_model dictionaryFromModel];
    [adressTabl reloadData];
}

- (void)setAdressStr:(NSString *)adressStr {
    
    _adressStr = adressStr;
    
    [_addBtn setTitle:_adressStr forState:UIControlStateNormal];

    NSArray *detailArr = [_adressStr componentsSeparatedByString:@" "];
    
    if (_dataDic[ADRESS]) {
        
        [_dataDic removeObjectForKey:ADRESS];
    }
    [_dataDic setObject:detailArr[0] forKey:PROVINCE];
    [_dataDic setObject:detailArr[1] forKey:CITY];
    [_dataDic setObject:detailArr[2] forKey:COUNTY];

}

+ (YYAdressViewController *)aderssViewController {
    
    static YYAdressViewController *adress = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (!adress) {
            
            adress = [[YYAdressViewController alloc] init];
        }
    });
    
    return adress ;
}

#pragma mark - tableView
- (void)initTable {
    
    adressTabl = [YYAdressViewController tableView];
    [self.view addSubview:adressTabl];
    
    adressTabl.delegate = self;
    adressTabl.dataSource = self;
    adressTabl.bounces = NO;
    adressTabl.showsHorizontalScrollIndicator = NO;
    adressTabl.showsVerticalScrollIndicator = NO;
    
    adressTabl.tableFooterView = [UIView new];
    
    adressTabl.layer.borderColor = [MYGRAYCOLOR CGColor];
    adressTabl.layer.borderWidth = 1;
    adressTabl.layer.cornerRadius = 5;
    adressTabl.clipsToBounds = YES;
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]){
        
        [adressTabl setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([adressTabl respondsToSelector:@selector(setLayoutMargins:)])
    {
        
        [adressTabl setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

+ (YYBaseTableView *)tableView {
    
    static YYBaseTableView *table = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (!table) {
            
            table = [[YYBaseTableView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 44*6)];
           
        }
        
    });
    return table;

}

#pragma mark - downView
- (void)downView {
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    saveBtn.frame = CGRectMake(10, adressTabl.height+adressTabl.origin.y + 20,adressTabl.width, 44);
    [self.view addSubview:saveBtn];
    
    [saveBtn setTitle:@"保  存" forState:UIControlStateNormal];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    saveBtn.backgroundColor = [UIColor redColor];
    saveBtn.layer.cornerRadius = 5;
    saveBtn.clipsToBounds = YES;
    
    [saveBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
   
}

- (void)saveAction:(UIButton *)sender {

    //传递的参数
    if (_dataDic.count < 5) {
        
        [self showHaveAlert:@"请完善收货地址"];
        
    }else {
        
        //手机号
        if (![YYAdressViewController checkTelNumber:_dataDic[PHONE]]) {
            [self showHaveAlert:@"请填写正确的手机号"];
            return;
        }
        
        //邮编
        if (![YYAdressViewController checkTelNumber:_dataDic[POSTCODE]]) {
            [self showHaveAlert:@"请填写正确的邮政编码"];
            return;
        }
   
        NSString *url = nil;
        if (!_model) {
            
            //添加
           url = [NSString stringWithFormat:@"%@%@",BASE_URL,@"/app/memberAddress_save"];
        }else {
            
            //修改
            url = [NSString stringWithFormat:@"%@%@",BASE_URL,@"/app/memberAddress_update"];
        }
        
        [YYNetWorking postwithURL:url withParam:_dataDic withHeader:@"data" success:^(id responsObjc) {
            
            if (responsObjc[@"msg"]) {
                
                [self showHaveAlert:responsObjc[@"msg"]];
            }else {
                
                //提示信息
                [self showHaveAlert:@"保存成功"];
            }
        }];
      
    }
}

- (void)showHaveAlert:(NSString *)title {

//已有收获地址----完善收获地址
    NSString *makeSureButtonTitle = @"确定";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *makeSureAction = [UIAlertAction actionWithTitle:makeSureButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        
    }];
    
    [alertController addAction:makeSureAction];
    
    
    [self presentViewController:alertController animated:YES completion:nil];

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 3) {
        
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _addBtn.frame = CGRectMake(10, 0, cell.width - 20, cell.height);
        [cell.contentView addSubview:_addBtn];
        
        [_addBtn setTitle:data[indexPath.row] forState:UIControlStateNormal];
        _addBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;

        _addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_addBtn addTarget:self action:@selector(adressArea:) forControlEvents:UIControlEventTouchUpInside];
        
        if (_model) {
            
            [_addBtn setTitle:[NSString stringWithFormat:@"%@ %@ %@",_model.province,_model.city,_model.county] forState:UIControlStateNormal];
            
        }else {
            
            _addBtn.titleLabel.text = data[indexPath.row];
        }

        
    }else if (indexPath.row == 5) {
        
        UIView *bgView = [[UIView alloc] initWithFrame:cell.bounds];
        
        [cell.contentView addSubview:bgView];
        
        UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, bgView.height)];
        [bgView addSubview:text];
        text.text = data[indexPath.row];

        //选择默认
        UIButton *check = [UIButton buttonWithType:UIButtonTypeCustom];
        check.frame =CGRectMake(0,0, 100, 30);
        check.center = CGPointMake(bgView.width - 70, bgView.centerY);
        [bgView addSubview:check];

        [check setImage:[UIImage imageNamed:@"check_normal"] forState:UIControlStateNormal];
        [check setImage:[UIImage imageNamed:@"check_select"] forState:UIControlStateSelected];
        [check addTarget:self action:@selector(defaultAdress:) forControlEvents:UIControlEventTouchUpInside];
        
        if (_dataDic[DEFAULT_ADRESS]) {
            
            check.selected = [_dataDic[DEFAULT_ADRESS] boolValue];
        }else {
            
            [_dataDic setObject:@"NO" forKey:DEFAULT_ADRESS];
        }

    }else {
        
        UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, cell.width - 20, cell.height)];
        
        [cell.contentView addSubview:field];
        
        field.placeholder = data[indexPath.row];
        
        field.delegate = self;
        
        field.tag = 4100 + indexPath.row;
        
        if (_model) {
            
            switch (indexPath.row) {
                case 0:
                    field.text = _model.userName;
                    break;
                case 1:
                    field.text = _model.telephone;
                    break;
                case 2:
                    field.text = _model.postcode;
                    break;
                case 4:
                    field.text = _model.address;
                    break;
                    
                default:
                    break;
            }
        }else {
            
            field.text = nil;
        }
  
    }
    
    return cell;
    
}

#pragma mark - 选择默认区域  默认地址
- (void)adressArea:(UIButton *)sender {
    
    [_textField resignFirstResponder];
    YYAreaViewController *vc = [[YYAreaViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

//设为默认地址的buttonAction
- (void)defaultAdress:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected == YES) {
        
        [_dataDic setObject:@"ture" forKey:DEFAULT_ADRESS];
    }else {
        
        [_dataDic setObject:@"false" forKey:DEFAULT_ADRESS];
    }

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 6) {
        
        return 20;
    }
    
    return 44;
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

#pragma mark - textfieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    _textField = textField;
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
 
    switch (textField.tag - 4100) {
        case 0:
           
            [_dataDic setObject:textField.text forKey:NAME_ADRESS];
          
            break;
        case 1:
            
            [_dataDic setObject:textField.text forKey:PHONE];
            
            break;
        case 2:
            
            [_dataDic setObject:textField.text forKey:POSTCODE];
            
            break;
        case 4:
            
            [_dataDic setObject:textField.text forKey:DETAIL_ADDRESS];
            break;

        default:
            break;
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
  
    return YES;
    
}



//手机号
+ (BOOL)checkTelNumber:(NSString *)telNumber
{
    NSString *pattern = @"^1+[3578]+\\d{9}";
    //    NSString *pattern = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}

//邮编
+ (BOOL)checkPostCode:(NSString *)postCode {
    
    NSString *pattern = @"[1-9]d{5}(?!d)";
    //    NSString *pattern = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:postCode];
    return isMatch;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
