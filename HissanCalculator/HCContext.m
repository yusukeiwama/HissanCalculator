//
//  HCContextForInput.m
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 11/5/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import "HCContext.h"

@implementation HCContext {
	id previousState;
}

@synthesize currentState;

- (id)init
{
	if (self = [super init]) {
		currentState = [[HCSelectOperatorState alloc] init];
	}
	return self;
}

- (void)inputEvent:(NSInteger)identifier
{
	previousState = currentState;
	currentState = [currentState getNextStateWithIdentifier:identifier];
}

@end
