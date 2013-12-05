//
//  HCInputView.h
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/27/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 計算する内容を入力していくView
 
 入力終了と同時にCalculateViewと入れ替わる
 */

@interface HCInputView : UIView

@property UILabel *aboveIntegerLabel;
@property UILabel *belowIntegerLabel;
@property UIView *operatorSelectorView;
@property UILabel	*operatorLabel;

@property NSMutableArray *buttons;

@property CGRect operatorSelecterViewDefaultPosition;
@property NSMutableArray *operatorSelectButtonDefaultPositions;

@property UILabel *descriptionLabel;


/** 入力状態を反映するViewを整形 */
- (void)arrangeInputView;

/** Viewを初期化 */
- (void)resetOperatorView;

/** 演算子選択用のViewを拡大 */
- (void)expandOperatorSelectView;

@end
