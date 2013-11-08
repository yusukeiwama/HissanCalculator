//
//  HCCalculateView.h
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/28/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 計算過程を表示するView
 
 InputViewの入力終了と同時に現れる。
 こちらは動的に生成する。
 */

@interface HCCalculateView : UIView

/** 一桁ずつ表示するラベルを格納しておく */
@property NSMutableArray *labels;

@property NSInteger rowMax;
@property NSInteger columnMax;

/** Viewを生成する */
- (void)arrangeCalculateViewWithAbove:(NSInteger)aboveInteger WithBelow:(NSInteger)belowInteger WithOperator:(NSString *)operatorString;

@end
