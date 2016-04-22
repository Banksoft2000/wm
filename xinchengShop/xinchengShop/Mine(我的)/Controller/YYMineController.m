
//
//  YYMineController.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/22.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYMineController.h"
#import "YYLoginController.h"
#import "YYMySelfInfoViewController.h"
#import "YYMyOrderListViewController.h"
#import "YYFocusProductAndShopViewController.h"
#import "YYMyPocketViewController.h"
#import "YYScoreOrderViewController.h"
#import "YYMyDiscussViewController.h"

#import "YYWantOpenController.h"
#import "YYProductMangerViewController.h"
#import "YYSellerOrderListViewController.h"
#import "YYConsumeConfigViewController.h"

#import "YYScoreShopController.h"
#import "YYCheckNewController.h"
#import "YYAboutViewController.h"

#import "YYMember.h"
#import "YYMemberTool.h"
#import "YYShop.h"

//#import "YYaddMineCell.h"
@interface YYMineController ()

@property (weak, nonatomic) IBOutlet UIImageView *memberIcon;
@property (weak, nonatomic) IBOutlet UIButton *memberName;
@property (weak, nonatomic) IBOutlet UILabel *balance;
@property (weak, nonatomic) IBOutlet UILabel *memberPoint;

@property (nonatomic, strong) YYShop *shop;

@end

@implementation YYMineController

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]){
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }

   
    [self.tableView reloadData];
    
    
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.memberIcon.layer.masksToBounds=YES;
    self.memberIcon.layer.cornerRadius=25;
    self.memberName.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    self.tableView.bounces=NO;
    
    

    
}
- (IBAction)focusShop:(UIButton *)sender {
    
    NSLog(@"点击了店铺");
    
    [self clickShopAndProduct];
    
   }
- (IBAction)foucsProduct:(id)sender {
    
    NSLog(@"点击了产品");
    
    [self clickShopAndProduct];
}


//登录或者是关注产品和店铺信息

-(void)clickShopAndProduct{

    if (_member==nil) {
        UIStoryboard *login = [UIStoryboard storyboardWithName:@"YYLoginStoryboard" bundle:nil];
        
        YYLoginController *loginVc = [login instantiateViewControllerWithIdentifier:@"YYLogin"];
        
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVc];
        [self presentViewController:navigation animated:YES completion:nil];
    }else{
        
        YYFocusProductAndShopViewController *focus=[[YYFocusProductAndShopViewController alloc]init];
        
        [self.navigationController pushViewController:focus animated:YES];
        
        
    }

}
- (IBAction)toLogin:(UIButton *)sender {
    
    NSLog(@"我要登录");
    
    if (_member==nil) {
        
        UIStoryboard *login = [UIStoryboard storyboardWithName:@"YYLoginStoryboard" bundle:nil];
        
        YYLoginController *loginVc = [login instantiateViewControllerWithIdentifier:@"YYLogin"];
        
        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVc];
        
        [self presentViewController:navigation animated:YES completion:nil];
    
    }else{
    
        UIStoryboard *my=[UIStoryboard storyboardWithName:@"YYMyselfInfo" bundle:nil];
        
        YYMySelfInfoViewController *mySelfInfo=[my instantiateViewControllerWithIdentifier:@"YYMyself" ];
        
        [self.navigationController pushViewController:mySelfInfo animated:YES];
        
        
    }
    
}

//监听登录成功后返回
-(void)awakeFromNib{

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userRefreshHandler) name:@"userRefresh" object:nil];
}

//重新显示到我的界面上
-(void)userRefreshHandler{

    _member=[YYMemberTool member];
    [_memberIcon sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"default_picture_icon"]];
    self.balance.text=@"0";
    self.memberPoint.text=@"0";
    if (_member!=nil) {
        
        NSString *imageFile = [NSString stringWithFormat:@"http://xinchengguangchang.com%@",_member.imageFile];
        [_memberIcon sd_setImageWithURL:[NSURL URLWithString:imageFile] placeholderImage:[UIImage imageNamed:@"default_picture_icon"]];
        _memberName.titleLabel.text=_member.account;

        self.balance.text=[NSString stringWithFormat:@"%f",_member.balance];

        self.memberPoint.text=[NSString stringWithFormat:@"%ld",(long)_member.memberPoint];
        
    }
    
    
    
    
}




//#pragma mark - Table view data source


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    //把 shop取出来
    _shop=[YYMemberTool shop];
    
    NSString *str=[NSString stringWithFormat:@"%@",_shop.status];
    
//    NSLog(@"%@",str);
    if (section==0) {
        
        return 2;
    }else if (section==1){
        
        if (_member==nil) {
            
            return 3;
        }
        if (_shop == nil || [str isEqualToString:[NSString stringWithFormat:@"0"]]){
        
            return 4;
        }
        return 3;
    }else if (section==2){
    
        if (_member==nil) {
            return 0;
        }else if (_shop == nil || [str isEqualToString:[NSString stringWithFormat:@"1"]]){
        
            return 3;
        }
    
       
    }else if (section==3){
    
    
        return 3;
    }
    return 0;
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
    if (indexPath.section==0) {
        switch (indexPath.row) {
            case 0:
                if (_member==nil) {
                    
                    UIStoryboard *login = [UIStoryboard storyboardWithName:@"YYLoginStoryboard" bundle:nil];
                    
                    YYLoginController *loginVc = [login instantiateViewControllerWithIdentifier:@"YYLogin"];
                    
                    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVc];
                    
                    [self presentViewController:navigation animated:YES completion:nil];
                }else{
                
                    
                    YYMyPocketViewController *myPocket =[[YYMyPocketViewController alloc]init];
                    
                    
                    [self.navigationController pushViewController:myPocket animated:YES];
                    
                    
                }
                break;
                
            default:
                break;
        }
        
        
    }
    else if (indexPath.section==1){
        
        switch (indexPath.row) {
            case 0:
                if (_member==nil) {
                    UIStoryboard *login = [UIStoryboard storyboardWithName:@"YYLoginStoryboard" bundle:nil];
                    
                    YYLoginController *loginVc = [login instantiateViewControllerWithIdentifier:@"YYLogin"];
                    
                    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVc];
                    [self presentViewController:navigation animated:YES completion:nil];
                }else{
                
                    YYMyOrderListViewController *myorderl=[[YYMyOrderListViewController alloc]init];
                    
                    [self.navigationController pushViewController:myorderl animated:YES];
                    
                    
                }
                break;
                
            case 1:
                
                if (_member==nil) {
                    UIStoryboard *login = [UIStoryboard storyboardWithName:@"YYLoginStoryboard" bundle:nil];
                    
                    YYLoginController *loginVc = [login instantiateViewControllerWithIdentifier:@"YYLogin"];
                    
                    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVc];
                    [self presentViewController:navigation animated:YES completion:nil];
                }else{
                
                    YYScoreOrderViewController *scoreOrder=[[YYScoreOrderViewController alloc]init];
                    
                    
                    [self.navigationController pushViewController:scoreOrder animated:YES];
                    
                    
                }
                break;
                
            case 2:
                
                    if (_member==nil) {
                        UIStoryboard *login = [UIStoryboard storyboardWithName:@"YYLoginStoryboard" bundle:nil];
                        
                        YYLoginController *loginVc = [login instantiateViewControllerWithIdentifier:@"YYLogin"];
                        
                        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVc];
                        [self presentViewController:navigation animated:YES completion:nil];
                    }else{
                    
                        YYMyDiscussViewController *myDiscuss=[[YYMyDiscussViewController alloc]init];
                        
                        
                        [self.navigationController pushViewController:myDiscuss animated:YES];
                        
                        
                    }
                    break;
                    
            case 3:
                
                
                    NSLog(@"----我要开店");
                if (_member!=nil) {
                    YYWantOpenController *wantOpen=[[YYWantOpenController alloc]init];
                    
                    [self.navigationController pushViewController:wantOpen animated:YES];

                }
                
                    break;
                
            default:
                break;
        }
        
    }else if (indexPath.section==2){
    
        switch (indexPath.row) {
            case 0:
                NSLog(@"-----铲平管理");
                if (_member!=nil) {
                    YYProductMangerViewController *productMang=[[YYProductMangerViewController alloc]init];
                    
                    [self.navigationController pushViewController:productMang animated:YES];
                    
                }

                break;
            case 1:
                NSLog(@"-----卖家订单");
                if (_member!=nil) {
                    YYSellerOrderListViewController *sellOrder=[[YYSellerOrderListViewController alloc]init];
                    
                    [self.navigationController pushViewController:sellOrder animated:YES];
                    
                }

                break;
            case 2:
                NSLog(@"----消费验证");
                if (_member!=nil) {
                    YYConsumeConfigViewController *consume=[[YYConsumeConfigViewController alloc]init];
                    
                    [self.navigationController pushViewController:consume animated:YES];
                    
                }

                break;

   
            default:
                break;
        }
    }else if (indexPath.section==3){
        
        switch (indexPath.row) {
            case 0:
                NSLog(@"---积分商城");
                if (_member==nil) {
                    UIStoryboard *login = [UIStoryboard storyboardWithName:@"YYLoginStoryboard" bundle:nil];
                    
                    YYLoginController *loginVc = [login instantiateViewControllerWithIdentifier:@"YYLogin"];
                    
                    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVc];
                    [self presentViewController:navigation animated:YES completion:nil];
                }else{
                    
                    YYScoreShopController *scoreShop=[[YYScoreShopController alloc]init];
                    
                    
                    [self.navigationController pushViewController:scoreShop animated:YES];
                    
                    
                }

                
                
                break;
            case 1:
                NSLog(@"-----检查更新");
                if (_member==nil) {
                    UIStoryboard *login = [UIStoryboard storyboardWithName:@"YYLoginStoryboard" bundle:nil];
                    
                    YYLoginController *loginVc = [login instantiateViewControllerWithIdentifier:@"YYLogin"];
                    
                    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVc];
                    [self presentViewController:navigation animated:YES completion:nil];
                }else{
                    
                    YYCheckNewController *checkNew=[[YYCheckNewController alloc]init];
                    
                    
                    [self.navigationController pushViewController:checkNew animated:YES];
                    
                    
                }
                break;
            case 2:
                NSLog(@"-----关于");
                if (_member==nil) {
                    UIStoryboard *login = [UIStoryboard storyboardWithName:@"YYLoginStoryboard" bundle:nil];
                    
                    YYLoginController *loginVc = [login instantiateViewControllerWithIdentifier:@"YYLogin"];
                    
                    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:loginVc];
                    [self presentViewController:navigation animated:YES completion:nil];
                }else{
                    
                    YYAboutViewController *about=[[YYAboutViewController alloc]init];
                    
                    
                    [self.navigationController pushViewController:about animated:YES];
                    
                    
                }

                break;

            default:
                break;
        }
        
    
    }

}

//让tableview到头的方法
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
@end


