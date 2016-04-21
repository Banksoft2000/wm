//
//  YYDiscoveryController.m
//  xinchengShop
//
//  Created by 周荣硕 on 16/3/22.
//  Copyright © 2016年 com.banksoft. All rights reserved.
//



#import "YYDiscoveryController.h"
#import "YYXCViewController.h"
#import "YYleftTableCell.h"
#import "YYrightCollectionViewCell.h"
#import "YYNetWorking.h"

#import "YYProductNetTool.h"
#import "YYProductTypeNetTool.h"

//表格的宽度
static const CGFloat tableWidthSize=80;
//行的高度
static const CGFloat tableCellHeight=44;
//表格跟集合列表的空隙
static const CGFloat leftMargin =10;

@interface YYDiscoveryController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>


@end

@implementation YYDiscoveryController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.disCoverDatas=[[NSMutableArray alloc]init];
    

//    self.arrM=[[NSMutableArray alloc]init];

    //初始化
    self.view.backgroundColor = [UIColor whiteColor];

    



    self.rightdataList = [[NSMutableArray alloc]init];
    //允许右边保持滚动位置
    self.isReturnLastOffset = YES;
    self.isKeepScrollState = YES;
    
    //初始化界面布局
    [self initFrame];
    
    
    //初始化左边分类的数据
    [self initLeft];
    
    
}
//初始化界面布局
-(void)initFrame{

    //创建列表
    if (!_myTableView) {
        
        _myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, tableWidthSize, SCREEN_HEIGHT-60) style:UITableViewStylePlain];
        _myTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.tableFooterView=[[UIView alloc]init];

        [self.view addSubview:_myTableView];
    }
    
    
    //创建集合表格
    if (!_myCollectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        self.myCollectionView=  [[UICollectionView alloc] initWithFrame:CGRectMake(tableWidthSize+leftMargin,10, SCREEN_WIDTH-tableWidthSize-2*leftMargin, SCREEN_HEIGHT-120) collectionViewLayout:layout];
        self.myCollectionView.backgroundColor = [UIColor whiteColor];
        self.myCollectionView.showsHorizontalScrollIndicator=NO;
        self.myCollectionView.showsVerticalScrollIndicator=NO;
        
        [self.myCollectionView registerClass:[YYrightCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass( [YYrightCollectionViewCell class])];
        
        self.myCollectionView.dataSource = self;
        self.myCollectionView.delegate = self;
        
        
        [self.view addSubview:self.myCollectionView];
        
    }
    
}

///  初始化一级列表的数据
-(void)initLeft{

    
    NSString *url = [ NSString stringWithFormat:@"%@/app/productTypeList_list?grade=01",BASE_URL];
    



    
    [YYNetWorking homeHeaderWithURL:url :^(id responsObjc) {



        
        
        NSDictionary *data = responsObjc[@"data"];
        
        NSArray *xdata = data[@"list"];
        for (NSDictionary *dic in xdata) {
            
            YYProductType *model = [[YYProductType alloc] initWithDictionary:dic];
            //把分类数据存储到沙盒
            [YYProductTypeNetTool saveProductType:model];

            
            [self.disCoverDatas addObject:model];
            

 

        }
        

        [_myTableView reloadData];
        
        

        [_myTableView reloadData];


    }];

    



}



#pragma mark UITableViewDataSource, UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{


    return _disCoverDatas.count;

    



    
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    YYProductType *productType = _disCoverDatas[indexPath.section];
    static NSString *MyIdentifier = @"MyIdentifier";
    
    
    YYleftTableCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    
    if (cell==nil) {
        cell=[[YYleftTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
 
    
    cell.curLeftTagModel = productType;
    
    //当前选中为空的时候设置第一个值
    if (self.curSelectModel==nil) {
    
        self.curSelectModel=[self.disCoverDatas objectAtIndex:0];
        [self predicateDataSoure];

    }
    cell.hasBeenSelected = (cell.curLeftTagModel == self.curSelectModel);
    
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return  tableCellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.curSelectModel=[_disCoverDatas objectAtIndex:indexPath.section];
    [self.myTableView reloadData];
    [self predicateDataSoure];
    [_myCollectionView reloadData];
    
    
    //处理点击在滚动置顶的位置
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    self.isReturnLastOffset = NO;
    
    if (self.isKeepScrollState) {
        [self.myCollectionView scrollRectToVisible:CGRectMake(0, 0, self.myCollectionView.frame.size.width, self.myCollectionView.frame.size.height) animated:YES];
    }
    else{
    
         [self.myCollectionView scrollRectToVisible:CGRectMake(0, 0, self.myCollectionView.frame.size.width, self.myCollectionView.frame.size.height) animated:NO];
    }
    
    
}


///  加载右侧产品的列表
-(void) predicateDataSoure{

    NSString *url = [ NSString stringWithFormat:@"http://xinchengguangchang.com/app/productTypeList_list?grade=02&no=%@",self.curSelectModel.no];
    
    _rightdataList = [[NSMutableArray alloc] init];
    
    [YYNetWorking homeHeaderWithURL:url :^(id responsObjc) {
        NSDictionary *data = responsObjc[@"data"];
        
        NSArray *xdata = data[@"list"];
        for (NSDictionary *dic in xdata) {
            
            
            YYProduct *model = [[YYProduct alloc] initWithDictionary:dic];
            //保存产品数据
            [YYProductNetTool saveProduct:model];
            
            [_rightdataList addObject:model];
        }
        [_myCollectionView reloadData];
        
    }];
}


#pragma mark UICollectionViewDataSource, UICollectionViewDelegate


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return _rightdataList.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{


  YYrightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YYrightCollectionViewCell class]) forIndexPath:indexPath];
   
    cell.curNoHeadRightModel = _rightdataList[indexPath.row];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [YYrightCollectionViewCell ccellSize];
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //要跳转到别的控制器么
    YYProduct  *product=_rightdataList[indexPath.row];
    
    
    //跳转到产品详情控制器
    YYXCViewController *XQVc=[[YYXCViewController alloc]init];
    
    
    XQVc.navigationItem.title  =product.name;
    
    [self.navigationController pushViewController:XQVc animated:YES];
    
    
}



#pragma mark---记录滑动的坐标(把右边滚动的Y值记录在列表的一个属性中)

//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    if ([scrollView isEqual:self.myCollectionView]) {
//        self.isReturnLastOffset=YES;
//    }
//}
//
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if ([scrollView isEqual:self.myCollectionView]) {
//        //        leftTagModel * item=self.dataList[self.selectIndex];
//        //        item.offsetScorller=scrollView.contentOffset.y;
//        //        self.isReturnLastOffset=NO;
//    }
//    
//}
//
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    if ([scrollView isEqual:self.myCollectionView]) {
//        //        leftTagModel * item=self.dataList[self.selectIndex];
//        //        item.offsetScorller=scrollView.contentOffset.y;
//        //        self.isReturnLastOffset=NO;
//        
//    }
//    
//}
//
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if ([scrollView isEqual:self.myCollectionView] && self.isReturnLastOffset) {
//////                 * item=self.dataList[self.selectIndex];
//        [_myTableView   setContentOffset:CGPointMake(0, 0)];
//    }
//}
//
//

-(void)loadData:(NSMutableArray *)datas{

    _disCoverDatas = datas;
    _curSelectModel = datas[0];
    [_myTableView reloadData];
    [_myCollectionView reloadData];

}


//防止显示的cell 格式不太规范
-(void)viewDidLayoutSubviews{

    if ([_myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_myTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_myTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_myTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
}

//显示tableview的下划线长度足够长
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    //修改表格行默认分隔线存空隙的问题
    //    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
    //        cell.layoutMargins=UIEdgeInsetsZero;
    //    }
    //    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
    //        cell.separatorInset=UIEdgeInsetsZero;
    //    }
    
}
@end
