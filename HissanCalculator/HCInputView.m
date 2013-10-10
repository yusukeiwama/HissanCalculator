//
//  HCInputView.m
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/9/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import "HCInputView.h"

@implementation HCInputView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id<HCState>) getNextState {
    NSLog(@"This is State1");
    //return [[HCCalculateView alloc] init];
	return Nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
