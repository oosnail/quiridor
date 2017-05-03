//
//  OOpalyer.h
//  quiridor
//
//  Created by ztc on 16/12/5.
//  Copyright © 2016年 ZTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OONode.h"
#import "OOWall.h"
@interface OOpalyer : UIView

//结束点 endType = 0 上 1 下 2 右 3 左
@property (nonatomic,assign)int endType;


@property (nonatomic,assign)BOOL isChoose;

//当前所在位置
@property (nonatomic,assign)CGPoint currentPoint;

@property (nonatomic,weak)OONode* currentNode;


//可以移动的位置
@property (nonatomic,assign)NSArray * movieNodes;

- (id)init;

- (id)initWithFrame:(CGRect)frame;

//工厂模式创建player i先这么设定
+ (id)player:(int)i;

- (void)resetSearchWay;

//移动位置 direction = 0 上 1 下 2 右 3 左
- (void)moveWithDirection:(int)direction;

- (void)moveToNode:(OONode*)node;

//该player 可走的范围
- (NSMutableArray*)getValidnNeighborArray;

- (OOpalyer*)anoherPlayer;
@end



