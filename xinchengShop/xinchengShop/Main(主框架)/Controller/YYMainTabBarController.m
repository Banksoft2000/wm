//
//  YYMainTabBarController.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/22.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYMainTabBarController.h"
#import "YYHomePageController.h"
#import "YYDiscoveryController.h"
#import "YYShoppingController.h"
#import "YYMineController.h"
#import "YYNavViewController.h"

#import "YYMIne2Controller.h"




@interface YYMainTabBarController ()

@end

@implementation YYMainTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];

    // 1. 加载子控制器
    [self loadSubControllers];

    

}

// 封装一个创建TabBarController的子控制器的方法
- (void)loadSubControllers {
    // 加载5个storyboard文件中的导航控制器, 并且把这些导航控制器添加到self中
    // 1. 首页
    YYHomePageController *home = [[YYHomePageController alloc]init];
    [self addchildVc:home title:@"首页" image:@"TabBar1" selectImage:@"TabBar1Sel"];
    
    // 2. 发现
    YYDiscoveryController *discovery = [[YYDiscoveryController alloc]init];
    [self addchildVc:discovery title:@"分类" image:@"TabBar2" selectImage:@"TabBar2Sel"];
   // 3. 购物车
    YYShoppingController *shopping = [[YYShoppingController alloc]init];
    [self addchildVc:shopping title:@"购物车" image:@"TabBar3" selectImage:@"TabBar3Sel"];
    
    
    // 4. 我的
    UIStoryboard *mine = [UIStoryboard storyboardWithName:@"YYMine" bundle:nil];
    
     UITableViewController *mineVc = [mine instantiateViewControllerWithIdentifier:@"Mine"];
//    YYMIne2Controller *mineVc=[[YYMIne2Controller alloc]init];
    [self addchildVc:mineVc title:@"我的" image:@"TabBar4" selectImage:@"TabBar4Sel"];

}



//添加导航控制器的方法
-(void)addchildVc:(UIViewController *)childvc title:(NSString *)title image:(NSString*)image selectImage:(NSString *)selectImage{

    //设置文字和图片
    
    childvc.title = title;
    childvc.tabBarItem.image = [UIImage imageNamed:image];
    childvc.tabBarItem.selectedImage = [[UIImage imageNamed:selectImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置文字样式
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [childvc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSForegroundColorAttributeName]= [UIColor orangeColor];
    
    [childvc.tabBarItem setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
    
    
    YYNavViewController *nav = [[YYNavViewController alloc]initWithRootViewController:childvc];
    
    [self addChildViewController:nav];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
