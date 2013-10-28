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

UIColor *highlightColor;

@implementation HCViewController

@synthesize baseView;

@synthesize numberKeyButtons;
@synthesize clearButton;
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
	[calculateView arrangeCalculateView];
	
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
	if (int_state == 0) {
		inputView.aboveIntegerLabel.backgroundColor = highlightColor;
		inputView.belowIntegerLabel.backgroundColor = inputView.backgroundColor;
	} else if (int_state == 1) {
		[inputView
		 expandOperatorSelectView];
		inputView.aboveIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.belowIntegerLabel.backgroundColor = inputView.backgroundColor;
	} else if (int_state == 2) {
		inputView.belowIntegerLabel.backgroundColor = highlightColor;
		inputView.aboveIntegerLabel.backgroundColor = inputView.backgroundColor;
	} else {
		inputView.aboveIntegerLabel.backgroundColor = inputView.backgroundColor;
		inputView.belowIntegerLabel.backgroundColor = inputView.backgroundColor;
		
		[functionButton setTitle:@"計算開始" forState:UIControlStateNormal];
		[functionButton.titleLabel setFont:[UIFont systemFontOfSize:60]];
	}
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
	int_state++;
	[self context];
}

- (void)numberKeyTapped:(UIButton *)aButton
{
	//NSLog(@"Tapped at %d button.", (int)aButton.tag);
	
	//ラベル参照の仕方
	//UILabel *aLabel = [[UILabel alloc] init];
	//aLabel = ((UILabel *)[calculateView.labels objectAtIndex:2]);
	//aLabel.text = [NSString stringWithFormat:@"%d", aButton.tag];
	
	if (int_state == 0) {
		leftNumber = leftNumber * 10 + aButton.tag;
		inputView.aboveIntegerLabel.hidden = NO;
		inputView.aboveIntegerLabel.text = [NSString stringWithFormat:@"%d", leftNumber];
	} else if (int_state == 2) {
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
	
	/* calculateView側の処理
	 for (UILabel *aLabel in calculateView.labels) {
	 aLabel.text = @"";
	 }
	 */
	
	[functionButton setTitle:@"入力" forState:UIControlStateNormal];
	[functionButton.titleLabel setFont:[UIFont systemFontOfSize:90]];
	
	[inputView resetOperatorView];
	
	inputView.aboveIntegerLabel.text = @"";
	inputView.belowIntegerLabel.text = @"";
	
	inputView.operatorSelectorView.frame = inputView.operatorSelecterViewDefaultPosition;
	inputView.operatorSelectorView.hidden = NO;
	
	inputView.operatorLabel.hidden = YES;
	[self context];
}


- (IBAction)functionButton:(id)sender {
	int_state++;
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
	[clearButton.titleLabel setFont:[UIFont systemFontOfSize:font_size]];
	[functionButton.titleLabel setFont:[UIFont systemFontOfSize:font_size]];
}

@end