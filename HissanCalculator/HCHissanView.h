//
//  HCHissanView.h
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/15/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "HCCreateFomulaState.h"
#import "HCCalculationState.h"

/**
 筆算の計算式を出力するViewである。
 
 Stateパターンで場合分けし、表示方式を変える。
 StateパターンのContextにあたる。
 */

@interface HCHissanView : UIView {
	NSInteger margin;

}

@property UILabel *leftIntegerLabel;
@property UILabel *rightIntegerLabel;
@property UIView *operatorSelectorView;
@property UILabel	*operatorLabel;

@property NSInteger downSpace;

/** 表示するラベルを格納しておく*/
@property NSMutableArray *labels;

/** Viewの状態を示す。 HCState で実現する。*/
@property HCCreateFomulaState *state;

/** 数式入力のViewを生成*/
- (void)arrangeInputView;

/** 計算結果を表示するViewを生成*/
- (void)arrangeHissanView;

@end
