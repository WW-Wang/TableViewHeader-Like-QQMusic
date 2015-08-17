//
//  Created by Alberto Pasca on 27/02/14.
//  Copyright (c) 2014 albertopasca.it. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @brief 圆角button，支持各种方向的圆角
 */
@interface DCRoundedButton : UIButton

/// 圆角类型
@property (nonatomic, assign) int style;

/// button的标题
@property (nonatomic, retain) IBOutlet UILabel *label;

@end
