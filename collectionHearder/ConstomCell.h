//
//  ConstomCell.h
//  collection添加头部
//
//  Created by user on 15/10/10.
//  Copyright (c) 2015年 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConstomCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImgV;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UILabel *nowPriceLab;


@property (weak, nonatomic) IBOutlet UILabel *beforePriceLab;

-(void)getString:(NSString *)str;
@end
