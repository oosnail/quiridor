//
//  OOChessManage.m
//  quiridor
//
//  Created by 张天琛 on 2017/3/9.
//  Copyright © 2017年 ZTC. All rights reserved.
//

#import "OOChessManage.h"
#import "OOchessboard.h"
@interface OOChessManage()
//已经搜索过的node
@property (nonatomic,strong) NSMutableSet<OONode *>* searchedArray;
//即将搜索的node
@property (nonatomic,strong) NSMutableSet<OONode *>* neighborArray;
//_neighborArray = [NSMutableArray array];
@property (nonatomic,weak) OONode* nearestNode;


@end

@implementation OOChessManage
+ (instancetype)shareManage{
    static OOChessManage *manage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [[OOChessManage alloc] init];
        [manage setDefaultData];
    });
    return manage;
}

- (void)setDefaultData{
    _searchedArray = [[NSMutableSet alloc]init];
    _neighborArray = [[NSMutableSet alloc]init];
    _nextStepNodes = [[NSMutableSet alloc]init];
}

//reload data
- (void)resetSearchData:(OOpalyer*)player{
    [_searchedArray removeAllObjects];
    [_searchedArray addObject:player.currentNode];
    _nearestNode =player.currentNode;
    [_neighborArray removeAllObjects];
}

- (BOOL)hasEndpathWithaddWall:(OOWall*)addWall Player:(OOpalyer*)player{
    [self resetSearchData:player];
//    OONode *node = player.currentNode;
    NSMutableArray*arr = [NSMutableArray arrayWithArray:[OOchessboard shareView].wallPointArray];
    if(addWall.wallType == OOWallTypehorizontal){
        [arr addObject: @[@(addWall.x),@(addWall.y+0.5)]];
        [arr addObject: @[@(addWall.x+1),@(addWall.y+0.5)]];
    }else{
        [arr addObject: @[@(addWall.x+0.5),@(addWall.y)]];
        [arr addObject: @[@(addWall.x+0.5),@(addWall.y+1)]];
    }
    while (true) {
        OONode* _nearestPoint = _nearestNode;
        NSMutableArray*_neighboar = [self getValidnNeighborArray:_nearestNode wallPoints:arr];
        [_neighborArray removeObject:_nearestNode];
        [_neighborArray addObjectsFromArray:_neighboar];
        [_searchedArray addObject:_nearestPoint];
        //如果_neighborArray 为空 表示所有搜索都搜索到了。。
        if(_neighborArray.count==0){
//            _findendPoint = NO;
            return YES;
        }
        _nearestNode = [self getNearestPointInNeighboar:player];
        if(player.endType == 0 && _nearestPoint.y == MaxY-1){
//            _findendPoint = YES;
            return NO;
        }else if(player.endType == 1 && _nearestPoint.y == 0){
//            _findendPoint = YES;
            return NO;
        }
    }
    return NO;
}

//获取附近的点离终点最近
- (OONode*)getNearestPointInNeighboar:(OOpalyer*)player{
    OONode *nearlistPoint;
    for (OONode*point in _neighborArray) {
        if(!nearlistPoint){
            nearlistPoint = point;
            continue;
        }
        if(player.endType == 0){//终点是上
            if(point.y > nearlistPoint.y){
                nearlistPoint = point;
            }
        }else{//终点是下
            if(point.y < nearlistPoint.y){
                nearlistPoint = point;
            }
        }
        
    }
    return nearlistPoint;
}

- (NSMutableArray*)getValidnNeighborArray:(OONode*)node wallPoints:(NSArray*)wallPoints{
    NSArray *points = wallPoints;
    NSMutableArray * neibors = [[NSMutableArray alloc]init];
    for (int i=0;i<4;i++){
        //上下左右
        int _neibornodex;
        int _neibornodey;
        if(i == 0){//上
            if(node.y == MaxY-1){
                continue;
            }
            //判断是否有墙
            NSArray *wall = @[@(node.x),@(node.y+0.5)];
            if([points containsObject:wall]){
                continue;
            }
            
            
            _neibornodex = node.x;
            _neibornodey = node.y+1;
        }
        else if(i == 1){//下
            if(node.y == 0){
                continue;
            }
            NSArray *wall = @[@(node.x),@(node.y-0.5)];
            if([points containsObject:wall]){
                continue;
            }
            
            _neibornodex = node.x;
            _neibornodey = node.y-1;
        }
        else if(i == 2){//左
            if(node.x == 0){
                continue;
            }
            NSArray *wall = @[@(node.x-0.5),@(node.y)];
            if([points containsObject:wall]){
                continue;
            }
            _neibornodex = node.x-1;
            _neibornodey = node.y;
        }
        else if(i == 3){//右
            NSArray *wall = @[@(node.x+0.5),@(node.y)];
            if([points containsObject:wall]){
                continue;
            }
            if(node.x == MaxX-1){
                continue;
            }
            _neibornodex = node.x+1;
            _neibornodey = node.y;
        }
        //通过数组获取位置
        OONode* neiborNode = [OOchessboard shareView].allNodeArray[_neibornodex*MaxY + _neibornodey];
        if([_neighborArray containsObject: neiborNode] || [_searchedArray containsObject: neiborNode]){
            continue;
        }
        [neibors addObject:neiborNode];
    }
    return neibors;
}

- (NSMutableArray*)getValidnNeighborArray:(OONode*)node{
    NSArray *points = [OOchessboard shareView].wallPointArray;
    NSMutableArray * neibors = [[NSMutableArray alloc]init];
    for (int i=0;i<4;i++){
        //上下左右
        int _neibornodex;
        int _neibornodey;
        if(i == 0){//上
            if(node.y == MaxY-1){
                continue;
            }
            //判断是否有墙
            NSArray *wall = @[@(node.x),@(node.y+0.5)];
            if([points containsObject:wall]){
                continue;
            }
            
            
            _neibornodex = node.x;
            _neibornodey = node.y+1;
        }
        else if(i == 1){//下
            if(node.y == 0){
                continue;
            }
            NSArray *wall = @[@(node.x),@(node.y-0.5)];
            if([points containsObject:wall]){
                continue;
            }
            
            _neibornodex = node.x;
            _neibornodey = node.y-1;
        }
        else if(i == 2){//左
            if(node.x == 0){
                continue;
            }
            NSArray *wall = @[@(node.x-0.5),@(node.y)];
            if([points containsObject:wall]){
                continue;
            }
            _neibornodex = node.x-1;
            _neibornodey = node.y;
        }
        else if(i == 3){//右
            NSArray *wall = @[@(node.x+0.5),@(node.y)];
            if([points containsObject:wall]){
                continue;
            }
            if(node.x == MaxX-1){
                continue;
            }
            _neibornodex = node.x+1;
            _neibornodey = node.y;
        }
        //通过数组获取位置
        OONode* neiborNode = [OOchessboard shareView].allNodeArray[_neibornodex*MaxY + _neibornodey];
//        if([_neighborArray containsObject: neiborNode] || [_searchedArray containsObject: neiborNode]){
//            continue;
//        }
        [neibors addObject:neiborNode];
    }
    return neibors;
}

- (void)changeCurrentPlyer{
    self.currentPlayer.isChoose = NO;
    for(OONode*node in [OOChessManage shareManage].nextStepNodes){
        node.viewTpye = OONodeViewTypeNone;
    }
    [[OOChessManage shareManage].nextStepNodes removeAllObjects];
    NSArray*players = [OOchessboard shareView].playeyArray;
    NSInteger i =  [players indexOfObject: self.currentPlayer];
    if(i == players.count-1){
        i = 0;
    }else{
        i++;
    }
    self.currentPlayer =players[i];
}
@end
