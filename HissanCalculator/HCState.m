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
	switch (identifier) {
		case 0:
		case 1:
		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
		case 7:
		case 8:
		case 9:
			return self;
		case 10:
			return self;
		case 11:
			return [[HCAboveNumberState alloc] init];
		case 12:
			return [[HCAboveNumberState alloc] init];
		case 20:
		case 21:
		case 22:
		case 23:
		default:
			return self;
	}
}
@end

@implementation HCSelectOperatorState
- (id)getNextStateWithIdentifier:(NSInteger)identifier
{
	switch (identifier) {
		case 0:
		case 1:
		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
		case 7:
		case 8:
		case 9:
		case 10:
			return self;
		case 11:
			return [[HCAboveNumberState alloc] init];
		case 12:
			return [[HCAboveNumberState alloc] init];
		case 20:
		case 21:
		case 22:
		case 23:
			return [[HCBelowNumberState alloc] init];
		default:
			return self;
	}
}
@end

@implementation HCBelowNumberState
- (id)getNextStateWithIdentifier:(NSInteger)identifier
{
	switch (identifier) {
		case 0:
		case 1:
		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
		case 7:
		case 8:
		case 9:
			return [[HCBelowNumberState alloc] init];
		case 10:
			return [[HCUserAnswerState alloc] init];
		case 11:
			return [[HCAboveNumberState alloc] init];
		case 12:
			return [[HCBelowNumberState alloc] init];
		case 20:
		case 21:
		case 22:
		case 23:
		default:
			return self;
	}
}
@end

@implementation HCUserAnswerState
- (id)getNextStateWithIdentifier:(NSInteger)identifier
{
	switch (identifier) {
		case 0:
		case 1:
		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
		case 7:
		case 8:
		case 9:
			return self;
		case 10:
			return [[HCCalculateState alloc] init];
		case 11:
			return [[HCAboveNumberState alloc] init];
		case 12:
			return [[HCAboveNumberState alloc] init];
		case 20:
		case 21:
		case 22:
		case 23:
			return [[HCBelowNumberState alloc] init];
		default:
			return self;
	}
}
@end

@implementation HCCalculateState
- (id)getNextStateWithIdentifier:(NSInteger)identifier
{
	switch (identifier) {
		case 0:
		case 1:
		case 2:
		case 3:
		case 4:
		case 5:
		case 6:
		case 7:
		case 8:
		case 9:
			return self;
		case 10:
			return self;
		case 11:
			return [[HCAboveNumberState alloc] init];
		case 12:
			return [[HCAboveNumberState alloc] init];
		case 20:
		case 21:
		case 22:
		case 23:
		default:
			return self;
	}
}
@end

