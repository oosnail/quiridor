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
+ (instancetype)shareManage;

- (BOOL)hasEndpathWithaddWall:(OOWall*)addWall Player:(OOpalyer*)player;
@end
