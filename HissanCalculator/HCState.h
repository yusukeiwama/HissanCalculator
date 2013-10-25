//
//  HCState.h
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/9/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 デザインパターンの1つ、Stateパターンを実装するプロコトル。
 通常のOOP言語における、Interfaceにあたる。
 Stateパターンは、「状態」を表すためのパターンである。
 Stateは状態変数と呼ばれる変数で管理されてきが、オブジェクト化して、
 振る舞いの記述を別クラスに切り出してやろう、というのがStateパターンの考え方。
 */

// 今のところ使わないかもしれない。

@protocol HCState <NSObject>

/** 更新処理を行い、次状態を返すメソッド
 
 返り値がid型となっているので、以下のようにして使う。
 
	_state = [_state getNextState];
 
 */
- (id <HCState>) getNextState;

@end
