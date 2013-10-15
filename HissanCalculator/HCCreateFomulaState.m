//
//  HCCreateFomulaState.m
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/15/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import "HCCreateFomulaState.h"
#import "HCCalculationState.h"

@implementation HCCreateFomulaState

-(id<HCState>) getNextState {
    NSLog(@"This is Create Fomula State");
    return [[HCCalculationState alloc] init];
}

@end
