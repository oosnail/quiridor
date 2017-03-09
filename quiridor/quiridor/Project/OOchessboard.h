//
//  OOchessboard.h
//  quiridor
//
//  Created by ztc on 16/12/6.
//  Copyright © 2016年 ZTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OONode.h"
#import "OOpalyer.h"
#import "OOWall.h"

#define MaxNum   10
#define MaxX  MaxNum
#define MaxY  MaxNum
//节点与节点之间的距离
#define lineWidth  5.f
//每个节点的宽度
#define _width  ((kScreenWidth - lineWidth)/MaxX -lineWidth)
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface OOchessboard : UIView
//获取棋盘上所有的墙
@property (nonatomic,strong) NSMutableArray<OOWall*>* wallArray;
//墙的point地址
@property (nonatomic,strong) NSMutableArray* wallPointArray;

//所有的节点
@property (nonatomic,strong) NSMutableArray<OONode*>* allNodeArray;
//开始点
//@property (nonatomic,strong)OONode *startNodeView;
//结束点
//@property (nonatomic,strong)OONode *endNodeView;
//选择的点
@property (nonatomic,strong)OONode *chooseNodeView;
//当前回合的player

@property (nonatomic,strong) NSArray* playeyArray;
- (void)resetDodeStatus;
- (OONode*)getNodeWithPoint:(CGPoint)point;
+ (instancetype)shareView;

@end
