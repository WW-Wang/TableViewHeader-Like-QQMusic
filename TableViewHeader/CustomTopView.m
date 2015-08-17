//
//  CustomTopView.m
//  HFStretchableTableHeaderViewDemo
//
//  Created by admin.konnech on 4/25/15.
//  Copyright (c) 2015 Hendrik Frahmann. All rights reserved.
//

#import "CustomTopView.h"

typedef enum : NSUInteger {
    DCCurrentYear,
    DCCurrentMonth,
    DCCurrentDay,
    DCCurrentWeek,
    DCCurrentNil,
} DCCurrent;

@implementation CustomTopView

- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    if (![self.subviews count])
    {
        NSBundle *mainBundle = [NSBundle mainBundle];
        NSArray *loadedViews = [mainBundle loadNibNamed:@"CustomTopView" owner:nil options:nil];
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
- (IBAction)addressButtonClicked:(DCRoundedButton *)sender {
    if (self.addressButtonBlock) {
        self.addressButtonBlock(sender);
    }
}

- (IBAction)electionButtonClicked:(DCRoundedButton *)sender {
    if (self.electionButtonBlock) {
        self.electionButtonBlock(sender);
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    self.dateView.backgroundColor = [UIColor clearColor];
    [self.dateView fillDateStringWith:[self currentCalendarInfomationWithDate:[NSDate date]]];
    [self.dateView setNeedsDisplay];
    self.dateView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.addressButton.label.text = @"something input";
    self.addressButton.style = 6;
    self.addressButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.electionButton.label.text = @"something input";
    self.electionButton.style = 6;
    self.electionButton.translatesAutoresizingMaskIntoConstraints = NO;
    
}

- (NSMutableDictionary *)currentCalendarInfomationWithDate:(NSDate *)date
{
    //    UIDeviceOrientationLandscapeLeft,       // Device oriented horizontally, home button on the right
    //    UIDeviceOrientationLandscapeRight,
    NSArray *monthArray = @[@"0", @"Jan.", @"Feb.", @"Mar.", @"Apr.", @"May.", @"Jun.", @"Jul.", @"Aug.", @"Sep.", @"Oct.", @"Nov.", @"Dec."];
    NSArray *weekArray = @[@"0", @"Sun.", @"Mon.", @"Tue.", @"Wed.", @"Thu.", @"Fri.", @"Sat."];
    
    NSArray *monthIpadArray = @[@"0", @"January", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December"];
    NSArray *weekIpadArray = @[@"0", @"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    NSMutableDictionary *dateStringDic = [NSMutableDictionary dictionary];  // [month, day, year, week]
    
    // month
    NSInteger month = [dateComponent month];
    if (isiPad || (UIInterfaceOrientationIsLandscape(kStatusBarOrientation))) {
        [dateStringDic setValue:monthIpadArray[month] forKey:@"month"];
    } else {
        [dateStringDic setValue:monthArray[month] forKey:@"month"];
    }
    
    // day
    if ([dateComponent day] < 10) {
        [dateStringDic setValue:[NSString stringWithFormat:@"0%ld",(long)[dateComponent day]] forKey:@"day"];
    } else {
        [dateStringDic setValue:[NSString stringWithFormat:@"%ld",(long)[dateComponent day]] forKey:@"day"];
    }
    
    // year
    [dateStringDic setValue:[NSString stringWithFormat:@"%ld", (long)[dateComponent year]] forKey:@"year"];
    
    // week
    NSInteger week = [dateComponent weekday];
    if (isiPad || (UIInterfaceOrientationIsLandscape(kStatusBarOrientation))) {
        [dateStringDic setValue:weekIpadArray[week] forKey:@"week"];
    } else {
        [dateStringDic setValue:weekArray[week] forKey:@"week"];
    }
    
    return dateStringDic;
}

- (void)layoutIfNeeded
{
    [self.dateView layoutIfNeeded];
    [self drawRect:self.bounds];
}

@end
