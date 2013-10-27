//
//  HCInputView.m
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/27/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import "HCInputView.h"

@implementation HCInputView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		NSLog(@"hoge");
		NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"InputView"
															owner: self
														  options: nil];
		self = [nibObjects objectAtIndex:0];
		/*inputView.frame = CGRectMake(baseView.frame.origin.x,
									 baseView.frame.origin.y,
									 baseView.frame.size.width,
									 baseView.frame.size.height);
		inputView.hidden = YES;
		[self.view addSubview:inputView];
		*/
	}
	NSLog(@"foo");
    return self;
}


// using xib files or story board.
-(id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if(self){
		// Initialization code
		NSLog(@"fuga");
	}
	NSLog(@"bar");
	return self;
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
