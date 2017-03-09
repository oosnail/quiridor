//
//  ViewController.m
//  quiridor
//
//  Created by ztc on 16/11/17.
//  Copyright © 2016年 ZTC. All rights reserved.
//

/*
 1.遍历点 searchArray
 2.通过遍历点 获取可选择的下一步点 nextStepArray（此处可优化）
 3.从nextStepArray获取离终点最近点
 4.判断最近的点是不是终点 如果是 return
 5.如果不是将最近的点加入searchArray
 */

#import "ViewController.h"
#import "NSTimer+OOAddition.h"
#import "OONode.h"
#import "OOWall.h"
#import "OOpalyer.h"
#import "OOchessboard.h"
#import "UIView+OOqua.h"
#import "OOChessManage.h"
@interface ViewController ()


//墙的地址
//@property (nonatomic,strong) NSDictionary* wallViewDic;

//是否已经找到终点
@property (nonatomic, assign) BOOL findendPoint;



//定时器
@property (nonatomic,strong)NSTimer *time;
//开始按钮
@property (nonatomic,strong)UIButton *starButton;
//暂停按钮
@property (nonatomic,strong)UIButton *pauseButton;
//清除所有的墙
@property (nonatomic,strong)UIButton *clearWallButton;

//choosewall
@property (nonatomic,strong) OOWall *chooseWall;

//截图
@property(nonatomic,strong) UIView * snapshot;

@property(nonatomic,strong) OOchessboard * chessboard;;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    [self setDefaultValue];
    [self UIInit];
}

- (void)setDefaultValue{
//    _starPoint = @[@0,@0];
//    _endPoint = @[@(MaxX-1),@(MaxY-1)];
//    
//    _searchedArray = [NSMutableArray array];
//    
//    _neighborArray = [NSMutableArray array];
//    
//    _allNodeArray = [NSMutableArray array];
//    
//    _chessboard.wallArray = [NSMutableArray array];
//    
//    NSMutableArray *horizontal = [NSMutableArray array];
//    NSMutableArray *vertical = [NSMutableArray array];
//    _wallViewDic = @{@"horizontal" : horizontal,@"vertical":vertical};
//    _endPoint = @[@0,@9];
    //添加墙
    
    //[self resetDodeStatus];
    
}

- (void)UIInit{
//    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10,70, 100, 40)];
//    [button setTitle:@"开始寻路" forState:UIControlStateNormal];
//    [button setTitle:@"结束寻路" forState:UIControlStateSelected];
//    button.backgroundColor = [UIColor redColor];
//    [self.view addSubview:button];
//    [button addTarget:self action:@selector(button1Click:) forControlEvents:UIControlEventTouchUpInside];
//    _starButton = button;
//    
//    
//    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(130,70, 100, 40)];
//    [button2 setTitle:@"停止寻路" forState:UIControlStateNormal];
//    [button2 setTitle:@"继续寻路" forState:UIControlStateSelected];
//    button2.backgroundColor = [UIColor redColor];
//    [self.view addSubview:button2];
//    [button2 addTarget:self action:@selector(button2Click:) forControlEvents:UIControlEventTouchUpInside];
//    _pauseButton = button2;
//    
//    UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(250,70, 100, 40)];
//    [button3 setTitle:@"移除墙" forState:UIControlStateNormal];
//    button3.backgroundColor = [UIColor redColor];
//    [self.view addSubview:button3];
//    [button3 addTarget:self action:@selector(button3Click:) forControlEvents:UIControlEventTouchUpInside];
//    _clearWallButton = button3;
    
    _chessboard = [OOchessboard shareView];
    [self.view addSubview:_chessboard];

    
    float scale = 1.5;
    //添加选择墙的模块
    UIView *horizontalWall = [[UIView alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(_chessboard.frame)+30, (_width*2+lineWidth)*scale, lineWidth*scale)];
    horizontalWall.backgroundColor = [UIColor purpleColor];
    horizontalWall.tag = 1;
    [self.view addSubview:horizontalWall];
    
    UIView *verticalWall = [[UIView alloc]initWithFrame:CGRectMake(130,CGRectGetMaxY(_chessboard.frame)+30, lineWidth*scale, (_width*2+lineWidth)*scale)];
    verticalWall.backgroundColor = [UIColor purpleColor];
    verticalWall.tag = 2;
    [self.view addSubview:verticalWall];
    
    //长按手势
    UILongPressGestureRecognizer* longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longPress.minimumPressDuration = 0;
    [horizontalWall addGestureRecognizer:longPress];
    
    UILongPressGestureRecognizer* longPress1=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longPress1.minimumPressDuration = 0;
    [verticalWall addGestureRecognizer:longPress1];
    
    
    //添加玩家
    [self addPlayer];
}

- (void)addPlayer{
    OOpalyer *player = [[OOpalyer alloc]init];
    player.bounds = CGRectMake(0, 0, _width, _width);
//    player.center = 
}

-(void)longPress:(UILongPressGestureRecognizer *)longPress{
    //按住的时候回调用一次，松开的时候还会再调用一次
    UIView * invView = longPress.view;
    CGPoint location = [longPress locationInView:self.view];
    
    if(!_snapshot){
        _snapshot = [invView customSnapshoFromView];
        [invView.superview addSubview:_snapshot];
        if(_snapshot.tag == 1){
            _snapshot.bounds = CGRectMake(0, 0, _width*2+lineWidth, lineWidth);
        }else{
            _snapshot.bounds = CGRectMake(0, 0, lineWidth, _width*2+lineWidth);
        }
        _snapshot.center = location;
    }
    switch (longPress.state) {
        case UIGestureRecognizerStatePossible: {
            //            [self setAllViewType:INVViewtatusNone];
            break;
        }
        case UIGestureRecognizerStateBegan: {
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self moviesnapshot:location];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            [self endmoviesnapshot:location];
            break;
        }
        case UIGestureRecognizerStateCancelled: {
            [_snapshot removeFromSuperview];
            _snapshot = nil;
            break;
        }
        case UIGestureRecognizerStateFailed: {
            [_snapshot removeFromSuperview];
            _snapshot = nil;
            break;
        }
    }
}

- (void)moviesnapshot:(CGPoint)loc{
    _snapshot.center = loc;
    CGPoint point = [self nearestPoint:loc];
    if(_snapshot.tag == 1){//横着
        if (point.x>-1 && point.y>-1) {
            [self drawWall:OOWallTypehorizontal Point:point];
        }
    }
    else{//竖着
        [self drawWall:OOWallTypeVertical Point:point];
    }

}

//移动结束

- (void)endmoviesnapshot:(CGPoint)loc{
    //获取loc的位置
    //1是横 2是竖
    if(_chooseWall && !_chooseWall.hidden){
        OOWall *wall = [_chooseWall copy];
        wall.backgroundColor = [UIColor purpleColor];
        [_chessboard addSubview:wall];
        [_chessboard.wallArray addObject:wall];
        if(wall.wallType == OOWallTypehorizontal){

            [_chessboard.wallPointArray addObject: @[@(wall.x),@(wall.y+0.5)]];
            [_chessboard.wallPointArray addObject: @[@(wall.x+1),@(wall.y+0.5)]];


        }
        else{
            [_chessboard.wallPointArray addObject: @[@(wall.x+0.5),@(wall.y)]];
            [_chessboard.wallPointArray addObject: @[@(wall.x+0.5),@(wall.y+1)]];
        }
        [_chooseWall removeFromSuperview];
        _chooseWall = nil;
    }
    [_snapshot removeFromSuperview];
    _snapshot = nil;
}


//开始 and 结束

- (void)button1Click:(UIButton*)button{}

//继续 and 暂停
- (void)button2Click:(UIButton*)button{
    if(!button.selected){
        [self stopSearch];
    }else{
        [self againSearch];
    }
    
    button.selected = !button.selected;
}

- (void)button3Click:(UIButton*)button3Click{
//    for (OOWall *wall in self.wallViewDic[@"horizontal"]) {
//        wall.wallState = OOWallStateNone;
//    }
//    for (OOWall *wall in self.wallViewDic[@"vertical"]) {
//        wall.wallState = OOWallStateNone;
//    }
//    [_chessboard.wallArray removeAllObjects];
}


//暂停寻路
- (void)stopSearch{
    if(_time){
        [_time pauseTimer];
    }
}

//恢复寻路
- (void)againSearch{
    if(_time){
        [_time resumeTimer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)drawWall:(OOWallType)type Point:(CGPoint)point{
    //画墙
    
    if(point.x < 0 ||  point.y < 0){
        return;
    }

    CGPoint _locPoint = [self pointinview:point];
    if(!_chooseWall){
        _chooseWall =  [[OOWall alloc]init];
        [_chessboard addSubview:_chooseWall];
    }
    _chooseWall.wallType = type;
    _chooseWall.x = point.x;
    _chooseWall.y = point.y;
    _chooseWall.backgroundColor = [UIColor yellowColor];
    if(type == OOWallTypehorizontal){
        _chooseWall.bounds = CGRectMake(0, 0, lineWidth+2*_width, lineWidth);
    }else{
        _chooseWall.bounds = CGRectMake(0, 0, lineWidth,lineWidth+2*_width);
    }
    
    if([self isWallValid:_chooseWall]){
        _chooseWall.hidden = NO;
        _chooseWall.center = CGPointMake(_locPoint.x, _locPoint.y);
    }else{
        _chooseWall.hidden = YES;
    }
}

//通过坐标点(x,y)获取最近的节点(1,1)
- (CGPoint)nearestPoint:(CGPoint)loc{
    int x = round((loc.x - (lineWidth)/2 - _width)*MaxX/(kScreenWidth - lineWidth));
    int y =MaxY-1 - round((loc.y-_chessboard.top - (lineWidth)/2)*MaxY/(kScreenWidth - lineWidth));

    if(x>MaxX-2 || x < 0 || y > MaxX-2 || y < 0){
        return CGPointMake(-1, -1);
    }
    
    return CGPointMake(x, y);
}

//通过节点获取在view上的面的坐标
- (CGPoint)pointinview:(CGPoint)point{
    CGFloat x = (point.x+1)*(_width+lineWidth)+0.5*lineWidth;
    CGFloat y = kScreenWidth- (point.y+1)*(_width+lineWidth)-0.5*lineWidth;
    NSLog(@"x:%f,y:%f \n",point.x,point.y);

    NSLog(@"x:%f,y:%f \n",x,y);

    return CGPointMake(x, y);
}

//这个wall是否合法
//如果本身是竖着
//1.横着的话 如果中心点一致 则不合法
//2.竖着的话 中心点相差绝对值大于1
- (BOOL)isWallValid:(OOWall*)wall{
    if(![self noWallOcclusion:wall]){
        return NO;
    }
    if(![self deathWarrantToAnyPlayer:wall]){
        return NO;
    }
    return YES;
}

//没有强墙遮挡了
- (BOOL)noWallOcclusion:(OOWall*)wall{
    for(OOWall *_wall in _chessboard.wallArray){
        if(_wall.wallType !=  wall.wallType){
            if(_wall.x == wall.x && _wall.y == wall.y){
                return NO;
            }
        }else{
            if(wall.wallType == OOWallTypeVertical){
                if(abs(_wall.y - wall.y)<2 && _wall.x == wall.x){
                    return NO;
                }
            }else{
                if(abs(_wall.x - wall.x)<2 && _wall.y == wall.y){
                    return NO;
                }
            }
        }
    }
    return YES;
}

//是否是绝路
- (BOOL)deathWarrantToAnyPlayer:(OOWall*)wall{
    for(OOpalyer* player in self.chessboard.playeyArray){
        if([[OOChessManage shareManage] hasEndpathWithaddWall:wall Player:player]){
            NSLog(@"play is deathWay");
            return NO;
        }
    }
    return YES;
}

- (OONode*)getNodeWithPoint:(CGPoint)point{
    OONode *node = _chessboard.allNodeArray[(int)(point.x*MaxY + point.y)];
    return node;
}

//获取player可走的位置
- (NSArray*)playerWays:(OOpalyer*)player{
    return @[];
}

@end
