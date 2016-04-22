//
//  YYCarouseViewController.m
//  xinchengShop
//
//  Created by harry_robin on 16/3/29.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//

#import "YYCarouseViewController.h"

@interface YYCarouseViewController ()
{
    
    UIWebView *_web;
}

@end

@implementation YYCarouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    _web = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:_web];
}

- (void)setUrl:(NSString *)url {
    
    
    _url = url;
    

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    
    [_web loadRequest:request];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
