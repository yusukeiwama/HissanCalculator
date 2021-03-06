//
//  HCInputView.m
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/27/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import "HCInputView.h"

@implementation HCInputView {
	NSInteger margin;
	UIView *aLine;
	NSString *operatorString;
}

@synthesize aboveIntegerLabel;
@synthesize belowIntegerLabel;
@synthesize operatorSelectorView;
@synthesize operatorLabel;

@synthesize buttons;

@synthesize operatorSelecterViewDefaultPosition;
@synthesize operatorSelectButtonDefaultPositions;

@synthesize descriptionLabel;

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		margin = 10;
		
		// xibファイルを読み込み、クラスのカスタムビューとして指定
		NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"InputView"
															owner: self
														  options: nil];
		self = (HCInputView *)[nibObjects objectAtIndex:0];
		
		self.layer.cornerRadius = 20.0f;
		self.clipsToBounds = YES;
		
		// 次のようにSubViewを読み込まないと操作できないので注意。
		descriptionLabel = self.subviews[0];
		aLine = self.subviews[1];
		aboveIntegerLabel = self.subviews[2];
		belowIntegerLabel = self.subviews[3];
		operatorSelectorView = self.subviews[4];
		operatorLabel = self.subviews[5];
		
		operatorSelectButtonDefaultPositions = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)arrangeInputView
{
	aboveIntegerLabel.layer.cornerRadius = 20.0f;
	aboveIntegerLabel.clipsToBounds = YES;
	aboveIntegerLabel.adjustsFontSizeToFitWidth = YES;
	
	belowIntegerLabel.layer.cornerRadius = 20.0f;
	belowIntegerLabel.clipsToBounds = YES;
	belowIntegerLabel.adjustsFontSizeToFitWidth = YES;
	
	[[operatorSelectorView layer] setBorderColor:[[UIColor whiteColor] CGColor]];
	[[operatorSelectorView layer] setBorderWidth:1.0];
	operatorSelectorView.layer.cornerRadius = 20.0f;
	operatorSelectorView.clipsToBounds = YES;
	
	[descriptionLabel adjustsFontSizeToFitWidth];
	
	operatorSelecterViewDefaultPosition = operatorSelectorView.frame;
	[self dynamicOperatorButtonArrange];
	operatorLabel.hidden = YES;
}

// xibに直接書くと複雑になり、デバッグが難しくなるので動的に生成する。
- (void)dynamicOperatorButtonArrange
{
	NSValue *value;
	CGRect rect;
	
	for (int i = 0; i < 3; i++) {
		UIButton *aButton = [[UIButton alloc] init];
		aButton.frame = CGRectMake(operatorSelectorView.bounds.origin.x
								   + (i % 2) * (int)(operatorSelectorView.bounds.size.width / 2) + margin,
								   operatorSelectorView.bounds.origin.y
								   + (i / 2) * (int)(operatorSelectorView.bounds.size.height / 2) + margin,
								   (int)(operatorSelectorView.bounds.size.width / 2) - 2 * margin,
								   (int)(operatorSelectorView.bounds.size.height / 2) - 2 * margin);
		aButton.backgroundColor = operatorSelectorView.backgroundColor;
		
		// ボタンのデフォルトの位置をNSArrayに格納する。構造体のための処理。
		rect = aButton.frame;
		//NSLog(@"%@", NSStringFromCGRect(rect));
		value = [NSValue value:&rect withObjCType:@encode(CGRect)];
		//NSLog(@"%@", value);
		[operatorSelectButtonDefaultPositions addObject:value];
		// ------------------------------------------ ここまで。
		
		// すべての演算子に対応させる
		switch (i) {
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
		[aButton setTitle:operatorString forState:UIControlStateNormal];
		[aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[aButton.titleLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Light" size:60]];
		aButton.tag = 20 + i;
		[operatorSelectorView addSubview:aButton];
	}
}

- (void)expandOperatorSelectView
{
	margin = 10;
	for (UIButton *aButton in operatorSelectorView.subviews) {
		aButton.backgroundColor = operatorSelectorView.backgroundColor;
	}
	[UIView animateWithDuration:0.5f
					 animations:^{
						 CGFloat widthOfInputView = self.frame.size.width - 2 * margin;
						 operatorSelectorView.frame = CGRectMake(self.bounds.origin.x + margin,
																 self.center.y - (int)(widthOfInputView / 2)
																 - operatorSelectorView.frame.size.height,
																 widthOfInputView,
																 widthOfInputView);
						 
						 for (UIButton *aButton in operatorSelectorView.subviews) {
							 aButton.frame = CGRectMake(operatorSelectorView.bounds.origin.x + margin
														+ ((aButton.tag - 20) % 2) * (int)(widthOfInputView / 2),
														operatorSelectorView.bounds.origin.y + margin
														+ ((aButton.tag - 20) / 2) * (int)(widthOfInputView / 2),
														(int)((widthOfInputView - 2 * margin) / 2) - 2 * margin,
														(int)((widthOfInputView - 2 * margin) / 2) - 2 * margin);
							 aButton.backgroundColor = operatorSelectorView.backgroundColor;
						 }
					 } completion:^(BOOL parameter){
						 for (UIButton *aButton in operatorSelectorView.subviews) {
							 [aButton.titleLabel setFont:[UIFont systemFontOfSize:180]];
							 aButton.userInteractionEnabled = YES;
						 }
					 }];
}


- (void)resetOperatorView
{
	CGRect frame;
	operatorSelectorView.frame = operatorSelecterViewDefaultPosition;
	for (UIButton *aButton in operatorSelectorView.subviews) {
		
		// デフォルトの位置を読み込む。構造体をオブジェクトとして扱うための処理。aButton.tagによって順序を乱さないで取り出し可能(Oct 26)
		[(NSValue *)[operatorSelectButtonDefaultPositions objectAtIndex:aButton.tag - 20] getValue:&frame];
		aButton.frame = frame;
		[aButton.titleLabel setFont:[UIFont systemFontOfSize:60]];
		aButton.backgroundColor = self.backgroundColor;
		aButton.hidden = NO;
		aButton.userInteractionEnabled = NO;
	}
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
