//
//  YYDetailDownView.h
//  xinchengShop
//
//  Created by harry_robin on 16/4/1.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYDetailDownView : UIView

@property (copy, nonatomic) NSString *productId;
@property (copy, nonatomic) NSString *memberId;


 //立即购买
@property (strong, nonatomic) IBOutlet UIButton *buy;
//加入购物车
@property (strong, nonatomic) IBOutlet UIButton *addShopping;

@property (strong, nonatomic) IBOutlet UIImageView *likeImg;

@property (strong, nonatomic) IBOutlet UIButton *likeBtn;

//店铺
- (IBAction)store:(UIButton *)sender;

//购物车
- (IBAction)shoppingCart:(UIButton *)sender;

- (IBAction)like:(UIButton *)sender;

@end
