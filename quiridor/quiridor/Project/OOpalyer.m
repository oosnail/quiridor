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
#import "OOChessManage.h"
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
        NSArray* nodes = [self getValidnNeighborArray];
        for(OONode*node in nodes){
            node.viewTpye = OONodeViewTypeNeighbor;
            [[OOChessManage shareManage].nextStepNodes addObject:node];

        }
    }else{
        [self.layer removeAllAnimations];
    }
}

- (void)moveToNode:(OONode*)node{
    self.currentNode = node;
    self.center = node.center;
    [[OOChessManage shareManage] changeCurrentPlyer];
}

//获取某个点
- (NSMutableArray*)getValidnNeighborArray{
    OONode *node = self.currentNode;
    NSMutableArray * canmoves = [node getValidnNeighborArray];
    
    OOpalyer *another =[self anoherPlayer];
    OONode *anotherNode = another.currentNode;
    
    //是否包含其他玩家
    OONode *nextNode ;
    if([canmoves containsObject:anotherNode]){
        [canmoves removeObject:anotherNode];
        //上
        if(anotherNode.y - node.y == 1){
            nextNode = anotherNode.upNode;
        }else if(anotherNode.y - node.y == -1){//下
            nextNode = anotherNode.downNode;
        }else if(anotherNode.x - node.x == -1){//左
            nextNode = anotherNode.leftNode;
        }else if(anotherNode.x - node.x == 1){//右
            nextNode = anotherNode.rightNode;
        }
        
        NSMutableArray * anotherCanMoves = [another.currentNode getValidnNeighborArray];
        [anotherCanMoves removeObject:anotherNode];
        //有上
        if([anotherCanMoves containsObject:nextNode]){
            [canmoves addObject:nextNode];
        }else{
            [canmoves addObjectsFromArray:anotherCanMoves];
        }
        

    }
    
    
    return canmoves;
}

- (OOpalyer*)anoherPlayer{
    NSArray *players = [OOchessboard shareView].playeyArray;
    NSInteger index = [players indexOfObject:self];
    NSInteger anotherIndex = 1-index;
    OOpalyer *another =players[anotherIndex];
    return another;
}

- (void)moveWithDirection:(int)direction{
    
}
@end
