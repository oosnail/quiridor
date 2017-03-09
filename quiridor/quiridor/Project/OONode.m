//
//  OONode.m
//  PathFinding
//
//  Created by ztc on 16/11/22.
//  Copyright © 2016年 oosnail. All rights reserved.
//

#import "OONode.h"
#import "OOchessboard.h"
#import "UIView+OOqua.h"
@implementation OONode

- (id)init{
    self = [super  init];
    if(self){
        [self setDefault];
    }
    return self;
}

- (void)setDefault{
    
}

//不同的状态
- (void)setViewTpye:(OONodeViewType)viewTpye{
    _viewTpye = viewTpye;
    switch (viewTpye) {
        case OONodeViewTypeNone:
            self.backgroundColor = [UIColor whiteColor];
            break;
        case OONodeViewTypeStart:
            self.backgroundColor = [UIColor blueColor];
            break;
        case OONodeViewTypeEnd:
            self.backgroundColor = [UIColor greenColor];
            break;
        case OONodeViewTypeSearched:
            self.backgroundColor = [UIColor yellowColor];
            break;
        case OONodeViewTypeNeighbor:
            self.backgroundColor = [UIColor grayColor];
            break;
        default:
            self.backgroundColor = [UIColor whiteColor];
            break;
    }
}

- (void)setViewState:(OONodeViewState)viewState{
    _viewState = viewState;
    switch (viewState) {
        case OONodeViewStateNone:
            [self.layer removeAllAnimations];
            break;
        case OONodeViewStateChoose:
            [self opacityAnimation:0.5];
            break;
        default:
            break;
    }
}

- (NSMutableArray*)getValidnNeighborArray{
    NSArray *points = [OOchessboard shareView].wallPointArray;
    NSMutableArray * neibors = [[NSMutableArray alloc]init];
    for (int i=0;i<4;i++){
        //上下左右
        int _neibornodex;
        int _neibornodey;
        if(i == 0){//上
            if(self.y == MaxY-1){
                continue;
            }
            //判断是否有墙
            NSArray *wall = @[@(self.x),@(self.y+0.5)];
            if([points containsObject:wall]){
                continue;
            }
            
            
            _neibornodex = self.x;
            _neibornodey = self.y+1;
        }
        else if(i == 1){//下
            if(self.y == 0){
                continue;
            }
            NSArray *wall = @[@(self.x),@(self.y-0.5)];
            if([points containsObject:wall]){
                continue;
            }
            
            _neibornodex = self.x;
            _neibornodey = self.y-1;
        }
        else if(i == 2){//左
            if(self.x == 0){
                continue;
            }
            NSArray *wall = @[@(self.x-0.5),@(self.y)];
            if([points containsObject:wall]){
                continue;
            }
            _neibornodex = self.x-1;
            _neibornodey = self.y;
        }
        else if(i == 3){//右
            NSArray *wall = @[@(self.x+0.5),@(self.y)];
            if([points containsObject:wall]){
                continue;
            }
            if(self.x == MaxX-1){
                continue;
            }
            _neibornodex = self.x+1;
            _neibornodey = self.y;
        }
        //通过数组获取位置
        OONode* neiborNode = [OOchessboard shareView].allNodeArray[_neibornodex*MaxY + _neibornodey];
        [neibors addObject:neiborNode];
//        if([_neighboar containsObject: _neiboarpoint] || [player.searchedArray containsObject: _neiboarpoint]){
//            continue;
//        }
//        _neiboarself.parent = point;
        //        if(_neiboarself.viewTpye != OONodeViewTypeEnd && _neiboarself.viewTpye != OONodeViewTypeStart){
        //            _neiboarself.viewTpye = OONodeViewTypeNeighbor;
        //        }
//        [_neighboar addObject:_neiboarpoint];
    }
    return neibors;
}
@end
