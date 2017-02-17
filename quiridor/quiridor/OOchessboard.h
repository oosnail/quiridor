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

#define MaxX  10
#define MaxY  10
#define lineWidth  5.f
#define _width  ((kScreenWidth - lineWidth)/MaxX -lineWidth)
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface OOchessboard : UIView
//墙的地址
@property (nonatomic,strong) NSMutableArray* wallArray;
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
@property (nonatomic,strong)OOpalyer *currentPlayer;

@property (nonatomic,strong) NSArray* playeyArray;
- (void)resetDodeStatus;
- (OONode*)getNodeWithPoint:(CGPoint)point;
+ (instancetype)shareView;

@end
