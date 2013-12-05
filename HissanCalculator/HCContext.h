//
//  HCContextForInput.h
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 11/5/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

/** Context Class
 初期状態でインスタンス生成した状態変数(オブジェクト)をもつ。
 */

#import <Foundation/Foundation.h>
#import "HCState.h"

@interface HCContext : NSObject

/** 現在の状態 */
@property id currentState;

/** ひとつ前の状態 */
@property id previousState;

/** 入力イベントにより状態を遷移する */
- (void)inputEvent:(NSInteger)identifier;

@end

/*
 inputEventはNSIntegerにより識別する。
 0 ~ 9 : その数字
 10 : Function Key
 11 : All Clear
 12 : Clear
*/