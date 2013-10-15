//
//  HCCalculationState.m
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/15/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import "HCCalculationState.h"
#import "HCCreateFomulaState.h"

@implementation HCCalculationState

-(id<HCState>) getNextState {
    NSLog(@"This is Calculation State");
    return [[HCCreateFomulaState alloc] init];
}


@end
