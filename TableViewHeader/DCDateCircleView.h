//
//  DCDateCircleView.h
//  Vote4DC
//
//  Created by apple on 12/7/14.
//  Copyright (c) 2014 Konnech Inc'. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE

/**
 *  @brief iPhone设备中，votinginfo视图顶部的选举日期显示的View
 */
@interface DCDateCircleView : UIView

/// 日期Label边框颜色
@property (nonatomic, strong)IBInspectable UIColor *boarderColor;

/// 日期Label边框宽度
@property (nonatomic)IBInspectable double boarderWidth;

/// 月份Label
@property (nonatomic, strong)IBOutlet UILabel *monthLabel;

/// 日期Label
@property (nonatomic, strong)IBOutlet UILabel *dayLabel;

/// 星期Label
@property (nonatomic, strong)IBOutlet UILabel *weekLabel;

/// 年Label
@property (nonatomic, strong)IBOutlet UILabel *yearLabel;

- (void)fillDateStringWith:(NSMutableDictionary *)dateStringDic;

@end
