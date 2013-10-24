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

- (void)tapped:(UITapGestureRecognizer *)recognizer {
	NSLog(@"tapped");
	[UIView animateWithDuration:0.5f
									 animations:^{
										 hissanView.operatorSelectorView.frame = CGRectMake(hissanView.bounds.origin.x + margin,
																																				hissanView.bounds.origin.y + margin + (int)((hissanView.bounds.size.height - hissanView.bounds.size.width) / 2),
																																				hissanView.bounds.size.width - 2 * margin,
																																				hissanView.bounds.size.width - 2 * margin);
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
	NSLog(@"push");
	hissanView.operatorSelectorView.hidden = YES;
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
	
	leftNumber = leftNumber * 10 + aButton.tag;
	hissanView.leftIntegerLabel.hidden = NO;
	hissanView.leftIntegerLabel.text = [NSString stringWithFormat:@"%d", leftNumber];
}

- (IBAction)clearButton:(id)sender {
	//NSLog(@"clearButton tapped.");
	int_state = 0;
	leftNumber = 0;
	for (UILabel *aLabel in hissanView.labels) {
		aLabel.text = @"";
	}
	hissanView.leftIntegerLabel.hidden = YES;
}

- (IBAction)calculateButton:(id)sender {
	NSLog(@"calcButton tapped.");
	int_state = 5;
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