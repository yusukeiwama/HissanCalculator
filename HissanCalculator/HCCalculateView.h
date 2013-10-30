//
//  HCCalculateView.h
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/28/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 計算過程を表示、または入力受付するView
 
 InputViewの入力終了と同時に現れる。
 */

@interface HCCalculateView : UIView

/** 表示するラベルを格納しておく*/
@property NSMutableArray *labels;

- (void)arrangeCalculateViewWithAbove:(NSInteger)aboveInteger WithBelow:(NSInteger)belowInteger WithOperator:(NSString *)operatorString;

@end
