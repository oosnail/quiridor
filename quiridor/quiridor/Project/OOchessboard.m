//
//  OOchessboard.m
//  quiridor
//
//  Created by ztc on 16/12/6.
//  Copyright © 2016年 ZTC. All rights reserved.
//

#import "OOchessboard.h"


@implementation OOchessboard

+ (instancetype)shareView{
    static OOchessboard *view = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [[OOchessboard alloc] init];
        [view setDefaultValue];
        [view UIInit];
    });
    return view;
}

- (void)setDefaultValue{
   // _starPoint = @[@0,@0];
   // _endPoint = @[@(MaxNum-1),@(MaxNum-1)];
    
    //_searchedArray = [NSMutableArray array];
   
   // _neighborArray = [NSMutableArray array];
    
    _allNodeArray = [NSMutableArray array];
    
    _wallArray = [NSMutableArray array];
    _wallPointArray = [NSMutableArray array];
    
    //    NSMutableArray *horizontal = [NSMutableArray array];
    //    NSMutableArray *vertical = [NSMutableArray array];
    //    _wallViewDic = @{@"horizontal" : horizontal,@"vertical":vertical};
    //_endPoint = @[@0,@9];
    //添加墙
    
    //[self resetDodeStatus];
    
}
#pragma mark- UI
- (void)UIInit{
    self.backgroundColor = [UIColor redColor];
    self.bounds = CGRectMake(0, 0, kScreenWidth, kScreenWidth);
    self.center = CGPointMake(kScreenWidth/2.0, kScreenHeight/2.0);
    [self addNode];
    [self addPlayer];
}
//添加棋盘
- (void)addNode{
    for(int x =0;x<MaxNum;x++){
        for(int y =0;y<MaxNum;y++){
            OONode * nodeView = [[OONode alloc]init];
            nodeView.bounds = CGRectMake(0, 0, _width, _width);
            nodeView.center = CGPointMake((x+1)*(_width+lineWidth)-_width/2,kScreenWidth- (y+1)*(_width+lineWidth)+_width/2);
            nodeView.backgroundColor = [UIColor whiteColor];
            nodeView.x = x;
            nodeView.y = y;
            [self addSubview:nodeView];
            [self setPointDistance:nodeView];
            [_allNodeArray addObject:nodeView];
            //            if(x == [_starPoint[0]intValue] && y == [_starPoint[1]intValue] ){
            //                _startNodeView = nodeView;
            //                nodeView.viewTpye = OONodeViewTypeStart;
            //                _nearestPoint = nodeView;
            //                [_searchedArray addObject:_nearestPoint];
            //                [_neighborArray addObject:_nearestPoint];
            //            }else if(x == [_endPoint[0]intValue]  && y == [_endPoint[1]intValue] ){
            //                nodeView.viewTpye = OONodeViewTypeEnd;
            //                _endNodeView = nodeView;
            //            }else{
            //                nodeView.viewTpye = OONodeViewTypeNone;
            //            }
            //添加手势
            //添加手势
            {
                                UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
                                [nodeView addGestureRecognizer:ges];
            }
            //设置wallView
            
            
        }
    }
}

//添加双方玩家
- (void)addPlayer{
    OOpalyer *player1 = [OOpalyer player:0];
    player1.bounds = CGRectMake(0, 0, _width, _width);
    OONode*node = [self getNodeWithPoint:CGPointMake(4, 0)];
    player1.center = node.center;
    player1.currentPoint = CGPointMake(4, 0);
    player1.endType = 0;
    player1.currentNode = node;

    [self addSubview:player1];
    
    OOpalyer *player2 = [OOpalyer player:0];
    player2.bounds = CGRectMake(0, 0, _width, _width);
    OONode*node2 = [self getNodeWithPoint:CGPointMake(4, 9)];
    player2.currentPoint = CGPointMake(4, 9);
    player2.currentNode = node2;
    player2.endType = 1;
    player2.center = node2.center;
    [self addSubview:player2];
    
    _currentPlayer = player1;
    _playeyArray = @[player1,player2];
    
    

    
}

-(void)tapAction:(UITapGestureRecognizer *)tap{
    OONode *node =(OONode*) [tap view];
    for(OOpalyer*player in _playeyArray){
        if(player.currentNode == node){
            player.isChoose = YES;
        }
    }
}

- (void)resetDodeStatus{
    
}

//给point计算位置
- (void)setPointDistance:(OONode*)point{
  //  point.distance = abs([_endPoint[0] intValue] - point.x)+abs([_endPoint[1] intValue]  - point.y);
}

- (void)updatePointDistance{
    for(OONode*node in _allNodeArray){
        [self setPointDistance:node];
    }
}

- (OONode*)getNodeWithPoint:(CGPoint)point{
    OONode *node = self.allNodeArray[(int)(point.x*MaxNum + point.y)];
    return node;
}

@end
