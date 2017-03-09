//
//  OOChessManage.h
//  quiridor
//
//  Created by 张天琛 on 2017/3/9.
//  Copyright © 2017年 ZTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OOpalyer.h"
#import "OOWall.h"
@interface OOChessManage : NSObject

@property (nonatomic,strong)OOpalyer *currentPlayer;

//下一步可走的位置
@property (nonatomic,strong) NSMutableSet<OONode *>* nextStepNodes;


+ (instancetype)shareManage;

- (BOOL)hasEndpathWithaddWall:(OOWall*)addWall Player:(OOpalyer*)player;

//某个点附近可以移动的点的集合
- (NSMutableArray*)getValidnNeighborArray:(OONode*)node;

//回合完成
- (void)changeCurrentPlyer;

@end
