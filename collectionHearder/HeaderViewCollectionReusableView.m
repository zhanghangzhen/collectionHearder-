//
//  HeaderViewCollectionReusableView.m
//  collectionHearder
//
//  Created by kans on 16/3/30.
//  Copyright © 2016年 HaiYn. All rights reserved.
//

#import "HeaderViewCollectionReusableView.h"

@implementation HeaderViewCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
       //UIImageView * imagV=[[UIImageView alloc]initWithFrame:CGRectMake(50,0 ,self.frame.size.width-100 ,300)];
        
        UIImageView * imagV=[[UIImageView alloc]init];
        self.imagV=imagV;
        imagV.backgroundColor=[UIColor redColor];
        
    }
    return self;
}


-(void)getImaSizeWithAsset:(ALAsset *)set{
    ALAssetRepresentation *sentation = [set defaultRepresentation];
    self.imagV.image=[UIImage imageWithCGImage:[sentation fullScreenImage]];
    
    CGSize imaSize ;
   
    float scale = sentation.dimensions.width/sentation.dimensions.height;
    imaSize.width = floor(300*scale);
    imaSize.height = 300;
    
//    UIImageView * imagV=[[UIImageView alloc]initWithFrame:CGRectMake((self.superview.frame.size.width-imaSize.width)/2,0 ,imaSize.width  ,imaSize.height)];
    self.imagV.frame=CGRectMake((self.superview.frame.size.width-imaSize.width)/2,0 ,imaSize.width  ,imaSize.height);
}


-(void)setImagV:(UIImageView *)imagV{
    if (_imagV!=imagV) {
        _imagV=imagV;
        [self addSubview:_imagV];
    }
}


//-(void)setTf:(UITextField *)tf{
//    if (_tf!=tf) {
//        _tf=tf;
//        [self addSubview:_tf];
//    }
//}
//

@end
