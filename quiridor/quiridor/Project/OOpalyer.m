//
//  OOpalyer.m
//  quiridor
//
//  Created by ztc on 16/12/5.
//  Copyright © 2016年 ZTC. All rights reserved.
//

#import "OOpalyer.h"
#import "OOchessboard.h"
#import "UIView+OOqua.h"
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

}

- (void)setIsChoose:(BOOL)isChoose{
    _isChoose = isChoose;
    if(_isChoose){
        [self opacityAnimation:0.5];
    }else{
        [self.layer removeAllAnimations];
    }
}

- (void)moveWithDirection:(int)direction{
    
}

- (BOOL)hasEndpathWithaddWall:(OOWall*)addWall{
    
    
    return NO;
}


@end
