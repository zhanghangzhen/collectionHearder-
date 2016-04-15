//
//  checkView.m
//  collectionHearder
//
//  Created by kans on 16/3/30.
//  Copyright © 2016年 HaiYn. All rights reserved.
//

#import "checkView.h"

@implementation checkView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame ]) {
        UIView * backView=[[UIView alloc]initWithFrame:self.frame];
        backView.backgroundColor=[UIColor redColor];
        self.backView=backView;
    }
    return self;
}
-(void)setBackView:(UIView *)backView{
    if (_backView!=backView) {
        _backView=backView;
        [self addSubview:backView];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
