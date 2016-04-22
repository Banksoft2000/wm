//
//  YYMyOrderCell.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/4/8.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYMyOrderCell.h"
#import "YYMyOrderlist.h"
#import "YYMyOrderDetail.h"
#import "YYNetWorking.h"
#import <MBProgressHUD.h>

@interface YYMyOrderCell ()<UIAlertViewDelegate>

@property (nonatomic, strong) MBProgressHUD *progress;
@end


@implementation YYMyOrderCell

- (void)awakeFromNib {

    self.clickView.backgroundColor=[UIColor colorWithRed:245.0/255 green:245.0/255 blue:245.0/255 alpha:1.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 203.0/255, 203.0/255, 203.0/255, 1 });
    //设置边框的颜色和宽度
    [self.prolong.layer setBorderWidth:1];
    [self.prolong.layer setBorderColor:colorref];

    self.confiBtn.layer.borderWidth=1;
    self.confiBtn.layer.borderColor=colorref;
    self.checkAdd.layer.borderWidth=1;
    self.checkAdd.layer.borderColor=colorref;
    
    
//    self.titleView.userActivity=NO;
    [self.titleView setUserInteractionEnabled:NO];
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


    
}

//把订单数据赋值给cell
-(void)setOrderModel:(YYMyOrderlist *)orderModel{
    _orderModel=orderModel;
    
    self.shopName.text=orderModel.shopName;
//    self.status.text=orderModel.status;
    self.status.textColor=[UIColor lightGrayColor];
    
    
    /*CREATE("订单创建"),//订单已创建
     PAY("订单已支付"),//订单已支付
     DISPATCH("已发货"),//订单已发货
     SUCCESS("订单完成"),//订单已完成
     
     OVER("订单取消或关闭"),//订单已关闭
     REPEALING("订单退货中"),//订单退货中
     REPEAL_OVER("订单退货结束"); //退货结束
     */
    if ([orderModel.status isEqualToString:@"CREATE"]) {
        self.status.text=@"待付款";
        self.prolong.hidden=YES;
        [self.confiBtn setTitle:@"付款" forState:UIControlStateNormal];
        [self.checkAdd setTitle:@"取消订单" forState:UIControlStateNormal];
        
        //给按钮添加事件
        [self.confiBtn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
        [self.checkAdd addTarget:self action:@selector(cancelOrderList:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if ([orderModel.status isEqualToString:@"PAY"]){
        self.status.text=@"订单待发货";
        self.prolong.hidden=YES;
        self.checkAdd.hidden=YES;
        [self.confiBtn setTitle:@"提醒发货" forState:UIControlStateNormal];
        
        [self.confiBtn addTarget:self action:@selector(reminderDelivery:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if ([orderModel.status isEqualToString:@"DISPATCH"]){
    
        self.status.text=@"订单已发货";
         [self.prolong addTarget:self action:@selector(prolong:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.confiBtn addTarget:self action:@selector(configRece:) forControlEvents:UIControlEventTouchUpInside];
        
    }else if ([orderModel.status isEqualToString:@"SUCCESS"]){
        self.status.text=@"交易成功";
        self.prolong.hidden=YES;
        self.checkAdd.hidden=YES;
//        [self.checkAdd  setTitle:@"删除订单" forState:UIControlStateNormal];
//        [self.checkAdd addTarget:self action:@selector(deleteOrder:) forControlEvents:UIControlEventTouchUpInside];
        [self.confiBtn  setTitle:@"评价" forState:UIControlStateNormal];
        [self.confiBtn addTarget:self action:@selector(comment:) forControlEvents:UIControlEventTouchUpInside];
    
    }else if ([orderModel.status isEqualToString:@"REPEALING"]){
        
        self.status.text=@"订单退货中";
        self.prolong.hidden=YES;
        [self.checkAdd setTitle:@"查看物流 " forState:UIControlStateNormal];
        [self.confiBtn setTitle:@"确认" forState:UIControlStateNormal];
    
    }else if ([orderModel.status isEqualToString:@"REPEAL_OVER"]){
        
        self.status.text=@"退货结束";
        self.prolong.hidden=YES;
        [self.checkAdd setTitle:@"删除订单" forState:UIControlStateNormal];
        [self.confiBtn setTitle:@"确认" forState:UIControlStateNormal];
        
    }else if ([orderModel.status isEqualToString:@"OVER"]){
    
        self.status.text=@"订单已关闭";
        self.prolong.hidden=YES;
        self.checkAdd.hidden=YES;

        [self.confiBtn setTitle:@"订单关闭" forState:UIControlStateNormal];
        
        
        
    }
    
//    self.totalMoney.text=[NSString stringWithFormat:@"%ld",(long)orderModel.totalMoney];
    self.totalMoney.text=@"35";
    
}

//付款
-(void)pay:(UIButton *)sender{

    NSLog(@"我要去付款了");
}

//取消未付款订单
-(void)cancelOrderList:(UIButton *)sender{

    NSString *url=[NSString stringWithFormat:@"%@/app/memberOrder_cancelOrder?orderId=%@",BASE_URL,self.orderDetail.orderId];
    NSLog(@"%@",url);
    
    [YYNetWorking homeHeaderWithURL:url :^(id responsObjc) {
        
        NSString *success=[NSString stringWithFormat:@"%@",responsObjc[@"SUCCESS"]];
        
        if ([success isEqualToString:[NSString stringWithFormat:@"1"]] ) {
            
            _progress.labelText=@"未付款订单取消成功";
            
        }else{
            
            _progress.labelText=@"未付款订单取消失败";
        }
        
        [_progress hide:YES afterDelay:1.0];

    }];
    
}


//延长收货
-(void)prolong:(UIButton *)sender{
    NSLog(@"---点击了延长收货");
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"确认延长收货时间?" message:@"每笔订单只能延长一次哦" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert show];
}
//警示框的代理方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    switch (buttonIndex) {
        case 0:
            NSLog(@"我点击了取消");
            break;
        case 1:
            NSLog(@"我惦记了确认");
            
            
            break;
        default:
            break;
    }
}

//确认收货订单进入待评价列表
-(void)configRece:(UIButton *)sender{

    NSLog(@"---orderId=%@",self.orderDetail.orderId);
    _progress=[MBProgressHUD showHUDAddedTo:self animated:YES];
    NSString *url=[NSString stringWithFormat:@"%@/app/memberOrder_overOrder?orderId=%@",BASE_URL,self.orderDetail.orderId];
    
    [YYNetWorking homeHeaderWithURL:url :^(id responsObjc) {
       
        NSString *success=[NSString stringWithFormat:@"%@",responsObjc[@"SUCCESS"]];
        
        if ([success isEqualToString:[NSString stringWithFormat:@"1"]] ) {
            
            _progress.labelText=@"确认成功";
            
        }else{
        
            _progress.labelText=@"确认失败";
        }
        
        [_progress hide:YES afterDelay:1.0];
    }];
    
    
}

//提醒发货
-(void)reminderDelivery:(UIButton *)sender{

    _progress=[MBProgressHUD showHUDAddedTo:self animated:YES];
    
    _progress.labelText=@"提醒卖家成功";
    
    [_progress hide:YES afterDelay:1];
    
}

//删除完成后的订单
//-(void)deleteOrder:(UIButton *)sender{
//
//    NSLog(@"点击完成后删除订单");
//    
//}

//买家首次评论订单

-(void)comment:(UIButton *)sender{

    NSString *url=[NSString stringWithFormat:@"%@/app/memberOrder_assess",BASE_URL];
    
    [YYNetWorking homeHeaderWithURL:url :^(id responsObjc) {
        
        NSString *success=[NSString stringWithFormat:@"%@",responsObjc[@"SUCCESS"]];
        
        if ([success isEqualToString:[NSString stringWithFormat:@"1"]] ) {
            
            _progress.labelText=@"确认成功";
            
        }else{
            
            _progress.labelText=@"确认失败";
        }
        
        [_progress hide:YES afterDelay:1.0];
    }];

    
}


//把订单详情的数据赋值给cell

-(void)setOrderDetail:(YYMyOrderDetail *)orderDetail{

    _orderDetail=orderDetail;
    self.productName.text=orderDetail.productName;
    
    //把有|的字符串截取出来
    NSString *a=[NSString stringWithFormat:@"%@",orderDetail.imageFile];
    NSArray *b=[a componentsSeparatedByString:@"|"];
    NSString *a1=[b objectAtIndex:0];
    
    [self.imageFile sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,a1]] placeholderImage:[UIImage imageNamed:@"default_picture_icon"]];
    
//    self.price.text=[NSString stringWithFormat:@"%ld",(long)orderDetail.price];
    self.price.text=@"35";
//    NSLog(@"%@",self.price.text);
//    self.num.text=[NSString stringWithFormat:@"%ld",(long)orderDetail.num];
    self.num.text=@"1";
}

@end
