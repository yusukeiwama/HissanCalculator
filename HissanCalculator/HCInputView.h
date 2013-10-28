//
//  HCInputView.h
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/27/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCInputView : UIView {
	NSInteger margin;
}

@property UILabel *aboveIntegerLabel;
@property UILabel *belowIntegerLabel;
@property UIView *operatorSelectorView;
@property UILabel	*operatorLabel;

@property CGRect operatorSelecterViewDefaultPosition;
@property NSArray *operatorSelectButtonDefaultPositions;

- (void)arrangeInputView;

@end
