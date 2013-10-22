//
//  HCHissanView.m
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/15/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import "HCHissanView.h"

const NSInteger margin = 10;

@implementation HCHissanView

@synthesize state;
@synthesize labels;

// using xib files or story board.
-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if(self){
		// Initialization code
		self.layer.cornerRadius = 20.0f;
		self.clipsToBounds = YES;
		labels = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)arrangeInputView {
	
	
}

- (void)arrangeHissanView {
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
	
	UIView *aLine = [[UIView alloc] init];
	aLine.frame = CGRectMake(self.bounds.origin.x + margin,
													 ((UILabel *)[labels objectAtIndex:8]).frame.origin.y,
													 self.bounds.size.width - 2 * margin,
													 5);
	aLine.backgroundColor = [UIColor whiteColor];
	[self addSubview:aLine];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {}
@end
