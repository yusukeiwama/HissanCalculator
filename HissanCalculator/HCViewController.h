//
//  HCViewController.h
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/6/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCInputView.h"
#import "HCCalculateView.h"

/**
 画面のコントローラ。ボタンアクションなどの管理を行う。
 */

@interface HCViewController : UIViewController {
	HCInputView *inputView;
	HCCalculateView *calculateView;
	NSString *operatorString;
}

/** 数字を入力するためのボタンのコレクション */
@property (strong, nonatomic)	IBOutletCollection(UIButton) NSArray *numberKeyButtons;
/** 筆算を表示するViewのベースとなる部分 */
@property (weak, nonatomic) IBOutlet UIView *baseView;
/** 消去ボタン */
@property (weak, nonatomic)	IBOutlet UIButton	*allClearButton;
/** 多機能ボタン */
@property (weak, nonatomic)	IBOutlet UIButton	*functionButton;

/** 入力内容をひとつ消去するボタンアクション */
- (IBAction)clearButtonAction:(id)sender;
/** 入力内容をすべて消去するボタンアクション */
- (IBAction)allClearButtonAction:(id)sender;
/** 状態に応じて機能を変えるボタンアクション */
- (IBAction)functionButtonAction:(id)sender;

@end
