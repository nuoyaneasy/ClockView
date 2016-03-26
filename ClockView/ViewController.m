//
//  ViewController.m
//  ClockView
//
//  Created by Yang Chao on 3/26/16.
//  Copyright © 2016 Self. All rights reserved.
//

#import "ViewController.h"

#define radianPerSecond 6
#define radianPerMinute 6
#define radianPerhour   30
// 每分钟时针转6度
#define perMinuteHourA 0.5

#define angle2radian(x) ((x) / 180 * M_PI)

@interface ViewController ()
 
@property (weak, nonatomic) IBOutlet UIImageView *clockView;
@property (strong, nonatomic) CALayer *secondHandLayer;
@property (strong, nonatomic) CALayer *minuteHandLayer;
@property (strong, nonatomic) CALayer *hourHandLayer;

@end

@implementation ViewController

#pragma mark - Properties

- (CALayer *)secondHandLayer
{
    if (!_secondHandLayer) {
        _secondHandLayer = [CALayer layer];
    }
    return _secondHandLayer;
}

- (CALayer *)minuteHandLayer
{
    if (!_minuteHandLayer) {
        _minuteHandLayer = [CALayer layer];
    }
    return _minuteHandLayer;
}

- (CALayer *)hourHandLayer
{
    if (!_hourHandLayer) {
        _hourHandLayer = [CALayer layer];
    }
    return _hourHandLayer;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addClockHands];
    [self setClockTimer];
    [self animateClockHands];
}

#pragma mark - Overriden

#pragma mark - Private Methods


- (NSMutableArray *)clockHandsLayers {
    NSMutableArray *clockHands = [NSMutableArray array];
    [clockHands addObject:self.secondHandLayer];
    [clockHands addObject:self.minuteHandLayer];
    [clockHands addObject:self.hourHandLayer];
    
    return clockHands;
    
}
- (void)addClockHands {
    
    //CGFloat clockW = self.clockView.bounds.size.width;
    CGFloat clockH = self. clockView.bounds.size.height;
    
    CGPoint clockCenter = [self.clockView convertPoint:self.clockView.center fromView:self.view];
    
    NSMutableArray *layers = [self clockHandsLayers];
    
    for (CALayer *layer in layers) {
        layer.anchorPoint = CGPointMake(0.5, 1.0);
        layer.position = clockCenter;
        layer.backgroundColor = [UIColor blackColor].CGColor;
        [self.clockView.layer addSublayer:layer];
        layer.cornerRadius = 4;
    }
    //3.设置位置
    self.secondHandLayer.bounds = CGRectMake(0, 0, 2, clockH * 0.5 - 30);
    self.minuteHandLayer.bounds = CGRectMake(0, 0, 3, clockH * 0.5 - 40);
    self.hourHandLayer.bounds = CGRectMake(0, 0, 4, clockH * 0.5 - 50);

    [self.clockView.layer addSublayer:self.secondHandLayer];
}

- (NSDateComponents *)currentTimeComponents {
    //获取秒数
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour fromDate:[NSDate date]];
    return components;
}

- (void)setClockTimer {
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(animateClockHands) userInfo:nil repeats:YES];
}

- (void)animateClockHands {
    
    NSDateComponents *components = [self currentTimeComponents];
    CGFloat second = components.second;
    CGFloat minute = components.minute;
    CGFloat hour   = components.hour;
    
    CGFloat secondA = second * radianPerSecond;
    CGFloat minuteA = minute * radianPerMinute;
    CGFloat hourA   = hour * radianPerhour;
    hourA += minute * perMinuteHourA;
    
    self.secondHandLayer.transform = CATransform3DMakeRotation(angle2radian(secondA), 0, 0, 1);
    self.minuteHandLayer.transform = CATransform3DMakeRotation(angle2radian(minuteA), 0, 0, 1);
    self.hourHandLayer.transform   = CATransform3DMakeRotation(angle2radian(hourA), 0, 0, 1);
}

@end
