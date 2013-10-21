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
	state = [[HCCreateFomulaState alloc] init];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {[self foriPhoneResizing];}
	for (UIButton *aButton in numberKeyButtons) {
		[aButton addTarget:self action:@selector(numberKeyTapped:) forControlEvents:UIControlEventTouchUpInside];
	}
}

- (void)tapped:(UIButton *)button {
	state = [state getNextState];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)numberKeyTapped:(UIButton *)aButton
{
	//NSLog(@"Tapped at %d button.", (int)aButton.tag);
	
	if (int_state > 4) int_state = 4;
	
	switch (int_state) {
		case 0:
			((UILabel *)[hissanView.labels objectAtIndex:2]).text = [NSString stringWithFormat:@"%d", aButton.tag];
			break;
		case 1:
			((UILabel *)[hissanView.labels objectAtIndex:3]).text = [NSString stringWithFormat:@"%d", aButton.tag];
			break;
		case 2:
			((UILabel *)[hissanView.labels objectAtIndex:6]).text = [NSString stringWithFormat:@"%d", aButton.tag];
			break;
		case 3:
			((UILabel *)[hissanView.labels objectAtIndex:7]).text = [NSString stringWithFormat:@"%d", aButton.tag];
			break;
		case 4:
			break;
		default:
			break;
	}
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