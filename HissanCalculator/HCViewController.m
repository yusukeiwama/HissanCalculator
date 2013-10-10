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

@implementation HCViewController

@synthesize hissanView;
@synthesize numberKeyButtons;
@synthesize clearButton;
@synthesize calculateButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	hissanView.layer.cornerRadius = 50.0f;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {[self foriPhoneResizing];}
	for (UIButton *aButton in numberKeyButtons) {
		[aButton addTarget:self action:@selector(numberKeyTapped:) forControlEvents:UIControlEventTouchUpInside];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)numberKeyTapped:(UIButton *)button
{
	NSLog(@"Tapped at %d button.", (int)button.tag);
}

- (IBAction)clearButton:(id)sender {
	NSLog(@"clearButton tapped.");
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