//
//  HCViewController.m
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/6/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import "HCViewController.h"

@interface HCViewController ()
@end

NSInteger int_state = 0;
NSInteger leftNumber = 0;
NSInteger rightNumber = 0;
const NSInteger margin = 10;

@implementation HCViewController

@synthesize baseView;

@synthesize numberKeyButtons;
@synthesize clearButton;
@synthesize functionButton;

/* コメントアウト部分が大量にあるが、参考のために残しておく。*/

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	baseView.layer.cornerRadius = 20.0f;
	baseView.clipsToBounds = YES;
	
	// デバイスがiPhoneだった場合、サイズの調整を行う。
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		[self foriPhoneResizing];
	}
	
	// 以下の方針で確定。xibを読むのはカスタムクラスで行う。(Oct 28)
	inputView = [[HCInputView alloc] init];
	inputView.frame = CGRectMake(baseView.frame.origin.x,
															 baseView.frame.origin.y,
															 baseView.frame.size.width,
															 baseView.frame.size.height);
	inputView.hidden = NO;
	[self.view addSubview:inputView];
	[inputView arrangeInputView];
	
	
	calculateView = [[HCCalculateView alloc] init];
	calculateView.frame = CGRectMake(baseView.frame.origin.x,
																	 baseView.frame.origin.y,
																	 baseView.frame.size.width,
																	 baseView.frame.size.height);
	calculateView.hidden = YES;
	[self.view addSubview:calculateView];
	[calculateView arrangeCalculateView];
	
	[self context];
	
	//NSLog(@"%@", [inputView.subviews description]);
	//NSLog(@"%@", [calculateView.subviews description]);
	
	
	
	for (UIButton *aButton in numberKeyButtons) {
		[aButton addTarget:self
								action:@selector(numberKeyTapped:)
			forControlEvents:UIControlEventTouchUpInside];
	}
	
	UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
	[inputView.operatorSelectorView addGestureRecognizer:recognizer];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)context
{
	/*
	 // Viewの切り替えテスト -> 成功 (Oct 28)
	if (int_state % 2 == 0) {
		inputView.hidden = NO;
		calculateView.hidden = YES;
	} else {
		inputView.hidden = YES;
		calculateView.hidden = NO;
	}
	*/
	
	if (int_state == 0) {
		inputView.aboveIntegerLabel.backgroundColor = [UIColor colorWithRed:90.0 / 255.0
																																	green:150.0 / 255.0
																																	 blue:120.0 / 255.0
																																	alpha:1.0];
		inputView.belowIntegerLabel.backgroundColor = inputView.backgroundColor;
	} else if (int_state == 1) {
		inputView.belowIntegerLabel.backgroundColor = [UIColor colorWithRed:90.0 / 255.0
																																	green:150.0 / 255.0
																																	 blue:120.0 / 255.0
																																	alpha:1.0];
		inputView.aboveIntegerLabel.backgroundColor = inputView.backgroundColor;
	} else {
		inputView.belowIntegerLabel.backgroundColor = inputView.backgroundColor;
		[functionButton setTitle:@"計算開始" forState:UIControlStateNormal];
		[functionButton.titleLabel setFont:[UIFont systemFontOfSize:60]];
	}
}

- (void)tapped:(UITapGestureRecognizer *)recognizer {
	[UIView animateWithDuration:0.5f
									 animations:^{
										 [inputView bringSubviewToFront:inputView.operatorSelectorView];
										 
										 CGFloat widthOfInputView = baseView.frame.size.width;
										 inputView.operatorSelectorView.frame = CGRectMake(inputView.bounds.origin.x + margin,
																																			 inputView.bounds.origin.y + margin,
																																			 widthOfInputView - 2 * margin,
																																			 widthOfInputView - 2 * margin);
										 
										 for (UIButton *aButton in inputView.operatorSelectorView.subviews) {
											 aButton.frame = CGRectMake(inputView.operatorSelectorView.bounds.origin.x + margin
																									+ (aButton.tag % 2) * (int)(widthOfInputView / 2),
																									inputView.operatorSelectorView.bounds.origin.y + margin
																									+ (aButton.tag / 2) * (int)(widthOfInputView / 2),
																									(int)((widthOfInputView - 2 * margin) / 2) - 2 * margin,
																									(int)((widthOfInputView - 2 * margin) / 2) - 2 * margin);
										 }
									 } completion:^(BOOL par){
										 for (UIButton *aButton in inputView.operatorSelectorView.subviews) {
											 [aButton.titleLabel setFont:[UIFont systemFontOfSize:180]];
										 }
									 }];
	
	for (UIButton *aButton in inputView.operatorSelectorView.subviews) {
		aButton.userInteractionEnabled = YES;
		[aButton addTarget:self
								action:@selector(operatorSelected:)
			forControlEvents:UIControlEventTouchUpInside];
	}
	[self context];
	
}

- (void)operatorSelected:(UIButton *)button
{
	NSString *operator;
	switch (button.tag) {
		case 0:
			operator = [NSString stringWithFormat:@"+"];
			break;
		case 1:
			operator = [NSString stringWithFormat:@"-"];
			break;
		case 2:
			operator = [NSString stringWithFormat:@"×"];
			break;
		case 3:
			operator = [NSString stringWithFormat:@"÷"];
			break;
		default:
			break;
	}
	inputView.operatorSelectorView.hidden = YES;
	inputView.operatorLabel.hidden = NO;
	inputView.operatorLabel.text = operator;
}

- (void)numberKeyTapped:(UIButton *)aButton
{
	//NSLog(@"Tapped at %d button.", (int)aButton.tag);
	
	/*
	 UILabel *aLabel = [[UILabel alloc] init];
	 switch (int_state) {
	 case 0:
	 aLabel = ((UILabel *)[calculateView.labels objectAtIndex:2]);
	 break;
	 case 1:
	 aLabel = ((UILabel *)[calculateView.labels objectAtIndex:3]);
	 break;
	 case 2:
	 aLabel = ((UILabel *)[calculateView.labels objectAtIndex:6]);
	 break;
	 case 3:
	 aLabel = ((UILabel *)[calculateView.labels objectAtIndex:7]);
	 break;
	 default:
	 break;
	 }
	 aLabel.text = [NSString stringWithFormat:@"%d", aButton.tag];
	 int_state++;
	 */
	
	if (int_state == 0) {
		leftNumber = leftNumber * 10 + aButton.tag;
		inputView.aboveIntegerLabel.hidden = NO;
		inputView.aboveIntegerLabel.text = [NSString stringWithFormat:@"%d", leftNumber];
	} else {
		rightNumber = rightNumber * 10 + aButton.tag;
		inputView.belowIntegerLabel.hidden = NO;
		inputView.belowIntegerLabel.text = [NSString stringWithFormat:@"%d", rightNumber];
	}
}

- (IBAction)clearButton:(id)sender {
	//NSLog(@"clearButton tapped.");
	
	int_state = 0;
	leftNumber = 0;
	rightNumber = 0;
	[self context];
	
	for (UILabel *aLabel in calculateView.labels) {
		aLabel.text = @"";
	}
	
	inputView.aboveIntegerLabel.hidden = YES;
	inputView.belowIntegerLabel.hidden = YES;
	inputView.operatorSelectorView.backgroundColor = [UIColor colorWithRed:90.0 / 255.0
																																	 green:150.0 / 255.0
																																		blue:120.0 / 255.0
																																	 alpha:1.0];
	
	inputView.operatorSelectorView.frame = inputView.operatorSelecterViewDefaultPosition;
	inputView.operatorLabel.hidden = YES;
	inputView.operatorSelectorView.hidden = NO;
	
	CGRect frame;
	for (UIButton *aButton in inputView.operatorSelectorView.subviews) {
		// デフォルトの位置を読み込む。構造体をオブジェクトとして扱うための処理。
		[(NSValue *)[inputView.operatorSelectButtonDefaultPositions objectAtIndex:aButton.tag] getValue:&frame];
		aButton.frame = frame;
		[aButton.titleLabel setFont:[UIFont systemFontOfSize:60]];
		aButton.hidden = NO;
	}
	inputView.hidden = YES;
}


- (IBAction)functionButton:(id)sender {
	int_state++;
	[self context];
}

- (void)foriPhoneResizing
{
	// フォントサイズの調整
	int font_size = 1;
	UIButton *refferenceButton = [numberKeyButtons objectAtIndex:0];
	CGSize tmp_size = [refferenceButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font_size]}];
	while (tmp_size.width < ((UIButton *)[numberKeyButtons objectAtIndex:0]).frame.size.width) {
		font_size++;
		tmp_size = [refferenceButton.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font_size]}];
	}
	
	font_size -= 10; // マジックナンバー許してくださいm(_ _)m
	for (UIButton *aButton in numberKeyButtons) {
		[aButton.titleLabel setFont:[UIFont systemFontOfSize:font_size]];
	}
	[clearButton.titleLabel setFont:[UIFont systemFontOfSize:font_size]];
	[functionButton.titleLabel setFont:[UIFont systemFontOfSize:font_size]];
}

@end