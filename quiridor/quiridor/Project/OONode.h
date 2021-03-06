//
//  OONode.h
//  PathFinding
//
//  Created by ztc on 16/11/22.
//  Copyright © 2016年 oosnail. All rights reserved.
//

#import <UIKit/UIKit.h>
//OONode的状态
typedef NS_ENUM(NSUInteger,OONodeViewType ) {
    OONodeViewTypeNone,//啥都是不
    OONodeViewTypeStart,//起始点
    OONodeViewTypeEnd,//结束点
    OONodeViewTypeSearched,//搜索过的点
    OONodeViewTypeNeighbor//即将搜索点（搜索过的点周边）
};

typedef NS_ENUM(NSUInteger,OONodeViewState ){
    OONodeViewStateNone,//啥都是不
    OONodeViewStateChoose,//选中
};

@interface OONode : UIView
@property (nonatomic, assign) int x;
@property (nonatomic, assign) int y;
@property (nonatomic, weak) OONode *parent;
//上下左右
@property (nonatomic, weak,readonly) OONode *upNode;
@property (nonatomic, weak,readonly) OONode *rightNode;
@property (nonatomic, weak,readonly) OONode *leftNode;
@property (nonatomic, weak,readonly) OONode *downNode;

@property (nonatomic, assign) int distance;
@property (nonatomic, assign) OONodeViewType viewTpye;
@property (nonatomic, assign) OONodeViewState viewState;

//获取某个node 附近可以走的node
- (NSMutableArray*)getValidnNeighborArray;

@end
