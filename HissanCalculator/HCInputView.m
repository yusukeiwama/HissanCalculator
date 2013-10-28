//
//  HCInputView.m
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/27/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import "HCInputView.h"

@implementation HCInputView

@synthesize aboveIntegerLabel;
@synthesize belowIntegerLabel;
@synthesize operatorSelectorView;
@synthesize operatorLabel;

@synthesize operatorSelecterViewDefaultPosition;
@synthesize operatorSelectButtonDefaultPositions;

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		margin = 10;
		NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"InputView"
																												owner: self
																											options: nil];
		self = (HCInputView *)[nibObjects objectAtIndex:0];
		self.layer.cornerRadius = 20.0f;
		self.clipsToBounds = YES;
		//NSLog(@"iptView : %@", [nibObjects description]);
		
		// 以下の様にサブビューを読み込まないと操作できないので注意。
		aboveIntegerLabel = self.subviews[0];
		belowIntegerLabel = self.subviews[1];
		//operatorSelectorView = self.subviews[2];
		//operatorLabel = self.subviews[3];
		
	}
	return self;
}

- (void)arrangeInputView
{
	aboveIntegerLabel.text = @"9999";
  belowIntegerLabel.text = @"0000";
	
}

- (void)embedButton
{
	NSValue *value;
	CGRect rect;
	
	for (int i = 0; i < 4; i++) {
		UIButton *aButton = [[UIButton alloc] init];
		aButton.frame = CGRectMake(operatorSelectorView.bounds.origin.x + (i % 2) * (int)(operatorSelectorView.bounds.size.width / 2) + margin,
															 operatorSelectorView.bounds.origin.y + (i / 2) * (int)(operatorSelectorView.bounds.size.height / 2) + margin,
															 (int)(operatorSelectorView.bounds.size.width / 2) - 2 * margin,
															 (int)(operatorSelectorView.bounds.size.height / 2) - 2 * margin);
		aButton.backgroundColor = operatorSelectorView.backgroundColor;
		
		// ボタンのデフォルトの位置をNSArrayに格納する。構造体のための処理。
		rect = aButton.frame;
		value = [NSValue value:&rect withObjCType:@encode(CGRect)];
		[operatorSelectButtonDefaultPositions arrayByAddingObject:value];
		// ------------------------------------------ ここまで。
		
		NSString *operator;
		switch (i) {
			case 0:
				operator = @"+";
				break;
			case 1:
				operator = @"-";
				break;
			case 2:
				operator = @"×";
				break;
			case 3:
				operator = @"÷";
				break;
			default:
				break;
		}
		[aButton setTitle:operator forState:UIControlStateNormal];
		[aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[aButton.titleLabel setFont:[UIFont systemFontOfSize:60]];
		aButton.tag = i;
		aButton.userInteractionEnabled = NO;
		[operatorSelectorView addSubview:aButton];
	}
}

- (void)embedOperatorView
{
	operatorLabel = [[UILabel alloc] init];
	operatorLabel.frame = operatorSelectorView.frame;
	operatorLabel.textAlignment = NSTextAlignmentCenter;
	[operatorLabel setFont:[UIFont systemFontOfSize:150]];
	[operatorLabel setTextColor:[UIColor whiteColor]];
	operatorLabel.hidden = YES;
	[self addSubview:operatorLabel];
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
