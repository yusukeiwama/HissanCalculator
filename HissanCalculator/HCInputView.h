//
//  HCInputView.h
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/27/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

/**
 計算する内容を入力していくView
 
 入力終了と同時にCalculateViewと入れ替わる
 */

@interface HCInputView : UIView

/** 指示文 **/
@property UILabel *descriptionLabel;

/** 最初に入力する数字 **/
@property UILabel *aboveIntegerLabel;

/** 後に入力する数字 **/
@property UILabel *belowIntegerLabel;

/** 演算子の選択のView **/
@property UIView *operatorSelectorView;

/** 選択確定後の演算子表示ラベル **/
@property UILabel	*operatorLabel;

@property NSMutableArray *buttons;

@property CGRect operatorSelecterViewDefaultPosition;
@property NSMutableArray *operatorSelectButtonDefaultPositions;


/** 入力状態を反映するViewを整形 */
- (void)arrangeInputView;

/** Viewを初期化 */
- (void)resetOperatorView;

/** 演算子選択用のViewを拡大 */
- (void)expandOperatorSelectView;

@end
