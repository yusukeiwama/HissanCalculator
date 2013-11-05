//
//  HCStateForInput.m
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 11/5/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import "HCState.h"

@implementation HCAboveNumberState
- (id)getNextStateWithIdentifier:(NSInteger)identifier
{
	return [[HCSelectOperatorState alloc] init];
}
@end

@implementation HCSelectOperatorState
- (id)getNextStateWithIdentifier:(NSInteger)identifier
{
	return nil;
}
@end

@implementation HCBelowNumberState
- (id)getNextStateWithIdentifier:(NSInteger)identifier
{
	return nil;
}
@end

@implementation HCUserAnswer
- (id)getNextStateWithIdentifier:(NSInteger)identifier
{
	return nil;
}
@end

@implementation HCCalculateState
- (id)getNextStateWithIdentifier:(NSInteger)identifier
{
	return nil;
}
@end

