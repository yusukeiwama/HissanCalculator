//
//  HCHissanView.m
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/15/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import "HCHissanView.h"
#import "HCCreateFomulaState.h"
#import "HCCalculationState.h"

@implementation HCHissanView

static CGRect const kButtonFrame = {{10, 10}, {440, 60}};

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		// Initialization code
		}
    return self;
}

/*
// xib を使用する場合
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
		// Initialization code
		NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"HissanView"
													 owner:self
												   options:nil];
		[self addSubview:[arr objectAtIndex:0]];
		
		UIButton *aButton = [[UIButton alloc] init];
		aButton.frame = kButtonFrame;
		[aButton setBackgroundColor:[UIColor magentaColor]];
		[aButton setTitle:@"Hoge" forState:UIControlStateNormal];
		[aButton addTarget:self action:Nil forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:aButton];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
}
*/

@end
