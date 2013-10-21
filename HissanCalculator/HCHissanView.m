//
//  HCHissanView.m
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/15/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import "HCHissanView.h"
#import "HCCreateFomulaState.h"
#import "HCCalculationState.h"

@implementation HCHissanView

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
		
		for (int i = 0; i < 5; i++) {
			for (int k = 0; k < 4; k++) {
				UILabel *aLabel = [[UILabel alloc] initWithFrame:
								   CGRectMake(self.bounds.origin.x + k * self.bounds.size.width / 4,
											  self.bounds.origin.y + i * self.bounds.size.height / 5,
											  (int)self.bounds.size.width / 4,
											  (int)self.bounds.size.height / 5)];
				
				aLabel.tag = k + i * 4;
				aLabel.textAlignment = NSTextAlignmentCenter;
				aLabel.backgroundColor = self.backgroundColor;
				aLabel.textColor = [UIColor whiteColor];
				[aLabel setFont:[UIFont systemFontOfSize:90]];
				[self addSubview:aLabel];
				
				UILabel *superScriptLabel = [[UILabel alloc] initWithFrame:
											 CGRectMake(aLabel.bounds.origin.x + 3 * aLabel.bounds.size.width / 5,
														aLabel.bounds.origin.y,
														(int)(aLabel.bounds.size.width / 5),
														(int)(aLabel.bounds.size.height / 5))];
				superScriptLabel.textAlignment = NSTextAlignmentCenter;
				[superScriptLabel setFont:[UIFont systemFontOfSize:30]];
				superScriptLabel.backgroundColor = aLabel.backgroundColor;
				[aLabel addSubview:superScriptLabel];
				[labels addObject:aLabel];
			}
		}
		
		UIView *aLine = [[UIView alloc] initWithFrame:CGRectMake(self.bounds.origin.x + 10,
																 ((UILabel *)[labels objectAtIndex:8]).frame.origin.y,
																 (int)(self.bounds.size.width - 20),
																 5)];
		aLine.backgroundColor = [UIColor whiteColor];
		[self addSubview:aLine];
		
		
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect { }
@end
