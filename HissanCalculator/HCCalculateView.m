//
//  HCCalculateView.m
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/28/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import "HCCalculateView.h"

@implementation HCCalculateView

@synthesize labels;

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		// Initialization code
		NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"CalculateView"
																												owner: self
																											options: nil];
		self = [nibObjects objectAtIndex:0];
		self.layer.cornerRadius = 20.0f;
		self.clipsToBounds = YES;
		//NSLog(@"calView : %@", [nibObjects description]);
		
		labels = [[NSMutableArray alloc] init];
	}
	return self;
}

// 桁数を引数に動的に生成できるようにする:現時点では2桁と2桁演算になっている
// 数学的に一般化が必要
- (void)arrangeCalculateViewWithAbove:(NSInteger)aboveInteger WithBelow:(NSInteger)belowInteger WithOperator:(NSString *)operatorString
{
	int row, column;
	for (UIView *aView in [self subviews]) {
    [aView removeFromSuperview];
	}
	
	NSInteger rowMax = 0;
	NSInteger columnMax = 0;
	if ([operatorString compare:@"+"] == NSOrderedSame) {
		rowMax = 3;
		columnMax = 3;
	} else if ([operatorString compare:@"-"] == NSOrderedSame) {
		rowMax = 3;
		columnMax = 3;
	} else if ([operatorString compare:@"×"] == NSOrderedSame) {
		rowMax = 5;
		columnMax = 4;
	} else if ([operatorString compare:@"÷"] == NSOrderedSame) {
		rowMax = 3;
		columnMax = 6;
	}
	
	for (row = 0; row < rowMax; row++) {
		for (column = 0; column < columnMax; column++) {
			UILabel *aCellOfLabel = [[UILabel alloc] init];
			aCellOfLabel.frame = CGRectMake(self.bounds.origin.x + column * self.bounds.size.width / columnMax,
																			self.bounds.origin.y + row * self.bounds.size.height / rowMax,
																			(int)self.bounds.size.width / columnMax,
																			(int)self.bounds.size.height / rowMax);
			aCellOfLabel.tag = column + row * columnMax;
			aCellOfLabel.textAlignment = NSTextAlignmentCenter;
			
			aCellOfLabel.adjustsFontSizeToFitWidth = YES;
			aCellOfLabel.minimumScaleFactor = 100.0f;
			aCellOfLabel.backgroundColor = self.backgroundColor;
			aCellOfLabel.textColor = [UIColor whiteColor];
			[aCellOfLabel setFont:[UIFont systemFontOfSize:125]];
			[self addSubview:aCellOfLabel];
			
			UILabel *superScriptLabel = [[UILabel alloc] init];
			superScriptLabel.frame = CGRectMake(aCellOfLabel.bounds.origin.x + 3 * (int)(aCellOfLabel.bounds.size.width / 5),
																					aCellOfLabel.bounds.origin.y,
																					(int)(aCellOfLabel.bounds.size.width / 5),
																					(int)(aCellOfLabel.bounds.size.height / 5));
			superScriptLabel.textAlignment = NSTextAlignmentCenter;
			[superScriptLabel setFont:[UIFont systemFontOfSize:30]];
			superScriptLabel.backgroundColor = aCellOfLabel.backgroundColor;
			[aCellOfLabel addSubview:superScriptLabel];
			
			[labels addObject:aCellOfLabel];
		}
	}
	//NSLog(@"%d,%d", aboveInteger, belowInteger);
	
	
	if ([operatorString compare:@"÷"] == NSOrderedSame) {
	}
	else {
		((UILabel *)[labels objectAtIndex:columnMax - 2]).text = [NSString stringWithFormat:@"%d", (aboveInteger / 10)];
		((UILabel *)[labels objectAtIndex:columnMax - 1]).text = [NSString stringWithFormat:@"%d", (aboveInteger % 10)];
		((UILabel *)[labels objectAtIndex:columnMax]).text = operatorString;
		((UILabel *)[labels objectAtIndex:(2 * columnMax - 2)]).text = [NSString stringWithFormat:@"%d", (belowInteger / 10)];
		((UILabel *)[labels objectAtIndex:(2 * columnMax - 1)]).text = [NSString stringWithFormat:@"%d", (belowInteger % 10)];
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
