//
//  HCViewController.m
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/6/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import "HCViewController.h"
#import "HCContext.h"
#import "HCCalculator.h"

@interface HCViewController () {
	HCContext *context;
	HCCalculator *calculator;
	UIColor *highlightColor;
	NSString *operatorString;
	NSInteger userInput;
	NSInteger userAnswerModeState;
}
@end

const NSInteger margin = 10;

NSInteger aboveNumber = 0;
NSInteger belowNumber = 0;
NSInteger labelIndex = 0;

@implementation HCViewController

@synthesize baseView;
@synthesize buttons;
@synthesize functionButton;

- (void)viewDidLoad
{
	[super viewDidLoad];
	context = [[HCContext alloc] init];
	calculator = [[HCCalculator alloc] init];
	userInput = 0;
	userAnswerModeState =	0;
	highlightColor = [UIColor colorWithRed:90.0 / 255.0
																	 green:150.0 / 255.0
																		blue:120.0 / 255.0
																	 alpha:1.0];
	
	baseView.layer.cornerRadius = 20.0f;
	baseView.clipsToBounds = YES;
	
	// init view for input. this xib file is loaded in its custom class.
	inputView = [[HCInputView alloc] init];
	inputView.frame = CGRectMake(baseView.frame.origin.x,
															 baseView.frame.origin.y,
															 baseView.frame.size.width,
															 baseView.frame.size.height);
	[self.view addSubview:inputView];
	[inputView arrangeInputView];
	
	// init view for culculation. don't have xib.
	calculateView = [[HCCalculateView alloc] init];
	calculateView.frame = CGRectMake(baseView.frame.origin.x,
																	 baseView.frame.origin.y,
																	 baseView.frame.size.width,
																	 baseView.frame.size.height);
	calculateView.hidden = YES; // first, hidden.
	[self.view addSubview:calculateView];
	
	
	for (UIButton *aButton in inputView.operatorSelectorView.subviews) {
		aButton.userInteractionEnabled = YES;
		self.buttons = [self.buttons arrayByAddingObject:aButton];
	}
	
	// 入力を受け付けるためのメソッドと関連付ける
	for (UIButton *aButton in self.buttons) {
    [aButton addTarget:self
								action:@selector(buttonTapped:)
			forControlEvents:UIControlEventTouchUpInside];
	}
	
	[self contextSwitch];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)buttonTapped:(UIButton *)button
{
	NSLog(@"ButtonTaped at %d in state of %@", button.tag, [context.currentState class]);
	userInput = button.tag;
	if (button.tag < 10) {
		if ([context.currentState class] == [HCAboveNumberState class]) {
			if ([calculator getDigitWithInteger:aboveNumber] < 5) {
				aboveNumber = aboveNumber * 10 + button.tag;
			}
		} else if ([context.currentState class] == [HCBelowNumberState class]) {
			if ([calculator getDigitWithInteger:belowNumber] < 5) {
				belowNumber = belowNumber * 10 + button.tag;
			}
		}
	} else if (button.tag == 10) {
		if ([context.currentState class] == [HCAboveNumberState class]) {
			inputView.operatorSelectorView.backgroundColor = highlightColor;
			[inputView expandOperatorSelectView];
		} else if ([context.currentState class] == [HCBelowNumberState class]) {
			[calculateView arrangeCalculateViewWithAbove:aboveNumber WithBelow:belowNumber WithOperator:operatorString];
		} else if ([context.currentState class] == [HCCalculateState class]) {
			[self userAnswerModeContext];
		}
	} else if (button.tag == 11) {
		aboveNumber = 0;
		belowNumber = 0;
		userAnswerModeState = 0;
		labelIndex = 0;
		for (UILabel *aLabel in calculateView.labels) {
			aLabel.text = @"";
		}
		for (UIView *aView in [calculateView subviews]) {
			[aView removeFromSuperview];
		}
	} else if (button.tag == 12) {
		if ([context.currentState class] == [HCAboveNumberState class]
				|| [context.currentState class] == [HCSelectOperatorState class]) {
			aboveNumber = 0;
		} else if ([context.currentState class] == [HCBelowNumberState class]) {
			belowNumber = 0;
		}
	}
	
	if ([context.currentState class] == [HCSelectOperatorState class]) {
		switch (button.tag) {
			case 20:
				operatorString = @"+";
				break;
			case 21:
				operatorString = @"-";
				break;
			case 22:
				operatorString = @"×";
				break;
			case 23:
				operatorString = @"÷";
				break;
			default:
				break;
		}
	}
	
	if ([context.currentState class] == [HCUserAnswer class]) {
		[self userAnswerModeWithTapped:button];
	}
	
	[context inputEvent:button.tag];
	[self contextSwitch];
}

-(void)contextSwitch
{
	inputView.aboveIntegerLabel.text = [self getNumberStringWithInteger:aboveNumber];
	inputView.belowIntegerLabel.text = [self getNumberStringWithInteger:belowNumber];
	inputView.operatorLabel.text = operatorString;
	
	
	if ([context.currentState class] == [HCAboveNumberState class]) {
		inputView.aboveIntegerLabel.backgroundColor = highlightColor;
		inputView.belowIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.operatorSelectorView.backgroundColor = inputView.backgroundColor;
		[inputView resetOperatorView];
		inputView.operatorSelectorView.hidden = NO;
		inputView.operatorLabel.hidden = YES;
		inputView.hidden = NO;
		calculateView.hidden = YES;
	}
	else if ([context.currentState class] == [HCSelectOperatorState class]) {
		inputView.aboveIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.belowIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.operatorSelectorView.hidden = NO;
		inputView.operatorLabel.hidden = YES;
	}
	else if ([context.currentState class] == [HCBelowNumberState class]) {
		inputView.aboveIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.belowIntegerLabel.backgroundColor = highlightColor;
		inputView.operatorSelectorView.backgroundColor = inputView.backgroundColor;
		inputView.operatorSelectorView.hidden = YES;
		inputView.operatorLabel.hidden = NO;
	}
	else if ([context.currentState class] == [HCCalculateState class]) {
		[functionButton setTitle:@"回答" forState:UIControlStateNormal];
		inputView.aboveIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.belowIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.operatorSelectorView.backgroundColor = inputView.backgroundColor;
		inputView.hidden = YES;
		calculateView.hidden = NO;
	}
	else if ([context.currentState class] == [HCUserAnswer class]) {
		[functionButton setTitle:@"計算" forState:UIControlStateNormal];
		inputView.aboveIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.belowIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.operatorSelectorView.backgroundColor = inputView.backgroundColor;
	}
	else {
		inputView.aboveIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.belowIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.operatorSelectorView.backgroundColor = inputView.backgroundColor;
	}
}

- (void)userAnswerModeWithTapped:(UIButton *)button
{
	if ([operatorString compare:@"+"] == NSOrderedSame) {
		
		if (userAnswerModeState % 2 == 1) {
			UILabel *aLabel = (UILabel *)[calculateView.labels objectAtIndex:(calculateView.columnMax * calculateView.rowMax - (labelIndex + 1))];
			NSLog(@"%@", aLabel.text);
			if ([self equalToInputInteger:button.tag WithString:aLabel.text] == 1) {
				userAnswerModeState++;
				labelIndex++;
				aLabel.textColor = [UIColor whiteColor];
				[self userAnswerModeContext];
			}
			
			else {
				aLabel.backgroundColor = [UIColor magentaColor];
				((UILabel *)aLabel.subviews[0]).backgroundColor = [UIColor magentaColor];
			}
			
		}
		else {
			UILabel *aLabel = (UILabel *)[calculateView.labels objectAtIndex:(calculateView.columnMax * calculateView.rowMax - (labelIndex + 2))];
			NSLog(@"%@", ((UILabel *)aLabel.subviews[0]).text);
			if ([self equalToInputInteger:button.tag WithString:((UILabel *)aLabel.subviews[0]).text] == 1) {
				userAnswerModeState++;
				((UILabel *)aLabel.subviews[0]).textColor = [UIColor whiteColor];
				[self userAnswerModeContext];
			}
			else {
				((UILabel *)aLabel.subviews[0]).backgroundColor = [UIColor magentaColor];
			}
		}
	}
}

- (void)userAnswerModeContext
{
	for (UILabel *aLabel in calculateView.labels) {
    aLabel.backgroundColor = calculateView.backgroundColor;
		((UILabel *)aLabel.subviews[0]).backgroundColor = calculateView.backgroundColor;
	}
	
	UILabel *aLabel;
	if ([operatorString compare:@"+"] == NSOrderedSame) {
		if (userAnswerModeState % 2 == 1) {
			aLabel = (UILabel *)[calculateView.labels objectAtIndex:calculateView.columnMax * calculateView.rowMax - (labelIndex + 1)];
			((UILabel *)aLabel.subviews[0]).backgroundColor = highlightColor;
			aLabel.backgroundColor = highlightColor;
		} else {
			aLabel = (UILabel *)[calculateView.labels objectAtIndex:calculateView.columnMax * calculateView.rowMax - (labelIndex + 2)];
			((UILabel *)aLabel.subviews[0]).backgroundColor = highlightColor;
		}
	}
	if (labelIndex > calculateView.columnMax - 1) {
		context.currentState = [[HCCalculateState alloc] init];
	}
}

- (NSInteger)equalToInputInteger:(NSInteger)input WithString:(NSString *)string
{
	if ([string compare:[NSString stringWithFormat:@"%d", input]] == NSOrderedSame) {
		return 1;
	}
	if ([string compare:@""] == NSOrderedSame) {
		if (input == 0) {
			return 1;
		} else {
			return 0;
		}
	}
	return 0;
}

// ゼロを表示しないためのメソッド
- (NSString *)getNumberStringWithInteger:(NSInteger)number
{
	if (number == 0) {
		return @"";
	} else {
		return [NSString stringWithFormat:@"%d", number];
	}
}

@end