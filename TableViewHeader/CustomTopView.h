//
//  CustomTopView.h
//  HFStretchableTableHeaderViewDemo
//
//  Created by admin.konnech on 4/25/15.
//  Copyright (c) 2015 Hendrik Frahmann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DCRoundedButton.h"
#import "DCDateCircleView.h"

#define isiPad [ [ UIDevice currentDevice ] userInterfaceIdiom ] == UIUserInterfaceIdiomPad

#define kStatusBarOrientation ([[UIApplication sharedApplication] statusBarOrientation])

typedef void(^AddressButton)(DCRoundedButton *button);
typedef void(^ElectionButton)(DCRoundedButton *button);

@interface CustomTopView : UIView

@property (weak, nonatomic) IBOutlet DCRoundedButton *addressButton;
@property (weak, nonatomic) IBOutlet DCRoundedButton *electionButton;
@property (weak, nonatomic) IBOutlet DCDateCircleView *dateView;
@property (strong, nonatomic) AddressButton addressButtonBlock;
@property (strong, nonatomic) ElectionButton electionButtonBlock;

@end
