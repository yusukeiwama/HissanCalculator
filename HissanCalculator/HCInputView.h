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

@interface HCInputView : UIView {
	NSInteger margin;
}

@property UIView *aLine;

@property UILabel *aboveIntegerLabel;
@property UILabel *belowIntegerLabel;
@property UIView *operatorSelectorView;
@property UILabel	*operatorLabel;

@property CGRect operatorSelecterViewDefaultPosition;
@property NSMutableArray *operatorSelectButtonDefaultPositions;

- (void)arrangeInputView;
- (void)resetOperatorView;
- (void)expandOperatorSelectView;

@end
