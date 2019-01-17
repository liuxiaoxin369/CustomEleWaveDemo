//
//  ViewController.m
//  CustomEleWaveDemo
//
//  Created by qzwh on 2018/3/28.
//  Copyright © 2018年 qzwh. All rights reserved.
//

#import "ViewController.h"
#import "WaveView.h"

#define kWaveWidth      200
#define kWaveHeight     400
#define kSliderWidth    300
#define kSliderHeight   30
#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (nonatomic, strong) WaveView *waveView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.waveView];
    
    UISlider *slider = [[UISlider alloc] initWithFrame:CGRectMake((kScreenWidth-kSliderWidth)/2, CGRectGetMaxY(self.waveView.frame)+30, kSliderWidth, kSliderHeight)];
    slider.maximumValue = 1;
    slider.minimumValue = 0;
    slider.minimumTrackTintColor = [UIColor redColor];
    [slider addTarget:self action:@selector(handleSliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slider];
}

- (void)handleSliderAction:(UISlider *)slider {
    self.waveView.progress = slider.value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (WaveView *)waveView {
    if (!_waveView) {
        _waveView = [[WaveView alloc] initWithFrame:CGRectMake((kScreenWidth-kWaveWidth)/2, (kScreenHeight-kWaveHeight)/2, kWaveWidth, kWaveHeight)];
        _waveView.layer.borderColor = [UIColor whiteColor].CGColor;
        _waveView.layer.borderWidth = 5;
        _waveView.layer.cornerRadius = 10;
        _waveView.layer.masksToBounds = YES;
        _waveView.progress = 0.5;
    }
    return _waveView;
}

@end
