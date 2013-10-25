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

//@synthesize hissanView;
//@synthesize numberKeyButtons;
@synthesize clearButton;
//@synthesize functionButton;

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// デバイスがiPhoneだった場合、サイズの調整を行う。
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		//[self foriPhoneResizing];
	}
	
	// xibから読み込むテスト
	NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"InputView"
																													 owner: self
																												 options: nil];
	inputView = [topLevelObjects objectAtIndex:0];
	inputView.frame = CGRectMake(inputView.frame.origin.x + 2 * margin,
													inputView.frame.origin.y + 2 * margin,
													inputView.frame.size.width,
													inputView.frame.size.height);
	[self.view addSubview:inputView];
	
	//[hissanView arrangeInputView];
	//[self context];
	
	/*
	for (UIButton *aButton in numberKeyButtons) {
		[aButton addTarget:self
								action:@selector(numberKeyTapped:)
		  forControlEvents:UIControlEventTouchUpInside];
	}
	 */
	
	//UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
	//[hissanView.operatorSelectorView addGestureRecognizer:recognizer];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/*
- (void)context
{
	if (int_state == 0) {
		hissanView.aboveIntegerLabel.backgroundColor = [UIColor colorWithRed:90.0 / 255.0
																																	 green:150.0 / 255.0
																																		blue:120.0 / 255.0
																																	 alpha:1.0];
		hissanView.belowIntegerLabel.backgroundColor = hissanView.backgroundColor;
	} else if (int_state == 1) {
		hissanView.belowIntegerLabel.backgroundColor = [UIColor colorWithRed:90.0 / 255.0
																																	 green:150.0 / 255.0
																																		blue:120.0 / 255.0
																																	 alpha:1.0];
		hissanView.aboveIntegerLabel.backgroundColor = hissanView.backgroundColor;
	} else {
		hissanView.belowIntegerLabel.backgroundColor = hissanView.backgroundColor;
		[functionButton setTitle:@"計算開始" forState:UIControlStateNormal];
		[functionButton.titleLabel setFont:[UIFont systemFontOfSize:60]];
 	}
	
}

- (void)tapped:(UITapGestureRecognizer *)recognizer {
	[UIView animateWithDuration:0.5f
									 animations:^{
										 [hissanView bringSubviewToFront:hissanView.operatorSelectorView];
										 CGFloat widthOfHissanView = hissanView.bounds.size.width;
										 hissanView.operatorSelectorView.frame = CGRectMake(hissanView.bounds.origin.x + margin,
																																				hissanView.bounds.origin.y + margin,
																																				widthOfHissanView - 2 * margin,
																																				widthOfHissanView - 2 * margin);
										 
										 for (UIButton *aButton in hissanView.operatorSelectorView.subviews) {
											 aButton.frame = CGRectMake(hissanView.operatorSelectorView.bounds.origin.x + margin + (aButton.tag % 2) * (int)(widthOfHissanView / 2),
																									hissanView.operatorSelectorView.bounds.origin.y + margin + (aButton.tag / 2) * (int)(widthOfHissanView / 2),
																									(int)((widthOfHissanView - 2 * margin) / 2) - 2 * margin,
																									(int)((widthOfHissanView - 2 * margin) / 2) - 2 * margin);
										 }
									 } completion:^(BOOL par){
										 for (UIButton *aButton in hissanView.operatorSelectorView.subviews) {
											 [aButton.titleLabel setFont:[UIFont systemFontOfSize:180]];
										 }
									 }];
	
	for (UIButton *aButton in hissanView.operatorSelectorView.subviews) {
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
	hissanView.operatorSelectorView.hidden = YES;
	hissanView.operatorLabel.hidden = NO;
	hissanView.operatorLabel.text = operator;
	[self context];
}

- (void)numberKeyTapped:(UIButton *)aButton
{
	//NSLog(@"Tapped at %d button.", (int)aButton.tag);
	
	/
	 UILabel *aLabel = [[UILabel alloc] init];
	 if (int_state > 4) int_state = 4;
	 
	 switch (int_state) {
	 case 0:
	 aLabel = ((UILabel *)[hissanView.labels objectAtIndex:2]);
	 break;
	 case 1:
	 aLabel = ((UILabel *)[hissanView.labels objectAtIndex:3]);
	 break;
	 case 2:
	 aLabel = ((UILabel *)[hissanView.labels objectAtIndex:6]);
	 break;
	 case 3:
	 aLabel = ((UILabel *)[hissanView.labels objectAtIndex:7]);
	 break;
	 case 4:
	 break;
	 default:
	 break;
	 }
	 aLabel.text = [NSString stringWithFormat:@"%d", aButton.tag];
	 int_state++;
	 /
	
	if (int_state == 0) {
		leftNumber = leftNumber * 10 + aButton.tag;
		hissanView.aboveIntegerLabel.hidden = NO;
		hissanView.aboveIntegerLabel.text = [NSString stringWithFormat:@"%d", leftNumber];
	} else {
		rightNumber = rightNumber * 10 + aButton.tag;
		hissanView.belowIntegerLabel.hidden = NO;
		hissanView.belowIntegerLabel.text = [NSString stringWithFormat:@"%d", rightNumber];
	}
	[self context];
}
*/
 
- (IBAction)clearButton:(id)sender {
	//NSLog(@"clearButton tapped.");
	/*[self context];
	int_state = 0;
	leftNumber = 0;
	rightNumber = 0;
	
	for (UILabel *aLabel in hissanView.labels) {
		aLabel.text = @"";
	}
	
	hissanView.aboveIntegerLabel.hidden = YES;
	hissanView.belowIntegerLabel.hidden = YES;
	hissanView.operatorSelectorView.backgroundColor = [UIColor colorWithRed:90.0 / 255.0
																																		green:150.0 / 255.0
																																		 blue:120.0 / 255.0
																																		alpha:1.0];
	
	hissanView.operatorSelectorView.frame = hissanView.operatorSelecterViewDefaultPosition;
	hissanView.operatorLabel.hidden = YES;
	hissanView.operatorSelectorView.hidden = NO;
	
	CGRect frame;
	for (UIButton *aButton in hissanView.operatorSelectorView.subviews) {
		// デフォルトの位置を読み込む。構造体のための処理。
		[(NSValue *)[hissanView.operatorSelectButtonDefaultPositions objectAtIndex:aButton.tag] getValue:&frame];
    aButton.frame = frame;
		[aButton.titleLabel setFont:[UIFont systemFontOfSize:60]];
		aButton.hidden = NO;
	}*/
	inputView.hidden = YES;
}

/*
- (IBAction)functionButton:(id)sender {
	[self context];
	int_state++;
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
*/

@end