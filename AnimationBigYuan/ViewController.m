//
//  ViewController.m
//  AnimationBigYuan
//
//  Created by xiaoyu on 15/11/9.
//  Copyright © 2015年 guoda. All rights reserved.
//

#import "ViewController.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height


#define SNOW_IMAGENAME         @"unlike"

#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height

#define IMAGE_X                arc4random()%(int)Main_Screen_Width
#define IMAGE_ALPHA            ((float)(arc4random()%10))/10
#define IMAGE_WIDTH            arc4random()%20 + 10
#define PLUS_HEIGHT            Main_Screen_Height/25

#define IMAGENAMED(NAME)        [UIImage imageNamed:NAME]

@interface ViewController ()
{

    NSMutableArray *_imagesArray;
}
@property (nonatomic, strong) UIImageView *heartImg;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _heartImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, 50, 50)];
    _heartImg.image = [UIImage imageNamed:@"23032"];
    [self.view addSubview:_heartImg];
    [self tiaodong];
    
//    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(45, 120, 50, 20)];
//    label1.text = @"大白";
//    [self.view addSubview:label1];
//    
//    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH-80, 120, 50, 20)];
//    label2.text = @"大雨";
//    [self.view addSubview:label2];

    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    image.contentMode = UIViewContentModeScaleToFill;
    image.image = [UIImage imageNamed:@"daxiong"];
    [self.view addSubview:image];
    [self.view sendSubviewToBack:image];
    
    
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(30, 120, 80, 80)];
    image1.image = [UIImage imageNamed:@"dabai"];
    [self.view addSubview:image1];
    
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH-120, image1.frame.origin.y, 80, 80)];
    image2.image = [UIImage imageNamed:@"dayu"];
    [self.view addSubview:image2];
    
    //下雪
    [self startDownSnow];
    
}
#pragma mark - 下雪
- (void)startDownSnow {
    _imagesArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 20; ++ i) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:IMAGENAMED(SNOW_IMAGENAME)];
        float x = IMAGE_WIDTH;
        imageView.frame = CGRectMake(IMAGE_X, -30, x, x);
        imageView.alpha = IMAGE_ALPHA;
        [self.view addSubview:imageView];
        [_imagesArray addObject:imageView];
    }
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(makeSnow) userInfo:nil repeats:YES];

}
static int i = 0;
- (void)makeSnow
{
    i = i + 1;
    if ([_imagesArray count] > 0) {
        UIImageView *imageView = [_imagesArray objectAtIndex:0];
        imageView.tag = i;
        [_imagesArray removeObjectAtIndex:0];
//        NSLog(@"%lu",_imagesArray.count);
        [self snowFall:imageView];
    }

}

- (void)snowFall:(UIImageView *)aImageView
{
    [UIView beginAnimations:[NSString stringWithFormat:@"%lu",aImageView.tag] context:nil];
    [UIView setAnimationDuration:6];
    [UIView setAnimationDelegate:self];
    aImageView.frame = CGRectMake(aImageView.frame.origin.x, Main_Screen_Height, aImageView.frame.size.width, aImageView.frame.size.height);
    //    NSLog(@"%@",aImageView);
    [UIView commitAnimations];
}

- (void)addImage
{
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:[animationID intValue]];
    float x = IMAGE_WIDTH;
    imageView.frame = CGRectMake(IMAGE_X, -30, x, x);
    [_imagesArray addObject:imageView];
}

#pragma mark - 心动画
- (void)tiaodong {

    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef aPath = CGPathCreateMutable();
    CGPathMoveToPoint(aPath, nil, 45, 120);
    
    CGPathAddCurveToPoint(aPath, nil, 100, 60, SCREENWIDTH/2, 0, SCREENWIDTH - 60, 120);
    animation.path = aPath;
    CGPathRelease(aPath);
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.rotationMode = @"auto";

    CAKeyframeAnimation *animation1 =[CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation1.values = @[@1, @1.1, @0.9, @1.1, @1,@1, @1.1, @0.9, @1.1, @1];
    animation1.removedOnCompletion = false;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:animation1,animation, nil];
    animGroup.duration = 3;
    animGroup.repeatCount = 1000000;
    
    [_heartImg.layer addAnimation:animGroup forKey:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
