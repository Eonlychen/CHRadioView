//
//  ViewController.m
//  CHRadioView
//
//  Created by guxiangyun on 2019/4/2.
//  Copyright © 2019 chenran. All rights reserved.
//

#import "ViewController.h"
#import "CHRadioView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CHRadioView *radioView = [CHRadioView showRadioViewWithTitles: @[@"第一奖杯",@"第二奖杯",@"第三奖杯"] imagesNormal: @[@"cup-first",@"cup-second",@"cup-third"] imagesSelected:nil frame:CGRectMake(0, 200, CGRectGetWidth(self.view.frame), 80)];
    
    [self.view addSubview:radioView];


}


@end
