//
//  OOWall.h
//  PathFinding
//
//  Created by ztc on 16/11/22.
//  Copyright © 2016年 oosnail. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,OOWallType ){
    OOWallTypehorizontal,//横着
    OOWallTypeVertical,//竖着
};

typedef NS_ENUM(NSUInteger,OOWallState ){
    OOWallStateNone,//啥都是不
    OOWallStateChoose,//选中状态（还不是一堵墙）
    OOWallStatetureWall,//已经放置上面的墙
};

@interface OOWall : UIView
@property (nonatomic, assign) int x;
@property (nonatomic, assign) int y;
@property (nonatomic, assign) OOWallType wallType;
@property (nonatomic, assign) OOWallState wallState;

//绘制墙
- (void)drawWall:(OOWallType)type Point:(CGPoint)point;
@end
