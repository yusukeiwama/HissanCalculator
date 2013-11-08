//
//  HCCalculator.m
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/31/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import "HCCalculator.h"

@implementation HCCalculator {
	NSMutableArray *aboveIntegerArray;
	NSMutableArray *belowIntegerArray;
}

@synthesize resultArray;
@synthesize carryArray;
@synthesize digitNum;

- (NSInteger)pickUpDigitWithTargetNumber:(NSInteger)targetNumber WithDigit:(NSInteger)digit
{
	NSString *string = [NSString stringWithFormat:@"%d", targetNumber];
	if ([string length] >= digit) {
		return [string characterAtIndex:([string length] - digit)] - '0';
	} else {
		return 0;
	}
}

- (NSInteger)getDigitWithInteger:(NSInteger)number
{
	NSString *string = [NSString stringWithFormat:@"%d", number];
	return [string length];
}

- (void)additionWithAboveInteger:(NSInteger)aboveInteger WithBelowInteger:(NSInteger)belowInteger;
{
	aboveIntegerArray = [[NSMutableArray alloc] init];
	belowIntegerArray = [[NSMutableArray alloc] init];
	resultArray = [[NSMutableArray alloc] init];
	carryArray = [[NSMutableArray alloc] init];
	NSInteger digitMax = ([self getDigitWithInteger:aboveInteger] > [self getDigitWithInteger:belowInteger]) ?
	[self getDigitWithInteger:aboveInteger] : [self getDigitWithInteger:belowInteger];
	NSInteger carryInteger = 0;
	for (int i = 0; i < digitMax; i++) {
		NSInteger aAboveNumber = [self pickUpDigitWithTargetNumber:aboveInteger WithDigit:i + 1];
		NSInteger aBelowNumber = [self pickUpDigitWithTargetNumber:belowInteger WithDigit:i + 1];
		[aboveIntegerArray addObject:[NSNumber numberWithInteger:aAboveNumber]];
		[belowIntegerArray addObject:[NSNumber numberWithInteger:aBelowNumber]];
		[resultArray addObject:[NSNumber numberWithInteger:((aAboveNumber + aBelowNumber) % 10 + carryInteger) % 10]];
		[carryArray addObject:[NSNumber numberWithInt:carryInteger]];
		carryInteger = (aAboveNumber + aBelowNumber) / 10 + ((aAboveNumber + aBelowNumber) % 10 + carryInteger) / 10;
	}
	[carryArray addObject:[NSNumber numberWithInteger:carryInteger]];
	[resultArray addObject:[NSNumber numberWithInteger:carryInteger]];
	digitNum = [resultArray count];
	NSLog(@"%@", [resultArray description]);
	
}

@end
