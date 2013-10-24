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

NSInteger int_state = 0; // 仮に状態を表す整数。今後stateプロトコルに準拠させる。
NSInteger leftNumber = 0;
NSInteger rightNumber = 0;
const NSInteger margin = 10;
@implementation HCViewController

@synthesize hissanView;
@synthesize numberKeyButtons;
@synthesize clearButton;
@synthesize calculateButton;

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		[self foriPhoneResizing];
	}
	
	[hissanView arrangeInputView];
	[self context];
	
	/*if ([state isKindOfClass:[HCCreateFomulaState class]]) {
	 [hissanView arrangeInputView];
	 } else {
	 [hissanView arrangeHissanView];
	 }*/
	
	for (UIButton *aButton in numberKeyButtons) {
		[aButton addTarget:self
								action:@selector(numberKeyTapped:)
		  forControlEvents:UIControlEventTouchUpInside];
	}
	
	UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
	[hissanView.operatorSelectorView addGestureRecognizer:recognizer];
}

- (void)context
{
	if (int_state == 0) {
		hissanView.leftIntegerLabel.backgroundColor = [UIColor colorWithRed:90.0 / 255.0
																																	green:150.0 / 255.0
																																	 blue:120.0 / 255.0
																																	alpha:1.0];
		hissanView.rightIntegerLabel.backgroundColor = hissanView.backgroundColor;
	} else if (int_state == 1) {
		hissanView.rightIntegerLabel.backgroundColor = [UIColor colorWithRed:90.0 / 255.0
																																	 green:150.0 / 255.0
																																		blue:120.0 / 255.0
																																	 alpha:1.0];
		hissanView.leftIntegerLabel.backgroundColor = hissanView.backgroundColor;
	} else {
		hissanView.rightIntegerLabel.backgroundColor = hissanView.backgroundColor;
		[calculateButton setTitle:@"計算開始" forState:UIControlStateNormal];
		[calculateButton.titleLabel setFont:[UIFont systemFontOfSize:60]];
 	}
	
}

- (void)tapped:(UITapGestureRecognizer *)recognizer {
	NSLog(@"tapped");
	[UIView animateWithDuration:0.5f
									 animations:^{
										 hissanView.operatorSelectorView.frame = CGRectMake(hissanView.bounds.origin.x + margin,
																																				hissanView.bounds.origin.y + margin + (int)((hissanView.bounds.size.height - hissanView.bounds.size.width) / 2),
																																				hissanView.bounds.size.width - 2 * margin,
																																				hissanView.bounds.size.width - 2 * margin);
										 for (UIButton *aButton in hissanView.operatorSelectorView.subviews) {
											 aButton.frame = CGRectMake(hissanView.operatorSelectorView.bounds.origin.x + (aButton.tag % 2) * (int)(hissanView.operatorSelectorView.frame.size.width / 2),
																									hissanView.operatorSelectorView.bounds.origin.y + (aButton.tag / 2) * (int)(hissanView.operatorSelectorView.frame.size.width / 2),
																									(int)(hissanView.operatorSelectorView.frame.size.width / 2),
																									(int)(hissanView.operatorSelectorView.frame.size.width / 2));
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
}

- (void)operatorSelected:(UIButton *)button
{
	hissanView.operatorSelectorView.hidden = YES;
	hissanView.operatorLabel.hidden = NO;
	hissanView.operatorLabel.text = [NSString stringWithFormat:@"×"];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)numberKeyTapped:(UIButton *)aButton
{
	//NSLog(@"Tapped at %d button.", (int)aButton.tag);
	
	/*
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
	 */
	
	if (int_state == 0) {
	leftNumber = leftNumber * 10 + aButton.tag;
	hissanView.leftIntegerLabel.hidden = NO;
	hissanView.leftIntegerLabel.text = [NSString stringWithFormat:@"%d", leftNumber];
	} else {
		rightNumber = rightNumber * 10 + aButton.tag;
		hissanView.rightIntegerLabel.hidden = NO;
		hissanView.rightIntegerLabel.text = [NSString stringWithFormat:@"%d", rightNumber];
	}
		[self context];
}

- (IBAction)clearButton:(id)sender {
	//NSLog(@"clearButton tapped.");
	int_state = 0;
	leftNumber = 0;
	rightNumber = 0;
	for (UILabel *aLabel in hissanView.labels) {
		aLabel.text = @"";
	}
	hissanView.leftIntegerLabel.hidden = YES;
	hissanView.rightIntegerLabel.hidden = YES;
	hissanView.operatorSelectorView.backgroundColor = [UIColor colorWithRed:90.0 / 255.0
																												 green:150.0 / 255.0
																													blue:120.0 / 255.0
																												 alpha:1.0];
	hissanView.operatorSelectorView.frame = CGRectMake(hissanView.bounds.origin.x + (int)(hissanView.bounds.size.width - (int)(hissanView.bounds.size.height / 6)) / 2,
																					hissanView.bounds.origin.y + margin + hissanView.leftIntegerLabel.frame.size.height + hissanView.downSpace,
																					(int)(hissanView.bounds.size.height / 6),
																					(int)(hissanView.bounds.size.height / 6));
	
	hissanView.operatorLabel.hidden = YES;
	hissanView.operatorSelectorView.hidden = NO;
	for (UIButton *aButton in hissanView.operatorSelectorView.subviews) {
    aButton.frame = CGRectMake(hissanView.operatorSelectorView.bounds.origin.x + (aButton.tag % 2) * (int)(hissanView.operatorSelectorView.bounds.size.width / 2) + margin,
															 hissanView.operatorSelectorView.bounds.origin.y + (aButton.tag / 2) * (int)(hissanView.operatorSelectorView.bounds.size.height / 2) + margin,
															 (int)(hissanView.operatorSelectorView.bounds.size.width / 2) - 2 * margin,
															 (int)(hissanView.operatorSelectorView.bounds.size.height / 2) - 2 * margin);
		[aButton.titleLabel setFont:[UIFont systemFontOfSize:60]];
		
	}
	
	[self context];
}

- (IBAction)calculateButton:(id)sender {
	NSLog(@"calcButton tapped.");
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
	[calculateButton.titleLabel setFont:[UIFont systemFontOfSize:font_size]];
}

@end