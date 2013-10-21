//
//  HCHissanView.h
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/15/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


/**
 筆算の計算式を出力するViewである。
 Stateパターンで場合分けし、表示方式を変える。
 StateパターンのContextにあたる。
 */

@interface HCHissanView : UIView

@property NSMutableArray *labels;

@end
