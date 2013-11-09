//
//  HCCalculator.m
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/31/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import "HCCalculator.h"

@implementation HCCalculator

@synthesize aboveOriginalIntegerArray;

@synthesize resultArray;
@synthesize carryArray;
@synthesize borrowReferenceArray;
@synthesize digitNum;

@synthesize aboveResultArray;
@synthesize belowResultArray;

@synthesize aboveIntegerArray;
@synthesize belowIntegerArray;

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
	NSInteger digitMax = [self getDigitWithInteger:aboveInteger];
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
	//NSLog(@"%@", [resultArray description]);
}

- (void)subtractionWithAboveInteger:(NSInteger)aboveInteger WithBelowInteger:(NSInteger)belowInteger
{
	aboveIntegerArray = [[NSMutableArray alloc] init];
	belowIntegerArray = [[NSMutableArray alloc] init];
	aboveOriginalIntegerArray = [[NSMutableArray alloc] init];
	resultArray = [[NSMutableArray alloc] init];
	borrowReferenceArray = [[NSMutableArray alloc] init];
	NSInteger digitMax = [self getDigitWithInteger:aboveInteger];
	NSInteger borrowInteger = 0;
	for (int i = 0; i <= digitMax; i++) {
		NSInteger aAboveNumber = [self pickUpDigitWithTargetNumber:aboveInteger WithDigit:i + 1];
		NSInteger aBelowNumber = [self pickUpDigitWithTargetNumber:belowInteger WithDigit:i + 1];
		[aboveIntegerArray addObject:[NSNumber numberWithInteger:aAboveNumber]];
		[aboveOriginalIntegerArray addObject:[NSNumber numberWithInteger:aAboveNumber]];
		[belowIntegerArray addObject:[NSNumber numberWithInteger:aBelowNumber]];
		[borrowReferenceArray addObject:[NSNumber numberWithInteger:aAboveNumber]];
	}
	
	for (int i = 0; i < digitMax; i++) {
		if ([[aboveIntegerArray objectAtIndex:i] integerValue]
			< [[belowIntegerArray objectAtIndex:i] integerValue]) {
			borrowInteger = [[aboveIntegerArray objectAtIndex:i + 1] integerValue] - 1;
			[aboveIntegerArray replaceObjectAtIndex:i + 1
										 withObject:[NSNumber numberWithInteger:borrowInteger]];
			[aboveIntegerArray replaceObjectAtIndex:i
										 withObject:[NSNumber numberWithInteger:[[aboveIntegerArray objectAtIndex:i] integerValue] + 10]];
			[borrowReferenceArray replaceObjectAtIndex:i + 1
											withObject:[NSNumber numberWithInteger:borrowInteger]];
		} else {
		}
		NSInteger aAboveNumber = [[aboveIntegerArray objectAtIndex:i] integerValue];
		NSInteger aBelowNumber = [[belowIntegerArray objectAtIndex:i] integerValue];
		
		[resultArray addObject:[NSNumber numberWithInteger:aAboveNumber - aBelowNumber]];
	}
}

- (void)multiplicationWithAboveInteger:(NSInteger)aboveInteger WithBelowInteger:(NSInteger)belowInteger
{
	aboveIntegerArray = [[NSMutableArray alloc] init]; // carryに利用
	belowIntegerArray = [[NSMutableArray alloc] init];
	resultArray = [[NSMutableArray alloc] init];
	
	NSInteger aboveDigit = [self getDigitWithInteger:aboveInteger];
	NSInteger belowDigit = [self getDigitWithInteger:belowInteger];
	
	NSInteger carryInteger = 0;
	
	belowResultArray = [[NSMutableArray alloc] init];
	for (int j = 0; j < belowDigit; j++) {
		NSInteger aBelowNumber = [self pickUpDigitWithTargetNumber:belowInteger WithDigit:j + 1];
		aboveResultArray = [[NSMutableArray alloc] init];
		aboveIntegerArray = [[NSMutableArray alloc] init];
		for (int i = 0; i <= aboveDigit + belowDigit - 1; i++) {
			[aboveResultArray addObject:[NSNumber numberWithInteger:-1]];
			[aboveIntegerArray addObject:[NSNumber numberWithInteger:0]];
		}
		for (int i = 0; i < aboveDigit; i++) {
			NSInteger aAboveNumber = [self pickUpDigitWithTargetNumber:aboveInteger WithDigit:i + 1];
			[aboveResultArray replaceObjectAtIndex:i + j
										withObject:[NSNumber numberWithInteger:((aAboveNumber * aBelowNumber) % 10 + carryInteger) % 10 ]];
			[aboveIntegerArray replaceObjectAtIndex:i + j
										 withObject:[NSNumber numberWithInteger:carryInteger]];
			carryInteger = ((aAboveNumber * aBelowNumber) % 10 + carryInteger) / 10;
			carryInteger += (aAboveNumber * aBelowNumber) / 10;
		}
		if (carryInteger > 0) {
			[aboveResultArray replaceObjectAtIndex:aboveDigit + j
										withObject:[NSNumber numberWithInteger:carryInteger]];
			[aboveIntegerArray replaceObjectAtIndex:aboveDigit + j
										 withObject:[NSNumber numberWithInteger:carryInteger]];
		}
		[belowResultArray addObject:aboveResultArray];
		[belowIntegerArray addObject:aboveIntegerArray];
		carryInteger = 0;
	}
	//NSLog(@"%@", belowResultArray);
	NSInteger carry = 0;
	for (int j = 0; j < aboveDigit + belowDigit - 1 ; j++) {
		NSInteger result = 0;
		aboveIntegerArray = [[NSMutableArray alloc] init];
		for (int i = 0; i <= aboveDigit + belowDigit - 1; i++) {
			[aboveIntegerArray addObject:[NSNumber numberWithInteger:0]];
		}
		for (int i = 0; i < belowDigit; i++) {
			if ([[[belowResultArray objectAtIndex:i] objectAtIndex:j] integerValue] >= 0) {
				result += [[[belowResultArray objectAtIndex:i] objectAtIndex:j] integerValue];
			}
		}
		result += carry;
		[aboveIntegerArray replaceObjectAtIndex:j
									 withObject:[NSNumber numberWithInteger:carry]];
		carry = result / 10;
		result = result % 10;
		[resultArray addObject:[NSNumber numberWithInteger:result]];
	}
	carry += [[[belowResultArray objectAtIndex:belowDigit - 1] objectAtIndex:aboveDigit + belowDigit - 1] integerValue];
	if (carry > 0) {
		[resultArray addObject:[NSNumber numberWithInteger:carry]];
		[aboveIntegerArray replaceObjectAtIndex:aboveDigit + belowDigit - 1
									 withObject:[NSNumber numberWithInteger:carry]];
	}
	[belowIntegerArray addObject:aboveIntegerArray];
	//NSLog(@"%@", resultArray);
}

@end
