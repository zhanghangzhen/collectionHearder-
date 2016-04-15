//
//  HeaderViewCollectionReusableView.h
//  collectionHearder
//
//  Created by kans on 16/3/30.
//  Copyright © 2016年 HaiYn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface HeaderViewCollectionReusableView : UICollectionReusableView

@property (nonatomic,strong )UIImageView * imagV;


-(void)getImaSizeWithAsset:(ALAsset *)set;


@end
