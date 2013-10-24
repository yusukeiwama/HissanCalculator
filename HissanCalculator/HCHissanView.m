//
//  HCHissanView.m
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/15/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import "HCHissanView.h"

@implementation HCHissanView

@synthesize leftIntegerLabel;
@synthesize rightIntegerLabel;
@synthesize operatorSelectorView;
@synthesize operatorLabel;

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
		labels = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)arrangeInputView
{
	downSpace = (int)((self.bounds.size.height - self.bounds.size.width) / 2);
	
	leftIntegerLabel = [[UILabel alloc] init];
	leftIntegerLabel.frame = CGRectMake(self.bounds.origin.x + margin,
																			self.bounds.origin.y + margin + downSpace,
																			self.bounds.size.width - 2 * margin,
																			(int)(self.bounds.size.width / 3) - 2 * margin);
	leftIntegerLabel.textAlignment = NSTextAlignmentCenter;
	leftIntegerLabel.backgroundColor = self.backgroundColor;
	leftIntegerLabel.textColor = [UIColor whiteColor];
	leftIntegerLabel.layer.cornerRadius = 20.0f;
	[leftIntegerLabel setFont:[UIFont systemFontOfSize:90]];
	[self addSubview:leftIntegerLabel];
	
	rightIntegerLabel = [[UILabel alloc] init];
	rightIntegerLabel.frame = CGRectMake(self.bounds.origin.x + margin,
																			 self.bounds.origin.y + margin + 2 * leftIntegerLabel.frame.size.height + downSpace,
																			 self.bounds.size.width - 2 * margin,
																			 (int)(self.bounds.size.width / 3) - 2 * margin);
	rightIntegerLabel.textAlignment = NSTextAlignmentCenter;
	rightIntegerLabel.backgroundColor = self.backgroundColor;
	rightIntegerLabel.textColor = [UIColor whiteColor];
	rightIntegerLabel.layer.cornerRadius = 20.0f;
	[rightIntegerLabel setFont:[UIFont systemFontOfSize:90]];
	[self addSubview:rightIntegerLabel];
	
	operatorSelectorView = [[UIView alloc] init];
	operatorSelectorView.frame = CGRectMake(self.bounds.origin.x + (int)(self.bounds.size.width - (int)(self.bounds.size.height / 6)) / 2,
																					self.bounds.origin.y + margin + leftIntegerLabel.frame.size.height + downSpace,
																					(int)(self.bounds.size.height / 6),
																					(int)(self.bounds.size.height / 6));
	
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
}

- (void)embedButton
{
	for (int i = 0; i < 4; i++) {
		UIButton *aButton = [[UIButton alloc] init];
		aButton.frame = CGRectMake(operatorSelectorView.bounds.origin.x + (i % 2) * (int)(operatorSelectorView.bounds.size.width / 2) + margin,
															 operatorSelectorView.bounds.origin.y + (i / 2) * (int)(operatorSelectorView.bounds.size.height / 2) + margin,
															 (int)(operatorSelectorView.bounds.size.width / 2) - 2 * margin,
															 (int)(operatorSelectorView.bounds.size.height / 2) - 2 * margin);
		aButton.backgroundColor = operatorSelectorView.backgroundColor;
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
