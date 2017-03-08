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
#import "UIViewAdditions.h"
#import "OOpalyer.h"
#import "OOchessboard.h"

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
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10,70, 100, 40)];
    [button setTitle:@"开始寻路" forState:UIControlStateNormal];
    [button setTitle:@"结束寻路" forState:UIControlStateSelected];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(button1Click:) forControlEvents:UIControlEventTouchUpInside];
    _starButton = button;
    
    
    UIButton *button2 = [[UIButton alloc]initWithFrame:CGRectMake(130,70, 100, 40)];
    [button2 setTitle:@"停止寻路" forState:UIControlStateNormal];
    [button2 setTitle:@"继续寻路" forState:UIControlStateSelected];
    button2.backgroundColor = [UIColor redColor];
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(button2Click:) forControlEvents:UIControlEventTouchUpInside];
    _pauseButton = button2;
    
    UIButton *button3 = [[UIButton alloc]initWithFrame:CGRectMake(250,70, 100, 40)];
    [button3 setTitle:@"移除墙" forState:UIControlStateNormal];
    button3.backgroundColor = [UIColor redColor];
    [self.view addSubview:button3];
    [button3 addTarget:self action:@selector(button3Click:) forControlEvents:UIControlEventTouchUpInside];
    _clearWallButton = button3;
    
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
        _snapshot = [self customSnapshoFromView:invView];
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


        }else{
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

- (void)button1Click:(UIButton*)button{
    if(!button.selected){
        _pauseButton.selected = NO;
        _clearWallButton.enabled = NO;
        [self beginSearch];
    }else{
        _clearWallButton.enabled = YES;
        [self endSearch];
        [self resetDodeStatus];
    }
    button.selected = !button.selected;
}

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

//开始搜索

- (void)beginSearch{
    [self resetDodeStatus];
    if(!_time){
        NSTimer *time = [NSTimer timerWithTimeInterval:0.2 target:self selector:@selector(searchPath:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:time forMode:NSDefaultRunLoopMode];
        _time =time;
    }
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

//寻路

- (void)searchPath:(OOpalyer*)player{
    
    OONode* _nearestPoint = _chessboard.currentPlayer.nearestPoint;
    NSMutableArray*_neighboar = [self neighboarWithPoint:_chessboard.currentPlayer.nearestPoint WallPoints:_chessboard.wallPointArray Play:player];
    [_chessboard.currentPlayer.neighborArray removeObject:_chessboard.currentPlayer.nearestPoint];
    [_chessboard.currentPlayer.neighborArray addObjectsFromArray:_neighboar];
    [_chessboard.currentPlayer.searchedArray addObject:_nearestPoint];
    if(_nearestPoint.viewTpye != OONodeViewTypeStart && _nearestPoint.viewTpye != OONodeViewTypeEnd){
        _nearestPoint.viewTpye =OONodeViewTypeSearched;
    }
    [_nearestPoint layoutIfNeeded];
    //如果_neighborArray 为空 表示所有搜索都搜索到了。。
    if(_chessboard.currentPlayer.neighborArray.count==0){
        _findendPoint = NO;
        [self endSearch];
        return;
    }
    _chessboard.currentPlayer.nearestPoint = [self getNearestPointInNeighboar:player];
    if(_nearestPoint.y == 9){
        _findendPoint = YES;
        [self endSearch];
        return;
    }
}

//结束寻路
- (void)endSearch{
    [_time invalidate];
    _time = nil;
    if(_findendPoint){
        //获得最优解
        OONode *parent = self.chessboard.currentPlayer.nearestPoint;
        NSMutableArray * _bestPath = [NSMutableArray array];
        [_bestPath insertObject:parent atIndex:0];
        while (parent) {
            parent = parent.parent;
            if(parent){
//                NSLog(@"x:%d,y:%d \n",parent.x,parent.y);
                [_bestPath insertObject:parent atIndex:0];
            }
        }
    }else{
        NSLog(@"sorry I can't find endPoint");
    }
    
}


- (void)resetDodeStatus{
    //重新改变
//    _nearestPoint = nil;
//    for(OONode *nodeView in _chessboard.allNodeArray){
//        nodeView.parent = nil;
//        int x = nodeView.x;
//        int y = nodeView.y;
//        if(x == [_starPoint[0]intValue] && y == [_starPoint[1]intValue] ){
//            nodeView.viewTpye = OONodeViewTypeStart;
//            _nearestPoint = nodeView;
//        }else if(x == [_endPoint[0]intValue]  && y == [_endPoint[1]intValue] ){
//            nodeView.viewTpye = OONodeViewTypeEnd;
//        }else{
//            nodeView.viewTpye = OONodeViewTypeNone;
//        }
//    }
//    [_searchedArray removeAllObjects];
//    [_neighborArray removeAllObjects];
//    
//    [_searchedArray addObject:_nearestPoint];
//    [_neighborArray addObject:_nearestPoint];
    
    
}

//获取某个点附近的点

- (NSMutableArray*)neighboarWithPoint:(OONode*)point WallPoints:(NSArray*)points Play:(OOpalyer*)player{
    NSMutableArray *_neighboar = [NSMutableArray array];
    for (int i=0;i<4;i++){
        //上下左右
        OONode* _neiboarpoint;
        int _x;
        int _y;
        if(i == 0){//上
            if(point.y == MaxY-1){
                continue;
            }
            //判断是否有墙
            NSArray *wall = @[@(point.x),@(point.y+0.5)];
            if([points containsObject:wall]){
                continue;
            }
            
            
            _x = point.x;
            _y = point.y+1;
        }
        else if(i == 1){//下
            if(point.y == 0){
                continue;
            }
            NSArray *wall = @[@(point.x),@(point.y-0.5)];
            if([points containsObject:wall]){
                continue;
            }
            
            _x = point.x;
            _y = point.y-1;
        }
        else if(i == 2){//左
            if(point.x == 0){
                continue;
            }
            NSArray *wall = @[@(point.x-0.5),@(point.y)];
            if([points containsObject:wall]){
                continue;
            }
            _x = point.x-1;
            _y = point.y;
        }
        else if(i == 3){//右
            NSArray *wall = @[@(point.x+0.5),@(point.y)];
            if([points containsObject:wall]){
                continue;
            }
            if(point.x == MaxX-1){
                continue;
            }
            _x = point.x+1;
            _y = point.y;
        }
        //通过数组获取位置
        _neiboarpoint = _chessboard.allNodeArray[_x*MaxY + _y];
        if([_neighboar containsObject: _neiboarpoint] || [player.searchedArray containsObject: _neiboarpoint]){
            continue;
        }
        _neiboarpoint.parent = point;
//        if(_neiboarpoint.viewTpye != OONodeViewTypeEnd && _neiboarpoint.viewTpye != OONodeViewTypeStart){
//            _neiboarpoint.viewTpye = OONodeViewTypeNeighbor;
//        }
        [_neighboar addObject:_neiboarpoint];
    }
    return _neighboar;
}

//给point计算位置
/*
- (void)setPointDistance:(OONode*)point{
    point.distance = abs([_endPoint[0] intValue] - point.x)+abs([_endPoint[1] intValue]  - point.y);
}

- (void)updatePointDistance{
    for(OONode*node in _allNodeArray){
        [self setPointDistance:node];
    }
}
*/
//获取附近的点离终点最近

- (OONode*)getNearestPointInNeighboar:(OOpalyer*)player{
    OONode *nearlistPoint;
    for (OONode*point in player.neighborArray) {
        if(!nearlistPoint){
            nearlistPoint = point;
            continue;
        }
        if(player.endType == 0){//终点是上
            if(point.y > nearlistPoint.y){
                nearlistPoint = point;
            }
        }else{//终点是下
            if(point.y < nearlistPoint.y){
                nearlistPoint = point;
            }
        }

    }
    return nearlistPoint;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (void)tap:(UIGestureRecognizer*)gesture{
    OONode *node = (OONode*)gesture.view;
    //如果之前有选择的情况
    if(_chooseNodeView){
        if(_chooseNodeView == node){
            return;
        }
        _chooseNodeView.viewState  = OONodeViewStateNone;
        if(node.viewTpye == OONodeViewTypeStart){
            node.viewState = OONodeViewStateChoose;
            _chooseNodeView = node;
        }else if(node.viewTpye == OONodeViewTypeEnd){
            node.viewState = OONodeViewStateChoose;
            _chooseNodeView = node;
        }else{
            //设置起始点 或者 结束点
            node.viewTpye = _chooseNodeView.viewTpye;
            if(node.viewTpye == OONodeViewTypeStart){
                _startNodeView = node;
                _starPoint = @[@(node.x),@(node.y)];
            }else if(node.viewTpye == OONodeViewTypeEnd){
                _endPoint = @[@(node.x),@(node.y)];
                _endNodeView = node;
            }
            //ggxc
            [self updatePointDistance];
            _chooseNodeView.viewTpye = OONodeViewTypeNone;
            _chooseNodeView = nil;
        }
    }else{
        //如果之前没有
        if(node.viewTpye == OONodeViewTypeStart){
            node.viewState = OONodeViewStateChoose;
            _chooseNodeView = node;
        }else if(node.viewTpye == OONodeViewTypeEnd){
            node.viewState = OONodeViewStateChoose;
            _chooseNodeView = node;
        }
    }
}
*/
//复制图片
- (UIImageView *)customSnapshoFromView:(UIView *)inputView {
    // 用cell的图层生成UIImage，方便一会显示
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 自定义这个快照的样子（下面的一些参数可以自己随意设置）
    UIImageView * snapview = [[UIImageView alloc] initWithImage:image];
    snapview.layer.masksToBounds = NO;
    snapview.layer.cornerRadius = 0.0;
    snapview.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapview.layer.shadowRadius = 5.0;
    snapview.layer.shadowOpacity = 0.4;
    snapview.alpha = 0.8;
    snapview.tag = inputView.tag;
    return snapview;
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
        if([self deathWarrantToPlayer:player NewWall:wall]){
            return NO;
        }
    }
    return YES;
}

//判断某个墙是否会把某个player封死
- (BOOL)deathWarrantToPlayer:(OOpalyer*)player NewWall:(OOWall*)newwall{
    //清空搜索数据
    [player resetSearchWay];
    NSMutableArray*arr = [NSMutableArray arrayWithArray:_chessboard.wallPointArray];
    if(newwall.wallType == OOWallTypehorizontal){
        [arr addObject: @[@(newwall.x),@(newwall.y+0.5)]];
        [arr addObject: @[@(newwall.x+1),@(newwall.y+0.5)]];
    }else{
        [arr addObject: @[@(newwall.x+0.5),@(newwall.y)]];
        [arr addObject: @[@(newwall.x+0.5),@(newwall.y+1)]];
    }
    
    while (true) {
        OONode* _nearestPoint = player.nearestPoint;
        NSMutableArray*_neighboar = [self neighboarWithPoint:player.nearestPoint WallPoints:arr Play:player];
        [player.neighborArray removeObject:player.nearestPoint];
        [player.neighborArray addObjectsFromArray:_neighboar];
        [player.searchedArray addObject:_nearestPoint];
        //如果_neighborArray 为空 表示所有搜索都搜索到了。。
        if(player.neighborArray.count==0){
            _findendPoint = NO;
//            [self endSearch];
            return YES;
        }
        player.nearestPoint = [self getNearestPointInNeighboar:player];
        if(player.endType == 0 && _nearestPoint.y == MaxY-1){
            _findendPoint = YES;
//            [self endSearch];
            return NO;
        }else if(player.endType == 1 && _nearestPoint.y == 0){
            _findendPoint = YES;
            return NO;
        }
//        break;
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
