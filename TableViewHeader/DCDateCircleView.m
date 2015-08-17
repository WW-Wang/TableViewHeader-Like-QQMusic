//
//  DCDateCircleView.m
//  Vote4DC
//
//  Created by apple on 12/7/14.
//  Copyright (c) 2014 Konnech Inc'. All rights reserved.
//

#import "DCDateCircleView.h"


/// 所有label的字体名称
static NSString *frontName = @"Arial Rounded MT Bold";

@interface DCDateCircleView()

@property (nonatomic, strong) CALayer *layerShadow;

@end

@implementation DCDateCircleView
- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    if (![self.subviews count])
    {
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSArray *loadedViews = [mainBundle loadNibNamed:@"DCDataCircleView" owner:nil options:nil];
        UIView *loadedView = [loadedViews firstObject];
        
        loadedView.frame = self.frame;
        loadedView.autoresizingMask = self.autoresizingMask;
        loadedView.translatesAutoresizingMaskIntoConstraints =
        self.translatesAutoresizingMaskIntoConstraints;
        
        for (NSLayoutConstraint *constraint in self.constraints)
        {
            id firstItem = constraint.firstItem;
            if (firstItem == self)
            {
                firstItem = loadedView;
            }
            id secondItem = constraint.secondItem;
            if (secondItem == self)
            {
                secondItem = loadedView;
            }
            [loadedView addConstraint:
             [NSLayoutConstraint constraintWithItem:firstItem
                                          attribute:constraint.firstAttribute
                                          relatedBy:constraint.relation
                                             toItem:secondItem
                                          attribute:constraint.secondAttribute
                                         multiplier:constraint.multiplier
                                           constant:constraint.constant]];
        }
        
        return loadedView;
    }
    return self;
}
/**
 *  @brief 系统drawRect: 定义 年 月分 日期 星期的Label的各项属性，并添加到视图中
 */
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    self.monthLabel.textColor = self.boarderColor;
    self.monthLabel.accessibilityElementsHidden = YES;
    
    self.weekLabel.textColor = self.boarderColor;
    self.weekLabel.accessibilityElementsHidden = YES;
    
    self.dayLabel.textAlignment = NSTextAlignmentCenter;
    self.dayLabel.textColor = self.boarderColor;
    self.dayLabel.accessibilityElementsHidden = YES;
    self.dayLabel.layer.borderColor = self.boarderColor.CGColor;
    self.dayLabel.layer.borderWidth = self.boarderWidth;
    
    self.yearLabel.textColor = self.boarderColor;
    self.yearLabel.textAlignment = NSTextAlignmentCenter;
    self.yearLabel.accessibilityElementsHidden = YES;
    
    
    self.dayLabel.layer.cornerRadius = self.dayLabel.bounds.size.width / 2;

}

/**
 *  @brief 边框颜色的get方法
 */
- (UIColor *)boarderColor
{
    if (!_boarderColor) {
        _boarderColor = [UIColor blackColor];
    }
    return _boarderColor;
}

/**
 *  @brief 边框宽度的get方法
 */
- (double)boarderWidth
{
    if (!_boarderWidth) {
        _boarderWidth = 1;
    }
    return _boarderWidth;
}

- (void)fillDateStringWith:(NSMutableDictionary *)dateStringDic
{
    self.monthLabel.text = [dateStringDic valueForKey:@"month"];
    
    self.dayLabel.text = [dateStringDic valueForKey:@"day"];
    
    self.yearLabel.text = [dateStringDic valueForKey:@"year"];
    
    self.weekLabel.text = [dateStringDic valueForKey:@"week"];
}

///**
// *  @brief 月份Label的get方法
// */
//- (UILabel *)monthLabel
//{
//    if (!_monthLabel) {
//        _monthLabel = [[UILabel alloc] init];
//    }
//    return  _monthLabel;
//}
//
///**
// *  @brief 日期Label的get方法
// */
//- (UILabel *)dayLabel
//{
//    if (!_dayLabel) {
//        _dayLabel = [[UILabel alloc] init];
//    }
//    return _dayLabel;
//}
//
///**
// *  @brief 星期Label的get方法
// */
//- (UILabel *)weekLabel
//{
//    if (!_weekLabel) {
//        _weekLabel = [[UILabel alloc] init];
//    }
//    return _weekLabel;
//}
//
///**
// *  @brief 年Label的get方法
// */
//- (UILabel *)yearLabel
//{
//    if (!_yearLabel) {
//        _yearLabel = [[UILabel alloc] init];
//    }
//    return _yearLabel;
//}

@end
