//
//  OOWall.m
//  PathFinding
//
//  Created by ztc on 16/11/22.
//  Copyright © 2016年 oosnail. All rights reserved.
//

#import "OOWall.h"

@implementation OOWall
- (void)setWallState:(OOWallState)wallState{
    _wallState = wallState;
    switch (wallState) {
        case OOWallStateNone:
            self.backgroundColor = [UIColor clearColor];
            break;
        case OOWallStateChoose:
            self.backgroundColor = [UIColor yellowColor];
            break;
        case OOWallStatetureWall:
            self.backgroundColor = [UIColor purpleColor];
            break;
        default:
            self.backgroundColor = [UIColor clearColor];
            break;
    }
}

- (id)copyWithZone:(NSZone *)zone
{
    OOWall *copy = [[[self class] allocWithZone:zone] initWithFrame:self.frame];
    copy.x = self.x;
    copy.y = self.y;
    copy.wallType = self.wallType;
    return copy;
}
@end
