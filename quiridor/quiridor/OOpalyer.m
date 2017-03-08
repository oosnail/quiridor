//
//  OOpalyer.m
//  quiridor
//
//  Created by ztc on 16/12/5.
//  Copyright © 2016年 ZTC. All rights reserved.
//

#import "OOpalyer.h"
#import "UIViewAdditions.h"
#import "OOchessboard.h"
@implementation OOpalyer
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self UIinit];
    }
    return self;
}

- (id)init{
    self = [super init];
    if(self){
        [self setDefault];
        [self UIinit];
    }
    return self;
}

- (void)setDefault{
    _searchedArray = [NSMutableArray array];
    _neighborArray = [NSMutableArray array];
}

+ (id)player:(int)i{
    OOpalyer*player = [[OOpalyer alloc]init];
    player.tag = i;
    player.endType = i;
    player.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    return player;
}

- (void)UIinit{
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor brownColor];
}

- (void)resetSearchWay{
    _searchedArray = [NSMutableArray array];
    _neighborArray = [NSMutableArray array];
    self.nearestPoint = [[OOchessboard shareView] getNodeWithPoint:self.currentPoint];
}

- (void)setIsChoose:(BOOL)isChoose{
    _isChoose = isChoose;
    if(_isChoose){
        [self.layer addAnimation:[self opacityForever_Animation:0.5] forKey:nil];
    }else{
        [self.layer removeAllAnimations];
    }
}

- (void)moveWithDirection:(int)direction{
    
}
//闪烁
- (CABasicAnimation *)opacityForever_Animation:( float )time
{
    
    CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath : @"opacity" ]; // 必须写 opacity 才行。
    
    animation. fromValue = [ NSNumber numberWithFloat : 1.0f ];
    
    animation. toValue = [ NSNumber numberWithFloat : 0.0f ]; // 这是透明度。
    
    animation. autoreverses = YES ;
    
    animation. duration = time;
    
    animation. repeatCount = MAXFLOAT ;
    
    animation. removedOnCompletion = NO ;
    
    animation. fillMode = kCAFillModeForwards ;
    
    animation.timingFunction =[CAMediaTimingFunction functionWithName : kCAMediaTimingFunctionEaseIn ]; /// 没有的话是均匀的动画。
    
    return animation;
    
}

@end
