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
 画面のコントローラ。ボタンアクションなどの管理や、
 ユーザ入力による計算の表示の制御を行う。
 */

@interface HCViewController : UIViewController {
	HCInputView *inputView;
	HCCalculateView *calculateView;
}

/** 筆算を表示するViewのベースとなる部分 */
@property (weak, nonatomic) IBOutlet UIView *baseView;

/** 入力を受け付けるインターフェースをまとめたもの */
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

/** 入力確定や計算を行うボタン 動的に機能が変化するので、プロパティとして持たせる */
@property (weak, nonatomic) IBOutlet UIButton *functionButton;

@end
