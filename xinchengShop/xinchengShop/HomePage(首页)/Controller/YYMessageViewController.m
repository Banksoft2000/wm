//
//  YYMessageViewController.m
//  xinchengShop
//
//  Created by harry_robin on 16/3/30.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYMessageViewController.h"
#import "YYNoticeModel.h"

@interface YYMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    YYBaseTableView *_tableView;
    
    NSMutableArray *_dataArr;
   
    UILabel *_time;
    UILabel *_text;
}

@end

@implementation YYMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"公告";
    self.view.backgroundColor = [UIColor colorWithPatternImage:DEFA_IMAGE];

    [self initTableView];
    [self initData];
}

#pragma mark - Data
- (void)initData {
    
    _dataArr = [[NSMutableArray alloc] init];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,@"/app/_article"];
    [YYNetWorking homeHeaderWithURL:url :^(id responsObjc) {
        
        NSDictionary *data = responsObjc[@"data"];
        NSArray *list = data[@"list"];
        
        for (NSDictionary *dic in list) {
            
            YYNoticeModel *model = [[YYNoticeModel alloc] initWithDictionary:dic];
            
            [_dataArr addObject:model];
        }
        [_tableView reloadData];
    }];
}

#pragma mark - TableView
- (void)initTableView {
    
    _tableView = [[YYBaseTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    
    _tableView.tableFooterView = [UIView new];
    
    _tableView.showsVerticalScrollIndicator = NO;
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
}

#pragma  mark - UITableViewDataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArr.count;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identy = @"noticeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identy];

    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identy];
        
        _time = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 34)];
        [cell.contentView addSubview:_time];
        
        [_time mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(cell.mas_right).offset(-10);
            make.top.equalTo(cell.mas_top).offset(10);
        }];
        
        _time.font = TEXT_FONT;
        _time.textColor = BG_GRAY;
        _time.textAlignment = NSTextAlignmentCenter;
        
        _text = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 130 - 10, 44)];
        [cell.contentView addSubview:_text];
        _text.font = TEXT_FONT;
    }
    
    if (_dataArr.count != 0) {
        
        YYNoticeModel *model = _dataArr[indexPath.row];
        _text.text = model.title;
        
        //时间转换  --- 后台的数据的第十位 和第十一之间加一个小数点
        NSMutableString *oldTime = [[NSMutableString alloc] initWithFormat:@"%@",model.modifyTime ];
        
        [oldTime insertString:@"." atIndex:10];

        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[oldTime integerValue]];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        
        NSString *newTime = [formatter stringFromDate:date];
        
        _time.text = newTime;
        
    }
    
    

    

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self pushAction:indexPath.row];
    
}

- (void)pushAction:(NSInteger)row {
    
    UIViewController *vc = [[UIViewController alloc] init];
    
    vc.title = @"详 情";
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];

    [vc.view addSubview:web];
    
    YYNoticeModel  *model = _dataArr[row];
    [web loadHTMLString:model.content baseURL:[NSURL URLWithString:BASE_URL]];
    
    web.scalesPageToFit = YES;

    [self.navigationController pushViewController:vc animated:YES];
 
}

@end
