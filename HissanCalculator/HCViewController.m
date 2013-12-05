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
#import "HCColor.h"

@interface HCViewController () {
	HCContext *context;
	HCCalculator *calculator;
	
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
	
	UIGestureRecognizer *selectOperator = [[UITapGestureRecognizer alloc] init];
	[selectOperator addTarget:self action:@selector(selectOperator:)];
	[inputView.operatorSelectorView addGestureRecognizer:selectOperator];
	
	[self contextSwitch];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)selectOperator:(id)ges
{
	if ([calculator getDigitWithInteger:aboveNumber] >= 2) {
		inputView.operatorSelectorView.backgroundColor = [HCColor highlightColor];
		[inputView expandOperatorSelectView];
		context.currentState = [[HCSelectOperatorState alloc] init];
	} else {
		aboveNumber = 0;
		context.currentState = [[HCAboveNumberState alloc] init];
	}
	[self contextSwitch];
}

// 時間あるときに構造を整理する。一旦放置。
- (void)buttonTapped:(UIButton *)button
{
	userInput = button.tag;
	
	if (userInput < 10) {
		if ([context.currentState class] == [HCAboveNumberState class]) {
			if ([calculator getDigitWithInteger:aboveNumber] < 4) {
				aboveNumber = aboveNumber * 10 + button.tag;
			}
		} else if ([context.currentState class] == [HCBelowNumberState class]) {
			if ([calculator getDigitWithInteger:belowNumber] < [calculator getDigitWithInteger:aboveNumber]) {
				belowNumber = belowNumber * 10 + button.tag;
			} else if ([calculator getDigitWithInteger:belowNumber] == 1) {
				belowNumber = button.tag;
			}
			if ([operatorString compare:@"-"] == NSOrderedSame && aboveNumber < belowNumber) {
				belowNumber = (belowNumber - button.tag) / 10;
			}
		}
	}
	
	else if (userInput == 10) {
		if ([context.currentState class] == [HCAboveNumberState class]) {
			if ([calculator getDigitWithInteger:aboveNumber] >= 2) {
				inputView.operatorSelectorView.backgroundColor = [HCColor highlightColor];
				[inputView expandOperatorSelectView];
				context.currentState = [[HCSelectOperatorState alloc] init];
			} else {
				aboveNumber = 0;
				context.currentState = [[HCAboveNumberState alloc] init];
				[self contextSwitch];
			}
		} else if ([context.currentState class] == [HCBelowNumberState class]) {
			[calculateView arrangeCalculateViewWithAbove:aboveNumber WithBelow:belowNumber WithOperator:operatorString];
			[self userAnswerModeContext];
			if ([operatorString compare:@"×"] == NSOrderedSame) {
				context.currentState = [[HCCalculateState alloc] init];
			}
		} else if ([context.currentState class] == [HCCalculateState class]) {
			//[self userAnswerModeContext];
		}
	}
	
	else if (userInput == 11) {
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
		[self contextSwitch];
	}
	
	else if (userInput == 12) {
		if ([context.currentState class] == [HCAboveNumberState class]
			|| [context.currentState class] == [HCSelectOperatorState class]) {
			aboveNumber = 0;
		} else if ([context.currentState class] == [HCBelowNumberState class]) {
			belowNumber = 0;
		}
	}
	
	
	if ([context.currentState class] == [HCSelectOperatorState class]) {
		switch (userInput) {
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
	
	if ([context.currentState class] == [HCUserAnswerState class]) {
		[self userAnswerWithButton:button];
	}
	
	if ([context.currentState class] == [HCCalculateState class] && userInput < 10) {
		aboveNumber = userInput;
		belowNumber = 0;
	}
	
	[context inputEvent:button.tag];
	[self contextSwitch];
}

-(void)contextSwitch
{
	// 入力された数字を逐次反映
	inputView.aboveIntegerLabel.text = [self getNotZeroNumberStringWithInteger:aboveNumber];
	inputView.belowIntegerLabel.text = [self getNotZeroNumberStringWithInteger:belowNumber];
	inputView.operatorLabel.text = operatorString;
	
	
	if ([context.currentState class] == [HCAboveNumberState class]) {
		inputView.descriptionLabel.text = @"数字を入力し、入力が完了したら入力ボタンを押してください。";
		[functionButton setTitle:@"入力" forState:UIControlStateNormal];
		[functionButton.titleLabel setFont:[UIFont systemFontOfSize:100]];
		inputView.aboveIntegerLabel.backgroundColor = [HCColor highlightColor];
		inputView.belowIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.operatorSelectorView.backgroundColor = inputView.backgroundColor;
		[inputView resetOperatorView];
		inputView.operatorSelectorView.hidden = NO;
		inputView.operatorLabel.hidden = YES;
		inputView.hidden = NO;
		calculateView.hidden = YES;
	}
	else if ([context.currentState class] == [HCSelectOperatorState class]) {
		[functionButton setTitle:@"入力" forState:UIControlStateNormal];
		[functionButton.titleLabel setFont:[UIFont systemFontOfSize:100]];
		inputView.aboveIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.belowIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.operatorSelectorView.hidden = NO;
		inputView.operatorLabel.hidden = YES;
	}
	else if ([context.currentState class] == [HCBelowNumberState class]) {
		if ([operatorString compare:@"×"] == NSOrderedSame) {
			inputView.descriptionLabel.text = @"計算結果ボタンを押すと結果を表示できます。";
			[functionButton setTitle:@"計算結果" forState:UIControlStateNormal];
			[functionButton.titleLabel setFont:[UIFont systemFontOfSize:60]];
		} else {
			inputView.descriptionLabel.text = @"回答ボタンを押すと回答を開始できます。";
			[functionButton setTitle:@"回答" forState:UIControlStateNormal];
			[functionButton.titleLabel setFont:[UIFont systemFontOfSize:100]];
		}
		inputView.aboveIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.belowIntegerLabel.backgroundColor = [HCColor highlightColor];
		inputView.operatorSelectorView.backgroundColor = inputView.backgroundColor;
		inputView.operatorSelectorView.hidden = YES;
		inputView.operatorLabel.hidden = NO;
	}
	else if ([context.currentState class] == [HCCalculateState class]) {
		calculateView.descriptionLabel.text = @"";
		[functionButton setTitle:@"計算結果" forState:UIControlStateNormal];
		[functionButton.titleLabel setFont:[UIFont systemFontOfSize:60]];
		inputView.aboveIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.belowIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.operatorSelectorView.backgroundColor = inputView.backgroundColor;
		inputView.hidden = YES;
		calculateView.hidden = NO;
		for (UILabel *aLabel in calculateView.labels) {
			aLabel.backgroundColor = calculateView.backgroundColor;
			aLabel.textColor = [UIColor whiteColor];
			((UILabel *)aLabel.subviews[0]).backgroundColor = calculateView.backgroundColor;
			((UILabel *)aLabel.subviews[0]).textColor = [UIColor whiteColor];
		}
	}
	else if ([context.currentState class] == [HCUserAnswerState class]) {
		calculateView.descriptionLabel.text = @"回答を入力してください。入力する数字がない場合は0を入力してください。";
		[functionButton setTitle:@"計算結果" forState:UIControlStateNormal];
		[functionButton.titleLabel setFont:[UIFont systemFontOfSize:60]];
		inputView.aboveIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.belowIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.operatorSelectorView.backgroundColor = inputView.backgroundColor;
		inputView.hidden = YES;
		calculateView.hidden = NO;
	}
	else {
		inputView.aboveIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.belowIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.operatorSelectorView.backgroundColor = inputView.backgroundColor;
	}
}

- (void)userAnswerWithButton:(UIButton *)button
{
	if ([operatorString compare:@"+"] == NSOrderedSame) {
		if (userAnswerModeState % 2 == 1) {
			UILabel *aLabel = (UILabel *)[calculateView.labels objectAtIndex:(calculateView.columnMax * calculateView.rowMax - (labelIndex + 1))];
			
			if ([self isEqualInputInteger:button.tag ToString:aLabel.text] == YES) {
				if (labelIndex < calculateView.columnMax - 1) {
					userAnswerModeState++;
					labelIndex++;
				}
				aLabel.textColor = [UIColor whiteColor];
				[self userAnswerModeContext];
			} else {
				aLabel.backgroundColor = [UIColor magentaColor];
				((UILabel *)aLabel.subviews[0]).backgroundColor = [UIColor magentaColor];
			}
			
		} else {
			UILabel *aLabel =
			(UILabel *)[calculateView.labels objectAtIndex:(calculateView.columnMax * calculateView.rowMax - (labelIndex + 2))];
			
			if ([self isEqualInputInteger:button.tag ToString:((UILabel *)aLabel.subviews[0]).text] == 1) {
				if (labelIndex < calculateView.columnMax - 1) userAnswerModeState++;
				((UILabel *)aLabel.subviews[0]).textColor = [UIColor whiteColor];
				[self userAnswerModeContext];
			}
			else {
				((UILabel *)aLabel.subviews[0]).backgroundColor = [UIColor magentaColor];
			}
		}
	}
	
	else if ([operatorString compare:@"-"] == NSOrderedSame) {
		UILabel *aLabel = (UILabel *)[calculateView.labels objectAtIndex:(calculateView.columnMax * calculateView.rowMax - (labelIndex + 1))];
		if ([self isEqualInputInteger:button.tag ToString:aLabel.text] == YES) {
			labelIndex++;
			aLabel.textColor = [UIColor whiteColor];
			[self userAnswerModeContext];
		} else {
			aLabel.backgroundColor = [UIColor magentaColor];
			((UILabel *)aLabel.subviews[0]).backgroundColor = [UIColor magentaColor];
		}
		
	}
	
	else if ([operatorString compare:@"×"] == NSOrderedSame) {
		
	}
	
	else if ([operatorString compare:@"÷"] == NSOrderedSame) {
		
	}
}

- (void)userAnswerModeContext
{
	// フォーカス対象を一旦クリア
	for (UILabel *aLabel in calculateView.labels) {
		aLabel.backgroundColor = calculateView.backgroundColor;
		((UILabel *)aLabel.subviews[0]).backgroundColor = calculateView.backgroundColor;
	}
	
	UILabel *aLabel, *sLabel;
	
	if ([operatorString compare:@"+"] == NSOrderedSame) {
		if (labelIndex == calculateView.columnMax - 1) {
			context.currentState = [[HCCalculateState alloc] init];
			return;
		}
		
		if (userAnswerModeState % 2 == 1) {
			aLabel = (UILabel *)[calculateView.labels objectAtIndex:calculateView.columnMax * calculateView.rowMax - (labelIndex + 1)];
			((UILabel *)aLabel.subviews[0]).backgroundColor = [HCColor highlightColor];
			aLabel.backgroundColor = [HCColor highlightColor];
		} else {
			if (labelIndex == calculateView.columnMax - 1) {
				userAnswerModeState++;
				labelIndex--;
				aLabel.textColor = [UIColor whiteColor];
				return;
			}
			aLabel = (UILabel *)[calculateView.labels objectAtIndex:calculateView.columnMax * calculateView.rowMax - (labelIndex + 2)];
			((UILabel *)aLabel.subviews[0]).backgroundColor = [HCColor highlightColor];
		}
	}
	
	else if ([operatorString compare:@"-"] == NSOrderedSame) {
		if (labelIndex == calculateView.columnMax - 1) {
			context.currentState = [[HCCalculateState alloc] init];
			return;
		}
		aLabel = (UILabel *)[calculateView.labels objectAtIndex:calculateView.columnMax * calculateView.rowMax - (labelIndex + 1)];
		sLabel = (UILabel *)[calculateView.labels objectAtIndex:calculateView.columnMax - (labelIndex + 1)];
		
		((UILabel *)aLabel.subviews[0]).backgroundColor = [HCColor highlightColor];
		aLabel.backgroundColor = [HCColor highlightColor];
		
		((UILabel *)sLabel.subviews[0]).textColor = [UIColor whiteColor];
	}
	
	else if ([operatorString compare:@"×"] == NSOrderedSame) {
		
	}
	
	else if ([operatorString compare:@"÷"] == NSOrderedSame) {
		
	}
	
	else {
		NSLog(@"Operator Error : Check operatorString.");
	}
	
}

// 入力した数字と文字列内の数字が等しいかどうか(BOOL)
- (BOOL)isEqualInputInteger:(NSInteger)input ToString:(NSString *)string
{
	if ([string compare:@""] == NSOrderedSame) {
		if (input == 0) {
			return YES;
		}
	} else if ([string compare:[NSString stringWithFormat:@"%d", input]] == NSOrderedSame) {
		return YES;
	}
	return NO;
}

// ゼロを表示しないためのメソッド
- (NSString *)getNotZeroNumberStringWithInteger:(NSInteger)number
{
	if (number == 0) {
		return @"";
	} else {
		return [NSString stringWithFormat:@"%d", number];
	}
}

@end