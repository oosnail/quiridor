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
    self.backgroundColor = [UIColor brownColor];
//    self.layer.cornerRadius = self.width/2;
//    self.layer.masksToBounds = YES;
}

- (void)resetSearchWay{
    _searchedArray = [NSMutableArray array];
    _neighborArray = [NSMutableArray array];
    self.nearestPoint = [[OOchessboard shareView] getNodeWithPoint:self.currentPoint];
}

@end
