//
//  HCState.h
//  HissanCalculator
//
//  Created by Daiki IIJIMA on 10/9/13.
//  Copyright (c) 2013 Daiki IIJIMA. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HCState <NSObject>
- (id <HCState>) getNextState;	// 更新処理を行い、次状態を返す
@end
