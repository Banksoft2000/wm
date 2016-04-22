//
//  YYDetailTableView.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/1.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYDetailTableView.h"
#import "YYDetailZeroView.h"
#import "YYDetailOneView.h"
#import "YYDetailHeadView.h"
//#import "YYHeaderView.h"
@implementation YYDetailTableView
{
    
    YYDetailHeadView *_headView;
    UIWebView *_web;
    
    NSInteger _webHeight;                //webView的高度
    
}


- (void)initDetails {
    
    _web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    
       _web.scalesPageToFit = YES;
    
    _web.scrollView.scrollEnabled = NO;
    
     _web.delegate = self;

    _headView = [[YYDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    self.tableHeaderView = _headView;

}



-  (void)setDataArr:(NSArray *)dataArr {
    
    _dataArr = dataArr;

    [self reloadData];
    
    NSMutableDictionary *productDic = [[NSMutableDictionary alloc] init];
    
    YYDetailModel *model = _dataArr[0];
    
    [productDic setObject:model.shopName forKey:SHOP_NAME];
    [productDic setObject:model.shopId  forKey:SHOP_ID];
    [productDic setObject:model.shopImg forKey:SHOP_IMG];
    [productDic setObject:model.id      forKey:PRODUCT_ID];
    [productDic setObject:model.name    forKey:NAME];
    
    [productDic setObject:model.shopNo  forKey:SHOPNO];
    [productDic setObject:model.active  forKey:ACTIVE];
    [productDic setObject:model.areaNo  forKey:AREANO_SHOP];

    [self.detailDelegate productWithDic:productDic];
    
    //给轮播图传值
    //分割完之后最后会有一个占位字符，需要把占位字符移除
    NSMutableArray *imgs = (NSMutableArray *)[model.icon componentsSeparatedByString:@"|"];
    [imgs removeLastObject];
    
    _headView.headerArr = imgs;

}

- (void)setDescribe:(NSString *)describe {
    
    _describe = describe;
    [_web loadHTMLString:describe baseURL:[NSURL URLWithString:BASE_URL]];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {

        YYDetailZeroView *zeroCell = [[[NSBundle mainBundle] loadNibNamed:@"YYDetailZeroView" owner:nil options:nil] lastObject];
       
        if (_dataArr.count > 0) {
            
            zeroCell.model = _dataArr[0];
            
        }
        
        zeroCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return zeroCell;

    }else if (indexPath.section == 1) {
        
        
        YYDetailOneView *OneCell = [[[NSBundle mainBundle] loadNibNamed:@"YYDetailOneView" owner:nil options:nil] lastObject];

        if (_dataArr.count > 0) {
         
            OneCell.model =  _dataArr[0];
            
        }
        
        OneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return OneCell;

    }else {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

        [cell.contentView addSubview:_web];
 
        cell.backgroundColor = [UIColor redColor];
        return cell;
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    

    
    return YES;
}





- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    UIScrollView *webViewScroll = webView.subviews[0];//取到webView的Scrollview
    webView.frame = CGRectMake(webView.frame.origin.x, webView.frame.origin.y, webViewScroll.contentSize.width, webViewScroll.contentSize.height);
    
    [self reloadData];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    
    if (section == 0) {
        
        return 0;
    }else {
        
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    
    
    if (indexPath.section == 2) {
        
        return _web.height;
    }
        
        return 140;
   
}

@end
