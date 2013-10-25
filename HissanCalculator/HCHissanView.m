//
//  HCHissanView.m
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/15/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import "HCHissanView.h"

@implementation HCHissanView

@synthesize aboveIntegerLabel;
@synthesize belowIntegerLabel;
@synthesize operatorSelectorView;
@synthesize operatorLabel;

@synthesize operatorSelecterViewDefaultPosition;
@synthesize operatorSelectButtonDefaultPositions;

@synthesize downSpace;

@synthesize state;
@synthesize labels;

// using xib files or story board.
-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if(self){
		// Initialization code
		margin = 10;
		self.layer.cornerRadius = 20.0f;
		self.clipsToBounds = YES;
	}
	return self;
}

- (void)arrangeInputView
{
	operatorSelectorView = [[UIView alloc] init];
	operatorSelectorView.frame = CGRectMake(self.bounds.origin.x + margin,
																					self.bounds.origin.y + margin + (int)(self.bounds.size.height / 5),
																					(int)(self.bounds.size.height / 5),
																					(int)(self.bounds.size.height / 5));
	operatorSelecterViewDefaultPosition = operatorSelectorView.frame;
	operatorSelectorView.backgroundColor = [UIColor colorWithRed:90.0 / 255.0
																												 green:150.0 / 255.0
																													blue:120.0 / 255.0
																												 alpha:1.0];
	[[operatorSelectorView layer] setBorderColor:[[UIColor whiteColor] CGColor]];
	[[operatorSelectorView layer] setBorderWidth:1.0];
	[[operatorSelectorView layer] setCornerRadius:20.0f];
	[self embedButton];
	[self embedOperatorView];
	[self addSubview:operatorSelectorView];
	
	aboveIntegerLabel = [[UILabel alloc] init];
	aboveIntegerLabel.frame = CGRectMake(self.bounds.origin.x + margin + (int)(self.bounds.size.height / 5),
																			 self.bounds.origin.y + margin,
																			 self.bounds.size.width - 2 * margin - (int)(self.bounds.size.height / 5),
																			 (int)(self.bounds.size.height / 5));
	aboveIntegerLabel.textAlignment = NSTextAlignmentCenter;
	aboveIntegerLabel.backgroundColor = self.backgroundColor;
	aboveIntegerLabel.textColor = [UIColor whiteColor];
	aboveIntegerLabel.layer.cornerRadius = 20.0f;
	[aboveIntegerLabel setFont:[UIFont systemFontOfSize:90]];
	[self addSubview:aboveIntegerLabel];
	
	belowIntegerLabel = [[UILabel alloc] init];
	belowIntegerLabel.frame = CGRectMake(self.bounds.origin.x + margin + (int)(self.bounds.size.height / 5),
																			 self.bounds.origin.y + margin + (int)(self.bounds.size.height / 5),
																			 self.bounds.size.width - 2 * margin - (int)(self.bounds.size.height / 5),
																			 (int)(self.bounds.size.height / 5));
	belowIntegerLabel.textAlignment = NSTextAlignmentCenter;
	belowIntegerLabel.backgroundColor = self.backgroundColor;
	belowIntegerLabel.textColor = [UIColor whiteColor];
	belowIntegerLabel.layer.cornerRadius = 20.0f;
	[belowIntegerLabel setFont:[UIFont systemFontOfSize:90]];
	[self addSubview:belowIntegerLabel];
	
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

- (void)arrangeHissanView
{
	for (int i = 0; i < 5; i++) {
		for (int k = 0; k < 4; k++) {
			UILabel *aCellOfLabel = [[UILabel alloc] init];
			aCellOfLabel.frame = CGRectMake(self.bounds.origin.x + k * self.bounds.size.width / 4,
																			self.bounds.origin.y + i * self.bounds.size.height / 5,
																			(int)self.bounds.size.width / 4,
																			(int)self.bounds.size.height / 5);
			aCellOfLabel.tag = k + i * 4;
			aCellOfLabel.textAlignment = NSTextAlignmentCenter;
			aCellOfLabel.backgroundColor = self.backgroundColor;
			aCellOfLabel.textColor = [UIColor whiteColor];
			[aCellOfLabel setFont:[UIFont systemFontOfSize:90]];
			[self addSubview:aCellOfLabel];
			
			UILabel *superScriptLabel = [[UILabel alloc] init];
			superScriptLabel.frame = CGRectMake(aCellOfLabel.bounds.origin.x + 3 * (int)(aCellOfLabel.bounds.size.width / 5),
																					aCellOfLabel.bounds.origin.y,
																					(int)(aCellOfLabel.bounds.size.width / 5),
																					(int)(aCellOfLabel.bounds.size.height / 5));
			superScriptLabel.textAlignment = NSTextAlignmentCenter;
			[superScriptLabel setFont:[UIFont systemFontOfSize:30]];
			superScriptLabel.backgroundColor = aCellOfLabel.backgroundColor;
			[aCellOfLabel addSubview:superScriptLabel];
			[labels addObject:aCellOfLabel];
		}
	}
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {}
@end
