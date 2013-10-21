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
	if ([state isKindOfClass:[HCCreateFomulaState class]]) {
		[hissanView arrangeInputView];
	} else {
		[hissanView arrangeHissanView];
	}
	for (UIButton *aButton in numberKeyButtons) {
		[aButton addTarget:self
								action:@selector(numberKeyTapped:)
		  forControlEvents:UIControlEventTouchUpInside];
	}
}

- (void)tapped:(UIButton *)button {
	hissanView.state = [state getNextState];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)numberKeyTapped:(UIButton *)aButton
{
	//NSLog(@"Tapped at %d button.", (int)aButton.tag);
	
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
}

- (IBAction)clearButton:(id)sender {
	//NSLog(@"clearButton tapped.");
	
	int_state = 0;
	for (UILabel *aLabel in hissanView.labels) {
		aLabel.text = @"";
	}
}

- (IBAction)calculateButton:(id)sender {
	NSLog(@"calcButton tapped.");
}

- (void)foriPhoneResizing
{
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