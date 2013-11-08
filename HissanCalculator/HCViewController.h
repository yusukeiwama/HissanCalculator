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
}

/** 筆算を表示するViewのベースとなる部分 */
@property (weak, nonatomic) IBOutlet UIView *baseView;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@property (weak, nonatomic) IBOutlet UIButton *functionButton;

@end
