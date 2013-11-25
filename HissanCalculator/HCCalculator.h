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

@property NSMutableArray *aboveOriginalIntegerArray;

@property NSMutableArray *aboveResultArray;
@property NSMutableArray *belowResultArray;

@property NSMutableArray *carryArray;
@property NSMutableArray *borrowReferenceArray;
@property NSMutableArray *resultArray;

@property NSMutableArray *aboveIntegerArray;
@property NSMutableArray *belowIntegerArray;


@property NSInteger digitNum;

- (NSInteger)pickUpDigitWithTargetNumber:(NSInteger)targetNumber WithDigit:(NSInteger)digit;
- (NSInteger)getDigitWithInteger:(NSInteger)number;

- (void)additionWithAboveInteger:(NSInteger)aboveInteger WithBelowInteger:(NSInteger)belowInteger;
- (void)subtractionWithAboveInteger:(NSInteger)aboveInteger WithBelowInteger:(NSInteger)belowInteger;
- (void)multiplicationWithAboveInteger:(NSInteger)aboveInteger WithBelowInteger:(NSInteger)belowInteger;

@end

/*
 初期段階では、コントローラの部分に計算する一部を書いてしまう。
 後に、リファクタリングにより分離していく。(Nov 5)
 */
