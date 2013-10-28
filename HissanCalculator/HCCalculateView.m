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
	}
	return self;
}


// 桁数を引数に動的に生成できるようにする:現時点では2桁と2桁演算になっている
// 数学的に一般化が必要
- (void)arrangeCalculateView
{
	for (int i = 0; i < 5; i++) {
		for (int k = 0; k < 4; k++) {
			UILabel *aCellOfLabel = [[UILabel alloc] init];
			aCellOfLabel.frame = CGRectMake(self.bounds.origin.x + k * self.bounds.size.width / 4,
																			self.bounds.origin.y + i * self.bounds.size.height / 5,
																			(int)self.bounds.size.width / 4,
																			(int)self.bounds.size.height / 5);
			aCellOfLabel.tag = k + i * 4;
			aCellOfLabel.textAlignment = NSTextAlignmentCenter;
			aCellOfLabel.backgroundColor = self.backgroundColor;
			aCellOfLabel.textColor = [UIColor whiteColor];
			[aCellOfLabel setFont:[UIFont systemFontOfSize:90]];
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
