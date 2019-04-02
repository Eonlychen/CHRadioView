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
    
    radioView.backgroundColorNormal = UIColor.yellowColor;
    radioView.backgroundColorSelected = UIColor.redColor;
    radioView.titleFontNormal = 12;
    radioView.titleFontSelected = 16;
    radioView.titleColorNormal = UIColor.blueColor;
    radioView.titleColorSelected = UIColor.greenColor;
    
//    // 重新设置itemsize的代码，如果没有 不要调用set方法
//    [radioView setItemSizeBlock:^CGSize(UICollectionViewLayout * _Nonnull layout, NSIndexPath * _Nonnull indexPath) {
//        return CGSizeMake(100, 60);
//    }];
    [radioView setSelectedItemBlock:^(NSString * _Nonnull title, NSString * _Nonnull imageNormal, NSString * _Nonnull imageSelected, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"title:%@ ,imageNormal:%@,imageSelected:%@",title,imageNormal,imageSelected);
    }];
    
    [self.view addSubview:radioView];

}


@end
