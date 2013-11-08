//
//  HCCalculator.h
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/31/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 計算するクラス
 */

@interface HCCalculator : NSObject

@property NSMutableArray *carryArray;
@property NSMutableArray *resultArray;

@property NSInteger digitNum;

- (NSInteger)pickUpDigitWithTargetNumber:(NSInteger)targetNumber WithDigit:(NSInteger)digit;
- (NSInteger)getDigitWithInteger:(NSInteger)number;

- (void)additionWithAboveInteger:(NSInteger)aboveInteger WithBelowInteger:(NSInteger)belowInteger;

@end

/*
 初期段階では、コントローラの部分に計算するすべてを書いてしまう。
 後に、リファクタリングにより分離していく。(Nov 5)
 */
