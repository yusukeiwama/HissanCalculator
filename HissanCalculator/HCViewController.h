//
//  HCViewController.h
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/6/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "HCCreateFomulaState.h"
#import "HCCalculationState.h"
#import "HCHissanView.h"

@interface HCViewController : UIViewController {
	id<HCState> state;
}

- (IBAction)clearButton:	(id)sender;
- (IBAction)calculateButton:(id)sender;

@property (strong, nonatomic)	IBOutletCollection(UIButton) NSArray *numberKeyButtons;

@property (weak, nonatomic)	IBOutlet HCHissanView	*hissanView;
@property (weak, nonatomic)	IBOutlet UIButton		*clearButton;
@property (weak, nonatomic)	IBOutlet UIButton		*calculateButton;

@end

// storyboard と関連付けされているので、要確認。