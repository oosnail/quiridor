//
//  ViewController.h
//  quiridor
//
//  Created by ztc on 16/11/17.
//  Copyright © 2016年 ZTC. All rights reserved.
//

#import <UIKit/UIKit.h>



//墙离Node的位置
typedef NS_ENUM(NSUInteger,OOWallDirectType ) {
    OOWallDirectTypeUp=0,
    OOWallDirectTypeDown,
    OOWallDirectTypeLeft,
    OOWallDirectTypeRight,
};

@interface ViewController : UIViewController


@end

