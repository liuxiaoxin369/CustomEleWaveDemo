//
//  WaveView.m
//  CustomEleWaveDemo
//
//  Created by qzwh on 2018/3/28.
//  Copyright © 2018年 qzwh. All rights reserved.
//

#import "WaveView.h"

#define WaveColor1 [UIColor colorWithRed:136/255.0f green:199/255.0f blue:190/255.0f alpha:1]
#define WaveColor2 [UIColor colorWithRed:28/255.0 green:203/255.0 blue:174/255.0 alpha:1]

@interface WaveView ()
@property (nonatomic, strong) CAShapeLayer *waveLayer1;
@property (nonatomic, strong) CAShapeLayer *waveLayer2;
@property (nonatomic, strong) CADisplayLink *disPlayLink;
@end

@implementation WaveView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureInitData]; //配置初始数据
        [self createUI]; //创建视图
    }
    return self;
}

- (void)createUI {
    self.disPlayLink.paused = NO;
    [self.layer addSublayer:self.waveLayer1];
    [self.layer addSublayer:self.waveLayer2];
}

- (void)configureInitData {
    //振幅
    self.waveAmplitude = 30;
    
    //角速度
    self.wavePalstance = M_PI/self.bounds.size.width;
    
    //偏距
    self.waveY = self.bounds.size.height;
    
    //初相
    self.waveX = 0;
    
    //x轴移动速度
    self.waveMoveSpeed = self.wavePalstance * 4;
}

- (void)handleUpdateWaveAction:(CADisplayLink *)displayLink {
    self.waveX += self.waveMoveSpeed;
    
    [self updateWaveY];
    [self updateWave1];
    [self updateWave2];
}

- (void)updateWaveY {
    CGFloat targetY = self.bounds.size.height - self.progress * self.bounds.size.height;
    if (self.waveY < targetY) {
        self.waveY += 2;
    }
    if (self.waveY > targetY ) {
        self.waveY -= 2;
    }
}

- (void)updateWave1 {
    //波浪宽度
    CGFloat waterWaveWidth = self.bounds.size.width;
    //初始化运动路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置起始位置
    CGPathMoveToPoint(path, nil, 0, self.waveY);
    //初始化波浪y为偏距
    CGFloat y = self.waveY;
    //余弦曲线公式: y=Asin(ωx+φ)+k
    for (float x = 0.0f; x <= waterWaveWidth; x++) {
        y = self.waveAmplitude * cos(self.wavePalstance * x + self.waveX) + self.waveY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    //填充底部颜色
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathCloseSubpath(path);
    self.waveLayer1.path = path;
    CGPathRelease(path);
}

- (void)updateWave2 {
    //波浪宽度
    CGFloat waterWaveWidth = self.bounds.size.width;
    //初始化运动路径
    CGMutablePathRef path = CGPathCreateMutable();
    //设置起始位置
    CGPathMoveToPoint(path, nil, 0, self.waveY);
    //初始化波浪y为偏距
    CGFloat y = self.waveY;
    //正弦曲线公式为： y=Asin(ωx+φ)+k;
    for (float x = 0.0f; x <= waterWaveWidth ; x++) {
        y = self.waveAmplitude * sin(self.wavePalstance * x + self.waveX) + self.waveY;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    //添加终点路径、填充底部颜色
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.bounds.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.bounds.size.height);
    CGPathCloseSubpath(path);
    self.waveLayer2.path = path;
    CGPathRelease(path);
}

- (CAShapeLayer *)waveLayer1 {
    if (!_waveLayer1) {
        _waveLayer1 = [CAShapeLayer layer];
        _waveLayer1.fillColor = WaveColor1.CGColor;
        _waveLayer1.strokeColor = WaveColor1.CGColor;
    }
    return _waveLayer1;
}

- (CAShapeLayer *)waveLayer2 {
    if (!_waveLayer2) {
        _waveLayer2 = [CAShapeLayer layer];
        _waveLayer2.fillColor = [WaveColor2 colorWithAlphaComponent:0.9].CGColor;
        _waveLayer2.strokeColor = [WaveColor2 colorWithAlphaComponent:0.9].CGColor;
    }
    return _waveLayer2;
}

- (CADisplayLink *)disPlayLink {
    if (!_disPlayLink) {
        _disPlayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleUpdateWaveAction:)];
        [_disPlayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _disPlayLink;
}

@end
