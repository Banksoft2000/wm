
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

#import "YYMember.h"
#import "YYMemberTool.h"
#import "YYShop.h"
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView.showsVerticalScrollIndicator=NO;
    

    
    self.memberIcon.layer.masksToBounds=YES;
    self.memberIcon.layer.cornerRadius=25;
    
//    self.tableView.bounces=NO;
    
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
    if (_member!=nil) {
        
        NSString *imageFile = [NSString stringWithFormat:@"http://xinchengguangchang.com%@",_member.imageFile];
        [_memberIcon sd_setImageWithURL:[NSURL URLWithString:imageFile] placeholderImage:[UIImage imageNamed:@"default_picture_icon"]];
        _memberName.titleLabel.text=_member.account;
//        _memberName.userInteractionEnabled=NO;

        self.balance.text=[NSString stringWithFormat:@"%f",_member.balance];

        self.memberPoint.text=[NSString stringWithFormat:@"%ld",(long)_member.memberPoint];
        
        
        
    }
    
    _shop=[YYMemberTool shop];
    
    if (_shop == NULL) {
        
        [self.tableView beginUpdates];
        
        
//        self.tableView insertRowsAtIndexPaths:<#(nonnull NSArray<NSIndexPath *> *)#> withRowAnimation:NO]
        
        [self.tableView endUpdates];
    }
    
    
}


//-()

//#pragma mark - Table view data source

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
        
        
    }else if (indexPath.section==1){
        
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
                                   
            default:
                break;
        }
        
        
        
    
    }
    
}


}
@end


