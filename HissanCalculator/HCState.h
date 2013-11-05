//
//  HCStateForInput.h
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/9/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 デザインパターンの1つ、Stateパターンを実装するプロコトル。
 カテゴリにより実装している
 式入力時の状態を管理する。
 */

@interface NSObject (HCState)
/* 更新処理を行い、次状態を返すメソッド
 
 返り値がid型となっているので、以下のようにして使う。
	state = [state getNextStateWithIdentifier:identifier];
 */
- (id)getNextStateWithIdentifier:(NSInteger)identifier;
@end

@interface HCAboveNumberState : NSObject
@end

@interface HCSelectOperatorState : NSObject
@end

@interface HCBelowNumberState : NSObject
@end

@interface HCUserAnswer : NSObject
@end

@interface HCCalculateState : NSObject
@end


/*
 簡潔に記述するためにカテゴリを用いた実装を行った。
 擬似的なinterface classである。
 下記参考
 http://tercel-tech.hatenablog.com/search?q=state+
*/