//
//  HCContextForInput.h
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 11/5/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCState.h"

@interface HCContext : NSObject

/** 初期状態 */
@property HCAboveNumberState *currentState;

- (void)inputEvent:(NSInteger)identifier;

@end

/*
 inputEventはNSIntegerにより識別する。
 0 ~ 9 : その数字
 10 : Function Key
 11 : All Clear
 12 : Clear
*/