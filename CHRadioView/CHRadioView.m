//
//  CHRadioView.m
//  gxyChanxueyan
//
//  Created by guxiangyun on 2019/4/1.
//  Copyright © 2019 chenran. All rights reserved.
//

#import "CHRadioView.h"

@interface CHRadioView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
/** 简单布局 */
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/** collectionView */
@property (nonatomic, strong) UICollectionView *collectionView;
/** dataArray */
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
@implementation CHRadioView

#pragma mark -- public
+ (CHRadioView *)showRadioViewWithTitles:(NSArray *)titles
                            imagesNormal:(NSArray *)imagesNormal
                          imagesSelected:(NSArray *)imagesSelected
                                   frame:(CGRect)frame {
    CHRadioView *radioView = [[CHRadioView alloc] initWithFrame:frame];
    imagesSelected = (imagesSelected == nil || imagesSelected.count == 0) ? imagesNormal : imagesSelected ;
    for (int i = 0; i < titles.count; i++) {
        CCRadioModel *model = [[CCRadioModel alloc] init];
        model.title = titles[i];
        model.imageNormal = imagesNormal[i];
        model.imageSelected= imagesSelected[i];
        model.selected = false;
        [radioView.dataArray addObject:model];
    }
    [radioView addSubview:radioView.collectionView];
    [radioView setDefaultSetting];
    return radioView;
}

- (void)reloadData {
    self.collectionView.collectionViewLayout = self.flowLayout;
    [self.collectionView reloadData];
}

#pragma mark -- private
- (void)setDefaultSetting {
    // 默认选中第一个
    [self setSelectItem:0];

    // 默认一横排展示个数
    self.rowShowCount = 3;
    
    self.titleFontSelected = 14;
    self.titleFontNormal = 14;
    self.backgroundColorSelected = UIColor.clearColor;
    self.backgroundColorNormal = UIColor.clearColor;
    self.titleColorSelected = UIColor.blueColor;
    self.titleColorNormal = UIColor.darkGrayColor;
}


#pragma mark -- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.itemSizeBlock) {
        return self.itemSizeBlock(collectionViewLayout,indexPath);
    }
    
    if (self.dataArray.count > self.rowShowCount) {
        return CGSizeMake(self.frame.size.width/self.rowShowCount, self.frame.size.height);
    }else {
        return CGSizeMake(self.frame.size.width/self.dataArray.count, self.frame.size.height);
    }
}
#pragma mark -- UICollectionViewDataSource,UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {\
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CHRadioCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CHRadioCell" forIndexPath:indexPath];
    CCRadioModel *model = self.dataArray[indexPath.row];
    cell.titleLabel.text = model.title;
    if (model.selected) {
        cell.backgroundColor = self.backgroundColorSelected;
        cell.titleLabel.font = [UIFont systemFontOfSize:self.titleFontSelected];
        cell.titleLabel.textColor = self.titleColorSelected;
        cell.imageView.image  = [UIImage imageNamed:model.imageSelected];
        [collectionView selectItemAtIndexPath:indexPath animated:true scrollPosition:(UICollectionViewScrollPositionCenteredHorizontally)];
    }else {
        cell.backgroundColor = self.backgroundColorNormal;
        cell.titleLabel.font = [UIFont systemFontOfSize:self.titleFontNormal];
        cell.titleLabel.textColor = self.titleColorNormal;
        cell.imageView.image  = [UIImage imageNamed:model.imageNormal];
    }
    if (self.configCellBlock) {
        self.configCellBlock(cell, model, indexPath);
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:true];
    [self setSelectItem:indexPath.row];
    CCRadioModel *model = self.dataArray[indexPath.row];
    NSString *title = model.title;
    NSString *imageNormal = model.imageNormal;
    NSString *imageSelected = model.imageSelected;
    if (self.selectedItemBlock) {
        self.selectedItemBlock(title,imageNormal,imageSelected, indexPath);
    }
}

#pragma mark -- setter
- (void)setSelectItem:(NSInteger)selectItem {
    if (selectItem < self.dataArray.count) {
        _selectItem = selectItem;
        NSInteger index = 0;
        for (CCRadioModel *model in self.dataArray) {
            model.selected = index == selectItem;
            index++;
        }
        [self reloadData];
    }
}

#pragma mark -- getter
- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [UICollectionViewFlowLayout.alloc init];
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumInteritemSpacing = 0;
        _flowLayout.minimumLineSpacing = 0;
    }
    return _flowLayout;
}
- (UICollectionView *)collectionView  {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor= UIColor.whiteColor;
        _collectionView.dataSource = self;
        _collectionView.delegate= self;
        _collectionView.showsVerticalScrollIndicator = false;
        _collectionView.showsHorizontalScrollIndicator = false;
        _collectionView.pagingEnabled = true;
        [_collectionView registerClass:CHRadioCell.class forCellWithReuseIdentifier:@"CHRadioCell"];
    }
    return _collectionView;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = NSMutableArray.array;
    }
    return _dataArray;
}

@end


@interface CHRadioCell ()

@end

@implementation CHRadioCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat margin = 2;
        CGFloat labelHeight = 16;
        CGFloat final = (frame.size.width > frame.size.height) ? frame.size.height-margin-labelHeight : frame.size.width-margin-labelHeight;
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, margin, final, final)];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-labelHeight-margin, frame.size.width, labelHeight)];
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        
        self.imageView.center = CGPointMake(self.contentView.center.x, self.contentView.center.y-(2*margin+labelHeight)/2);
        self.imageView.contentMode = UIViewContentModeCenter;
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end

@implementation CCRadioModel


@end
