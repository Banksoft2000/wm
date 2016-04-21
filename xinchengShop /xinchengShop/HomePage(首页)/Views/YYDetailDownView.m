//
//  YYDetailDownView.m
//  xinchengShop
//
//  Created by harry_robin on 16/4/1.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYDetailDownView.h"

@implementation YYDetailDownView

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    _buy.backgroundColor = UIBUTTON_ORANGE;
    _addShopping.backgroundColor = PRICE_TEXT_RED;
    
    

    
    
}

- (void)setProductId:(NSString *)productId {
    
    _productId = productId;
    
    //判断是否收藏
    NSDictionary *dic = @{@"productId":_productId,MEMBERID:MEMBERID_VALUE};
    NSString *checkUrl = [NSString stringWithFormat:@"%@%@",BASE_URL,@"/app/productCollection_check"];
    [YYNetWorking postwithURL:checkUrl withParam:dic withHeader:nil success:^(id responsObjc) {
        
        if (responsObjc[@"data"]) {
            
            _likeImg.image = [UIImage imageNamed:@"c_shop_level1"];
            _likeBtn.selected = NO;
        }else {
            _likeImg.image = [UIImage imageNamed:@"c_shop_level0"];
            _likeBtn.selected = YES;
            
        }
    }];
}

- (IBAction)store:(UIButton *)sender {
    
    
}


- (IBAction)shoppingCart:(UIButton *)sender {
    
    
}

//喜欢
- (IBAction)like:(UIButton *)sender {
 
    sender.selected = !sender.selected;
    
    NSDictionary *dic = @{@"productId":_productId,MEMBERID:MEMBERID_VALUE};
   
    NSString *url = nil;
    if (sender.selected == YES) {
        
        _likeImg.image = [UIImage imageNamed:@"c_shop_level0"];
        //取消收藏
       url = [NSString stringWithFormat:@"%@%@",BASE_URL,@"/app/productCollection_frontDelete"];

    }else {
        
         _likeImg.image = [UIImage imageNamed:@"c_shop_level1"];
        //收藏
        url = [NSString stringWithFormat:@"%@%@",BASE_URL,@"/app/productCollection_save"];
       
    }

    [YYNetWorking postwithURL:url withParam:dic withHeader:nil success:^(id responsObjc) {
        
        if (responsObjc[@"msg"]) {
            
            [self showAlert:responsObjc[@"msg"]];
        }
        
    }];
    
    
}

- (void)showAlert:(NSString *)title {
    
    NSString *sure = @"确定";
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *act = [UIAlertAction actionWithTitle:sure style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    
    [alert addAction:act];
    
    [self.viewController presentViewController:alert animated:YES completion:nil];
    
}


@end
