//
//  CHRadioView.h
//  gxyChanxueyan
//
//  Created by guxiangyun on 2019/4/1.
//  Copyright © 2019 chenran. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CHRadioCell;
@class CCRadioModel;

typedef CGSize(^CHRadioViewItemSizeBlock) (UICollectionViewLayout *layout, NSIndexPath *indexPath);
typedef void(^CHRadioViewConfigCellBlock) (CHRadioCell *cell,CCRadioModel *model, NSIndexPath *indexPath);
typedef void(^CHRadioViewSelectedItemBlock) (NSString *title, NSString *imageNormal, NSString *imageSelected, NSIndexPath *indexPath);

@interface CHRadioView : UIView

/** 设置每个item的大小 (宽高同时大于30) */
@property (nonatomic, copy) CHRadioViewItemSizeBlock itemSizeBlock;
/** 配置数据源与展示 */
@property (nonatomic, copy) CHRadioViewConfigCellBlock configCellBlock;
/** 选中item事件 */
@property (nonatomic, copy) CHRadioViewSelectedItemBlock selectedItemBlock;

/** 选中单元格 (默认0，item 0...) */
@property (nonatomic) NSInteger selectItem;
/** 一横排展示个数 （默认为3）*/
@property (nonatomic, assign) NSInteger rowShowCount;

/** 选中item背景颜色 (默认clear)*/
@property (nonatomic, strong) UIColor *backgroundColorSelected;
/** 正常item背景颜色 （默认clear）*/
@property (nonatomic, strong) UIColor *backgroundColorNormal;
/** 选中item字体颜色 (默认blue)*/
@property (nonatomic, strong) UIColor *titleColorSelected;
/** 正常item字体颜色 （默认darkGrayColor）*/
@property (nonatomic, strong) UIColor *titleColorNormal;
/** 选中item字体大小 （默认14） */
@property (nonatomic) CGFloat titleFontSelected;
/** 正常item字体大小 （默认14） */
@property (nonatomic) CGFloat titleFontNormal;




/**
 唯一初始化
 
 @param titles 标题数据源
 @param imagesNormal 默认图片显示数据源
 @param imagesSelected 选中图片显示数据源， 如果nil 或者@[],则使用imageNormal的数据；
 @param frame frame必须设置
 @return self
 */
+ (CHRadioView *)showRadioViewWithTitles:(NSArray *)titles
                            imagesNormal:(NSArray *)imagesNormal
                          imagesSelected:(nullable NSArray *)imagesSelected
                                   frame:(CGRect)frame;

/**
 刷新数据
 */
- (void)reloadData;
@end

@interface CHRadioCell : UICollectionViewCell
/** image */
@property (nonatomic, strong) UIImageView *imageView;
/** title */
@property (nonatomic, strong) UILabel *titleLabel;
@end


@interface CCRadioModel : NSObject
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 默认图片 */
@property (nonatomic, copy) NSString *imageNormal;
/** 选中图片 */
@property (nonatomic, copy) NSString *imageSelected;
/** 记录选中与否 */
@property (nonatomic, assign) BOOL selected;

@end

NS_ASSUME_NONNULL_END
