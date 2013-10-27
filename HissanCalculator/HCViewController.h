//
//  HCViewController.h
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/6/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HCCreateFomulaState.h"
#import "HCCalculationState.h"
#import "HCHissanView.h"

/**
 画面のコントローラ。ボタンアクションなどの管理を行う。
 */

@interface HCViewController : UIViewController {
	id<HCState> state;
	UIView *inputView;
	UIView *calculateView;
}

/** 入力内容を消去するボタンアクション */
- (IBAction)clearButton:	(id)sender;

/** 状態に応じて機能を変えるボタンアクション */
- (IBAction)functionButton:(id)sender;

/** 数字を入力するためのボタンのコレクション */
@property (strong, nonatomic)	IBOutletCollection(UIButton) NSArray *numberKeyButtons;

/** 筆算を表示するViewのベースとなる部分 */
@property (weak, nonatomic) IBOutlet UIView *baseView;

/** 消去ボタン */
@property (weak, nonatomic)	IBOutlet UIButton		*clearButton;

/** 計算ボタン */
@property (weak, nonatomic)	IBOutlet UIButton		*functionButton;



@end
