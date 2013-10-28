//
//  HCCalculateView.h
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/28/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HCCalculateView : UIView

/** 表示するラベルを格納しておく*/
@property NSMutableArray *labels;

- (void)arrangeCalculateView;

@end
