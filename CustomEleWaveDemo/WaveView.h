//
//  WaveView.h
//  CustomEleWaveDemo
//
//  Created by qzwh on 2018/3/28.
//  Copyright © 2018年 qzwh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaveView : UIView

//当前所占视图百分比
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, assign) CGFloat waveAmplitude; //曲线的振幅
@property (nonatomic, assign) CGFloat wavePalstance; //曲线的角速度
@property (nonatomic, assign) CGFloat waveX; //曲线的初相
@property (nonatomic, assign) CGFloat waveY; //曲线的偏距
@property (nonatomic, assign) CGFloat waveMoveSpeed; //曲线的移动速度

@end
