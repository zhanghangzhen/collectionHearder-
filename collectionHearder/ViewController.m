//
//  ViewController.m
//  collectionHearder
//
//  Created by kans on 16/3/30.
//  Copyright © 2016年 HaiYn. All rights reserved.
//

#import "ViewController.h"
#import "ConstomCell.h"
#import "HeaderViewCollectionReusableView.h"
#import "checkView.h"
#import "wxhTitleButton.h"
#import "UIImage+WXH.h"
#import "MGroupCell.h"
#import "PictureAddCell.h"
#define IWTitleButtonDownTag 0
#define IWTitleButtonUpTag -1
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSArray * imageArray;
    NSArray * titleArray;
    
    NSInteger tag;
    NSInteger cellFlag;
    NSMutableArray *arrIma;
    HeaderViewCollectionReusableView *headerView;
    
}
@property (nonatomic,strong)UICollectionView * chooseCollectionView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrGroup;
@property (nonatomic,strong)wxhTitleButton *titleButton;
@end

@implementation ViewController



/**
 *  懒加载  chooseCollectionView
 */

-(UICollectionView *)chooseCollectionView{

    if (_chooseCollectionView == nil) {
        UICollectionViewFlowLayout * flowout = [[UICollectionViewFlowLayout alloc]init];
        _chooseCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) collectionViewLayout:flowout];
        flowout.minimumInteritemSpacing = 5;
        flowout.sectionInset = UIEdgeInsetsZero;
        flowout.minimumLineSpacing = 5;
        _chooseCollectionView.delegate=self;
        _chooseCollectionView.dataSource=self;
        _chooseCollectionView.backgroundColor=[UIColor whiteColor];
         [_chooseCollectionView registerNib:[UINib nibWithNibName:@"ConstomCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        
        [_chooseCollectionView registerClass:[HeaderViewCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"footcell"];
        
        [_chooseCollectionView registerClass:[PictureAddCell class] forCellWithReuseIdentifier:@"addItemCell"];
        [self.view addSubview:_chooseCollectionView];
    }
    return  _chooseCollectionView;
}


/*
-(void)setChooseCollectionView:(UICollectionView *)chooseCollectionView{
    if (_chooseCollectionView!=chooseCollectionView) {
        _chooseCollectionView=chooseCollectionView;
        _chooseCollectionView.delegate=self;
        _chooseCollectionView.dataSource=self;
        _chooseCollectionView.backgroundColor=[UIColor whiteColor];
        [_chooseCollectionView registerNib:[UINib nibWithNibName:@"ConstomCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
        
        [_chooseCollectionView registerClass:[HeaderViewCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"footcell"];
        
        [_chooseCollectionView registerClass:[PictureAddCell class] forCellWithReuseIdentifier:@"addItemCell"];
        [self.view addSubview:_chooseCollectionView];
    }
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    arrIma=[[NSMutableArray alloc]init];
    [self setData];
    [self setUI];
   // [self creatChooseCollection];
}


-(void)setData{
    
    tag = 0;
    imageArray = @[];
    [[MImaLibTool shareMImaLibTool] getAllGroupWithArrObj:^(NSArray *arrObj) {
        
        if (arrObj && arrObj.count > 0) {
            self.arrGroup = arrObj;
          //   arrIma = (NSMutableArray *)[[MImaLibTool shareMImaLibTool] getAllAssetsWithGroup:[self.arrGroup firstObject]];
            [arrIma addObjectsFromArray:(NSMutableArray *)[[MImaLibTool shareMImaLibTool] getAllAssetsWithGroup:[self.arrGroup firstObject]]];
            [arrIma insertObject:@"nihao" atIndex:0];
            
            //NSLog(@"arrIma%@",arrIma);
             [self.chooseCollectionView reloadData];
            
            //获取数据之后 默认选择第一张图片   但图片没有显示出来  你在看看为啥？？？？
            NSIndexPath *dex = [NSIndexPath indexPathForRow:1 inSection:0];
            [self collectionView:self.chooseCollectionView didSelectItemAtIndexPath:dex];
            ALAssetsGroup *froup = self.arrGroup[0];
            NSString * str = [NSString stringWithFormat:@"%@",[froup valueForProperty:ALAssetsGroupPropertyName]];
            [_titleButton setTitle:str forState:UIControlStateNormal];
             ALAsset *set=[[[MImaLibTool shareMImaLibTool] getAllAssetsWithGroup:self.arrGroup[0]]firstObject];
            [headerView getImaSizeWithAsset:set];
        }
    }];
}


-(void)setUI{
    // 中间按钮
    _titleButton = [wxhTitleButton titleButton];
    // 图标
    [_titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    // 文字
   // [_titleButton setTitle:@"哈哈哈哈" forState:UIControlStateNormal];
    // 位置和尺寸
    _titleButton.frame = CGRectMake(0, 0, 100, 40);
    
  
    _titleButton.tag = IWTitleButtonDownTag;
    [_titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = _titleButton;
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UICollectionViewFlowLayout * flowout = [[UICollectionViewFlowLayout alloc]init];
//    UICollectionView * collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowout];
//    flowout.minimumInteritemSpacing = 5;
//    flowout.sectionInset = UIEdgeInsetsZero;
//    flowout.minimumLineSpacing = 5;
//    
//    self.chooseCollectionView = collection;

    
}
//-(void)creatChooseCollection{
//    UICollectionViewFlowLayout * flowout = [[UICollectionViewFlowLayout alloc]init];
//    UICollectionView * collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:flowout];
//    flowout.minimumInteritemSpacing = 5;
//    flowout.sectionInset = UIEdgeInsetsZero;
//    flowout.minimumLineSpacing = 5;
//    
//    self.chooseCollectionView = collection;
//    
//    
//    _chooseCollectionView.delegate=self;
//    _chooseCollectionView.dataSource=self;
//    _chooseCollectionView.backgroundColor=[UIColor whiteColor];
//    [_chooseCollectionView registerNib:[UINib nibWithNibName:@"ConstomCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
//    
//    [_chooseCollectionView registerClass:[HeaderViewCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"footcell"];
//    
//    [_chooseCollectionView registerClass:[PictureAddCell class] forCellWithReuseIdentifier:@"addItemCell"];
//    [self.view addSubview:_chooseCollectionView];
//}


- (void)titleClick:(wxhTitleButton *)titleButton
{
    
    
    if (titleButton.tag==-1) {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
        titleButton.tag = IWTitleButtonDownTag;
        [self.tableView removeFromSuperview];
        self.tableView=nil;
        
    } else {
        [titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        titleButton.tag = IWTitleButtonUpTag;
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 200)];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.tableFooterView = [UIView new];
        self.tableView.rowHeight = 50;
        [self.view addSubview:self.tableView];
        [self.tableView registerNib:[UINib nibWithNibName:MGroupCellClassName bundle:nil] forCellReuseIdentifier:MGroupCellClassName];

    }
    
    
}
////////////////////////tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrGroup.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:MGroupCellClassName];
    ALAssetsGroup *froup = self.arrGroup[indexPath.row];
    cell.lblInfo.text = [NSString stringWithFormat:@"%@(%ld)",[froup valueForProperty:ALAssetsGroupPropertyName],(long)[froup numberOfAssets]];
    cell.imavHead.image = [UIImage imageWithCGImage:froup.posterImage];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    cellFlag = 0;
   // arrIma=(NSMutableArray *)[[MImaLibTool shareMImaLibTool]getAllAssetsWithGroup:self.arrGroup[indexPath.row] ];
    [arrIma removeAllObjects];
    
    
    ///为了添加第一个cell
    [arrIma addObjectsFromArray:(NSMutableArray *)[[MImaLibTool shareMImaLibTool]getAllAssetsWithGroup:self.arrGroup[indexPath.row] ]];
    [arrIma insertObject:@"nihao" atIndex:0];
    
    [_titleButton setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    _titleButton.tag = IWTitleButtonDownTag;
    
    //NSLog(@"ggg%@",arrIma);
    [self.chooseCollectionView reloadData];
    
    //获取数据之后 默认选择第一张图片   但图片没有显示出来  你在看看为啥？？？？
    NSIndexPath *dex = [NSIndexPath indexPathForRow:1 inSection:0];
    
    [self collectionView:self.chooseCollectionView didSelectItemAtIndexPath:dex];

    
    ALAssetsGroup *froup = self.arrGroup[indexPath.row];
    NSString * str = [NSString stringWithFormat:@"%@",[froup valueForProperty:ALAssetsGroupPropertyName]];
    
    
    [_titleButton setTitle:str forState:UIControlStateNormal];
    
    ALAsset *set=[[[MImaLibTool shareMImaLibTool] getAllAssetsWithGroup:self.arrGroup[indexPath.row]]firstObject];
    NSLog(@"set%@",set);
    headerView.imagV.image=[UIImage imageWithCGImage:set.thumbnail];
    
    [headerView getImaSizeWithAsset:set];
    
    [self.tableView removeFromSuperview];
}
////////////////collectionView////////////////////
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"%lu",(unsigned long)[arrIma count]);
    
    return [arrIma count];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    float wid = CGRectGetWidth(self.chooseCollectionView.bounds);
    return CGSizeMake((wid-3*5)/4, (wid-3*5)/4);
}


-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 0, 0, 0);
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    if (indexPath.row == 0) {
        static NSString *addItem = @"addItemCell";
        
        UICollectionViewCell *addItemCell = [collectionView dequeueReusableCellWithReuseIdentifier:addItem forIndexPath:indexPath];
        return addItemCell;
    }else{
        
        
             ConstomCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        
        
        /**
         *  重点在这  在你选择照片的时候把那个点击的cell标记一下 在这复用的时候你做一下判断 显示当前的indexpath时 让他是红色 如果是复用的话让他的背景色为白色
         */
        if (indexPath.row == cellFlag) {
            
            cell.backgroundColor = [UIColor redColor];

        }else{
                cell.backgroundColor = [UIColor whiteColor];
            
         }
             ALAsset *set = arrIma[indexPath.row];
            cell.iconImgV.image = [UIImage imageWithCGImage:set.thumbnail];
        if (cell.iconImgV.image.size.width>=cell.iconImgV.image.size.height) {
        }
            return cell;
       }
}
////添加选中标记
//-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//   ConstomCell * cell = (ConstomCell*)[collectionView cellForItemAtIndexPath:indexPath];
//    cell.backgroundColor=[UIColor whiteColor];
////    for (UIView * oneView in cell.subviews) {
////        
////        if ([oneView isKindOfClass:[checkView class]]) {
////            [oneView removeFromSuperview];
////        }
////    }
//}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
     tag =indexPath.row;
    if (tag==0) {
        UIImagePickerController *imaPic = [[UIImagePickerController alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imaPic.sourceType = UIImagePickerControllerSourceTypeCamera;
            imaPic.delegate = self;
            [self presentViewController:imaPic animated:YES completion:nil];
            return;
        }
        
    }
    
//    checkView * oneView = [[checkView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
    
    for (ConstomCell *cell in collectionView.visibleCells) {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
       ConstomCell * cell = (ConstomCell*)[collectionView cellForItemAtIndexPath:indexPath];
       cell.backgroundColor=[UIColor redColor];
    
    /**
     *  这个地方就是你选择的cell的标记的地方！！！！！！！！
     */
    
    cell.tag = indexPath.row;
    cellFlag = indexPath.row;
//    
//    [cell addSubview:oneView];
    
    ALAsset *set = arrIma[indexPath.row];
    
    ALAssetRepresentation *sentation = [set defaultRepresentation];
    headerView.imagV.image=[UIImage imageWithCGImage:[sentation fullScreenImage]];
    NSLog(@"%@",[sentation fullScreenImage]);
    
    
    [headerView getImaSizeWithAsset:set];
    
   // [self.navigationController popViewControllerAnimated:YES];
   
    
}




-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(self.view.frame.size.width, 300);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if([kind isEqual:UICollectionElementKindSectionHeader])
    {
        headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"footcell" forIndexPath:indexPath];
               
    }
    
    
    return headerView;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *ima = info[UIImagePickerControllerOriginalImage];
   
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}



@end
