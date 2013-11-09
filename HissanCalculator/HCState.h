//
//  HCStateForInput.h
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/9/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 デザインパターンの1つ、Stateパターンの実装。
 カテゴリにより実装している。
 */

@interface NSObject (HCState)
/** 更新処理を行い、次状態を返すメソッド
 
 返り値がid型となっているので、以下のようにして使う。
 
	state = [state getNextStateWithIdentifier:identifier];
 */
- (id)getNextStateWithIdentifier:(NSInteger)identifier;
@end

/** 筆算上で上の数字を入力している状態 */
@interface HCAboveNumberState : NSObject
@end

/** 筆算上で演算子の選択を行う状態 */
@interface HCSelectOperatorState : NSObject
@end

/** 筆算上で下の数字を入力している状態 */
@interface HCBelowNumberState : NSObject
@end

/** ユーザが答えを入力する状態 */
@interface HCUserAnswerState : NSObject
@end

/** 最終的な計算結果を表示する状態 */
@interface HCCalculateState : NSObject
@end


/*
 簡潔に記述するためにカテゴリを用いた実装を行った。
 擬似的なinterface classである。
 下記参考
 http://tercel-tech.hatenablog.com/search?q=state+
*/