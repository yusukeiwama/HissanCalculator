//
//  HCViewController.m
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/6/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import "HCViewController.h"

@interface HCViewController () {
	UIColor *highlightColor;
}
@end

NSInteger inputState = 0;
NSInteger modeState = 0;
NSInteger calculateState = 0;

NSInteger aboveNumber = 0;
NSInteger belowNumber = 0;
NSInteger margin = 10;

@implementation HCViewController

@synthesize baseView;
@synthesize numberKeyButtons;
@synthesize allClearButton;
@synthesize functionButton;

/* コメントアウト部分が大量にあるが、参考のために残しておく。*/
- (void)viewDidLoad
{
	[super viewDidLoad];
	highlightColor = [UIColor colorWithRed:90.0 / 255.0
																	 green:150.0 / 255.0
																		blue:120.0 / 255.0
																	 alpha:1.0];
	baseView.layer.cornerRadius = 20.0f;
	baseView.clipsToBounds = YES;
	
	// デバイスがiPhoneだった場合、サイズの調整を行う。
	// バグの原因になりうるので一旦コメントアウト(Oct 28)
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		[self foriPhoneResizing];
	}
	
	// 以下の方針で確定。xibを読むのはカスタムクラスで行う(Oct 28)
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
	//[calculateView arrangeCalculateView];
	
	[self context];
	
	//NSLog(@"%@", [inputView.subviews description]);
	//NSLog(@"%@", [calculateView.subviews description]);
	
	for (UIButton *aButton in numberKeyButtons) {
		[aButton addTarget:self
								action:@selector(numberKeyTapped:)
			forControlEvents:UIControlEventTouchUpInside];
	}
	
	for (UIButton *aButton in inputView.operatorSelectorView.subviews) {
		aButton.userInteractionEnabled = NO;
		[aButton addTarget:self
								action:@selector(operatorSelected:)
			forControlEvents:UIControlEventTouchUpInside];
	}
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)context
{
	if (modeState == 0) {
		inputView.hidden = NO;
		calculateView.hidden = YES;
	} else {
		inputView.hidden = YES;
		calculateView.hidden = NO;
	}
	
	if (inputState < 0) inputState = 0;
	if (inputState > 3) inputState = 3;
	
	if (inputState == 0) {
		inputView.aboveIntegerLabel.backgroundColor = highlightColor;
		inputView.belowIntegerLabel.backgroundColor = inputView.backgroundColor;
	}
	else if (inputState == 1) {
		[inputView expandOperatorSelectView];
		inputView.aboveIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.belowIntegerLabel.backgroundColor = inputView.backgroundColor;
	}
	else if (inputState == 2) {
		inputView.belowIntegerLabel.backgroundColor = highlightColor;
		inputView.aboveIntegerLabel.backgroundColor = inputView.backgroundColor;
	}
	else {
		inputView.aboveIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.belowIntegerLabel.backgroundColor = inputView.backgroundColor;
		
		[functionButton setTitle:@"計算開始" forState:UIControlStateNormal];
		[functionButton.titleLabel setFont:[UIFont systemFontOfSize:60]];
	}
}

- (void)operatorSelected:(UIButton *)button
{
	switch (button.tag) {
		case 0:
			operatorString = @"+";
			break;
		case 1:
			operatorString = @"-";
			break;
		case 2:
			operatorString = @"×";
			break;
		case 3:
			operatorString = @"÷";
			break;
		default:
			break;
	}
	inputView.operatorSelectorView.hidden = YES;
	inputView.operatorLabel.hidden = NO;
	inputView.operatorLabel.text = operatorString;
	inputState++;
	[self context];
}

- (void)numberKeyTapped:(UIButton *)aButton
{
	//NSLog(@"Tapped at %d button.", (int)aButton.tag);
	
	//ラベル参照の仕方 for CalculateView
	//UILabel *aLabel = [[UILabel alloc] init];
	//aLabel = ((UILabel *)[calculateView.labels objectAtIndex:2]);
	//aLabel.text = [NSString stringWithFormat:@"%d", aButton.tag];
	
	if (inputState == 0) {
		aboveNumber = aboveNumber * 10 + aButton.tag;
		inputView.aboveIntegerLabel.hidden = NO;
		inputView.aboveIntegerLabel.text = [NSString stringWithFormat:@"%d", aboveNumber];
	} else if (inputState == 2) {
		belowNumber = belowNumber * 10 + aButton.tag;
		inputView.belowIntegerLabel.hidden = NO;
		inputView.belowIntegerLabel.text = [NSString stringWithFormat:@"%d", belowNumber];
	}
}

- (IBAction)allClearButtonAction:(id)sender {
	//NSLog(@"allClearButton tapped.");
	
	inputState = 0;
	modeState = 0;
	aboveNumber = belowNumber = 0;
	
	operatorString = @"";
	
	//calculateView側の処理
	for (UILabel *aLabel in calculateView.labels) {
		aLabel.text = @"";
	}
	
	[functionButton setTitle:@"入力" forState:UIControlStateNormal];
	[functionButton.titleLabel setFont:[UIFont systemFontOfSize:90]];
	
	[inputView resetOperatorView];
	inputView.aboveIntegerLabel.text = inputView.belowIntegerLabel.text = @"";
	inputView.operatorSelectorView.frame = inputView.operatorSelecterViewDefaultPosition;
	inputView.operatorSelectorView.hidden = NO;
	inputView.operatorLabel.hidden = YES;
	
	[self context];
}

- (IBAction)clearButtonAction:(id)sender {
	/*
	 //NSLog(@"clearButton tapped.");
	 
	 switch (inputState) {
	 case 0:
	 inputView.aboveIntegerLabel.text = @"";
	 aboveNumber = 0;
	 break;
	 case 1:
	 [inputView resetOperatorView];
	 break;
	 case 2:
	 inputView.belowIntegerLabel.text = @"";
	 belowNumber = 0;
	 inputView.operatorSelectorView.hidden = NO;
	 [inputView expandOperatorSelectView];
	 break;
	 default:
	 break;
	 }
	 
	 
	 inputState--;
	 
	 [functionButton setTitle:@"入力" forState:UIControlStateNormal];
	 [functionButton.titleLabel setFont:[UIFont systemFontOfSize:90]];
	 
	 [self context];
	 */
	
}

- (IBAction)functionButtonAction:(id)sender {
	inputState++;
	if (modeState == 0 && inputState == 3) {
		[calculateView arrangeCalculateViewWithAbove:aboveNumber WithBelow:belowNumber WithOperator:operatorString];
		modeState = 1;
	}
	[self context];
}

- (void)foriPhoneResizing
{
	// フォントサイズの調整を行う
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
	[allClearButton.titleLabel setFont:[UIFont systemFontOfSize:font_size]];
	[functionButton.titleLabel setFont:[UIFont systemFontOfSize:font_size]];
}

@end