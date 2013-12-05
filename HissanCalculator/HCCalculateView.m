//
//  HCCalculateView.m
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/28/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import "HCCalculateView.h"
#import "HCCalculator.h"
#import "HCColor.h"

@implementation HCCalculateView {
	NSInteger margin;
	UIView *aLine;
	HCCalculator *calculator;
}

@synthesize labels;
@synthesize rowMax;
@synthesize columnMax;
@synthesize descriptionLabel;

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		margin = 10;
		self.layer.cornerRadius = 20.0f;
		self.clipsToBounds = YES;
		self.backgroundColor = [HCColor blackBoardColor];
		calculator = [[HCCalculator alloc] init];
		}
	return self;
}

// 桁数を引数に動的に生成できるようにする
- (void)arrangeCalculateViewWithAbove:(NSInteger)aboveInteger WithBelow:(NSInteger)belowInteger WithOperator:(NSString *)operatorString
{
	// 動的に生成するために一度画面をクリア
	for (UIView *aView in [self subviews]) {
		[aView removeFromSuperview];
	}

	descriptionLabel = [[UILabel alloc] init];
	descriptionLabel.frame = CGRectMake(10, 10, self.bounds.size.width - 20, 60);
	descriptionLabel.textColor = [UIColor whiteColor];
	descriptionLabel.backgroundColor = self.backgroundColor;
	descriptionLabel.text = @"";
	[descriptionLabel adjustsFontSizeToFitWidth];
	descriptionLabel.numberOfLines = 2;
	[descriptionLabel setFont:[UIFont systemFontOfSize:25]];
	[self addSubview:descriptionLabel];
	
	
	labels = [[NSMutableArray alloc] init];
	
	rowMax = columnMax = 0;
	if ([operatorString compare:@"+"] == NSOrderedSame) {
		rowMax = 3;
		columnMax = [calculator getDigitWithInteger:aboveInteger] + 1;
	}
	else if ([operatorString compare:@"-"] == NSOrderedSame) {
		rowMax = 3;
		columnMax = [calculator getDigitWithInteger:aboveInteger] + 1;
	}
	else if ([operatorString compare:@"×"] == NSOrderedSame) {
		rowMax = [calculator getDigitWithInteger:belowInteger] + 3;
		columnMax = [calculator getDigitWithInteger:aboveInteger] + [calculator getDigitWithInteger:belowInteger];
	}
	else if ([operatorString compare:@"÷"] == NSOrderedSame) {
		rowMax = 2 * ([calculator getDigitWithInteger:aboveInteger] + 1);
		columnMax = [calculator getDigitWithInteger:aboveInteger]
		+ [calculator getDigitWithInteger:belowInteger];
	}
	
	for (int row = 0; row < rowMax; row++) {
		for (int column = 0; column < columnMax; column++) {
			UILabel *aCellOfLabel = [[UILabel alloc] init];
			aCellOfLabel.frame = CGRectMake(self.bounds.origin.x + column * self.bounds.size.width / columnMax,
																			self.bounds.origin.y + row * (self.bounds.size.height - 80) / rowMax + 80,
																			(int)self.bounds.size.width / columnMax,
																			((int)self.bounds.size.height - 80) / rowMax);
			aCellOfLabel.tag = column + row * columnMax;
			aCellOfLabel.textAlignment = NSTextAlignmentCenter;
			
			aCellOfLabel.layer.cornerRadius = 20.0f;
			aCellOfLabel.clipsToBounds = YES;
			
			aCellOfLabel.backgroundColor = self.backgroundColor;
			aCellOfLabel.textColor = [UIColor whiteColor];
			if ([operatorString compare:@"×"] == NSOrderedSame) {
				[aCellOfLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Light" size:80]];
				aCellOfLabel.adjustsFontSizeToFitWidth = YES;
			} else {
				[aCellOfLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Light" size:90]];
			}
			[self addSubview:aCellOfLabel];
			
			UILabel *superScriptLabel = [[UILabel alloc] init];
			superScriptLabel.frame = CGRectMake(aCellOfLabel.bounds.origin.x + 3 * (int)(aCellOfLabel.bounds.size.width / 5),
																					aCellOfLabel.bounds.origin.y,
																					(int)(aCellOfLabel.bounds.size.width / 5),
																					(int)(aCellOfLabel.bounds.size.height / 5));
			superScriptLabel.textAlignment = NSTextAlignmentCenter;
			superScriptLabel.layer.cornerRadius = 5.0f;
			superScriptLabel.clipsToBounds = YES;
			superScriptLabel.adjustsFontSizeToFitWidth = YES;
			if ([operatorString compare:@"×"] == NSOrderedSame) {
				[superScriptLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Light" size:15]];
				
			} else {
				[superScriptLabel setFont:[UIFont fontWithName:@"ChalkboardSE-Light" size:25]];
			}
			
			[superScriptLabel setTextColor:[UIColor whiteColor]];
			superScriptLabel.backgroundColor = aCellOfLabel.backgroundColor;
			[aCellOfLabel addSubview:superScriptLabel];
			[labels addObject:aCellOfLabel];
		}
	}
	
	if ([operatorString compare:@"÷"] == NSOrderedSame) {
		
	} else {
		
		for (int i = 0; i < [calculator getDigitWithInteger:aboveInteger]; i++) {
			((UILabel *)[labels objectAtIndex:columnMax - (i + 1)]).text =
			[NSString stringWithFormat:@"%d", [calculator pickUpDigitWithTargetNumber:aboveInteger WithDigit:i + 1]];
		}
		
		for (int i = 0; i < [calculator getDigitWithInteger:belowInteger]; i++) {
			((UILabel *)[labels objectAtIndex:2 * columnMax - (i + 1)]).text =
			[NSString stringWithFormat:@"%d", [calculator pickUpDigitWithTargetNumber:belowInteger WithDigit:i + 1]];
		}
		
		((UILabel *)[labels objectAtIndex:columnMax]).text = operatorString;
		
		aLine = [[UIView alloc] init];
		aLine.frame = CGRectMake(((UILabel *)[labels objectAtIndex:2*columnMax]).frame.origin.x + margin,
														 ((UILabel *)[labels objectAtIndex:2*columnMax]).frame.origin.y,
														 self.frame.size.width - 2 * margin,
														 5);
		aLine.backgroundColor = [UIColor whiteColor];
		[self addSubview:aLine];
	}
	
	
	
	if ([operatorString compare:@"+"] == NSOrderedSame) {
		[calculator additionWithAboveInteger:aboveInteger WithBelowInteger:belowInteger];
		for (int i = 0; i < [calculator.resultArray count]; i++) {
			((UILabel *)[labels objectAtIndex:3 * columnMax - (i + 1)]).text =
			[NSString stringWithFormat:@"%d", [[calculator.resultArray objectAtIndex:i] integerValue]];
			if ([[calculator.carryArray objectAtIndex:i] integerValue] != 0) {
				((UILabel *)((UIView *)[labels objectAtIndex:3 * columnMax - (i + 1)]).subviews[0]).text =
				[NSString stringWithFormat:@"%d", [[calculator.carryArray objectAtIndex:i] integerValue]];
				((UILabel *)((UIView *)[labels objectAtIndex:3 * columnMax - (i + 1)]).subviews[0]).textColor = [UIColor clearColor];
			}
			((UILabel *)[labels objectAtIndex:3 * columnMax - (i + 1)]).textColor = [UIColor clearColor];
		}
		for (int i = 0; i < columnMax - 1; i++) {
			if ([((UILabel *)[labels objectAtIndex:2 * columnMax + i]).text compare:@"0"] == NSOrderedSame) {
				((UILabel *)[labels objectAtIndex:2 * columnMax + i]).text = @"";
			} else {
				break;
			}
		}
	}
	
	else if ([operatorString compare:@"-"] == NSOrderedSame) {
		[calculator subtractionWithAboveInteger:aboveInteger WithBelowInteger:belowInteger];
		for (int i = 0; i < [calculator.resultArray count]; i++) {
			((UILabel *)[labels objectAtIndex:3 * columnMax - (i + 1)]).text =
			[NSString stringWithFormat:@"%d", [[calculator.resultArray objectAtIndex:i] integerValue]];
			((UILabel *)[labels objectAtIndex:3 * columnMax - (i + 1)]).textColor = [UIColor clearColor];
			if ([[calculator.borrowReferenceArray objectAtIndex:i] integerValue]
					!= [[calculator.aboveOriginalIntegerArray objectAtIndex:i] integerValue]) {
				((UILabel *)((UIView *)[labels objectAtIndex:columnMax - (i + 1)]).subviews[0]).text =
				[NSString stringWithFormat:@"%d", [[calculator.borrowReferenceArray objectAtIndex:i] integerValue]];
				((UILabel *)((UIView *)[labels objectAtIndex:columnMax - (i + 1)]).subviews[0]).textColor = [UIColor clearColor];
			}
			
		}
		for (int i = 0; i < columnMax - 1; i++) {
			if ([((UILabel *)[labels objectAtIndex:2 * columnMax + i]).text compare:@"0"] == NSOrderedSame) {
				((UILabel *)[labels objectAtIndex:2 * columnMax + i]).text = @"";
			} else {
				break;
			}
		}
		
	}
	
	else if ([operatorString compare:@"×"] == NSOrderedSame) {
		[calculator multiplicationWithAboveInteger:aboveInteger WithBelowInteger:belowInteger];
		
		aLine = [[UIView alloc] init];
		aLine.frame = CGRectMake(((UILabel *)[labels objectAtIndex:columnMax * (rowMax - 1)]).frame.origin.x + margin,
														 ((UILabel *)[labels objectAtIndex:columnMax * (rowMax - 1)]).frame.origin.y,
														 self.frame.size.width - 2 * margin,
														 5);
		aLine.backgroundColor = [UIColor whiteColor];
		[self addSubview:aLine];
		
		NSInteger aboveDigit = [calculator getDigitWithInteger:aboveInteger];
		NSInteger belowDigit = [calculator getDigitWithInteger:belowInteger];
		
		for (int i = 0; i < belowDigit; i++) {
			for (int j = 0; j <= aboveDigit + belowDigit - 1; j++) {
				((UILabel *)[labels objectAtIndex:(i + 3) * columnMax - (j + 1)]).text =
				[NSString stringWithFormat:@"%d",
				 [(NSNumber *)([[calculator.belowResultArray objectAtIndex:i] objectAtIndex:j]) integerValue]];
				
				if ([(NSNumber *)([[calculator.belowIntegerArray objectAtIndex:i] objectAtIndex:j]) integerValue] > 0) {
					((UILabel *)((UILabel *)[labels objectAtIndex:(i + 3) * columnMax - (j + 1)]).subviews[0]).text =
					[NSString stringWithFormat:@"%d",
					 [(NSNumber *)([[calculator.belowIntegerArray objectAtIndex:i] objectAtIndex:j]) integerValue]];
				}
			}
		}
		
		for (int i = 0; i < [calculator.resultArray count]; i++) {
			((UILabel *)[labels objectAtIndex:columnMax * rowMax - (i + 1)]).text =
			[NSString stringWithFormat:@"%d", [[calculator.resultArray objectAtIndex:i] integerValue]];
			
			if ([[[calculator.belowIntegerArray objectAtIndex:belowDigit] objectAtIndex:i] integerValue] > 0) {
				
				((UILabel *)((UILabel *)[labels objectAtIndex:columnMax * rowMax - (i + 1)]).subviews[0]).text =
				[NSString stringWithFormat:@"%d", [[[calculator.belowIntegerArray objectAtIndex:belowDigit] objectAtIndex:i] integerValue]];
			}
		}
		
		BOOL flg = NO; // 一回だけ実行したいので一旦。
		for (int j = 0; j < rowMax - 3; j++) {
			flg = NO;
			for (int i = 0; i < columnMax; i++) {
				if ([((UILabel *)[labels objectAtIndex:(j + 2) * columnMax + i]).text compare:@"-1"] == NSOrderedSame) {
					((UILabel *)[labels objectAtIndex:(j + 2) * columnMax + i]).text = @"";
				} else {
					if (flg == NO) {
						i += aboveDigit - 1;
						flg = YES;
					}
				}
			}
		}
		for (int i = 0; i < columnMax; i++) {
			if ([((UILabel *)[labels objectAtIndex:columnMax * (rowMax - 1) + i]).text compare:@"0"] == NSOrderedSame) {
				((UILabel *)[labels objectAtIndex:columnMax * (rowMax - 1) + i]).text = @"";
			} else {
				break;
			}
		}
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
