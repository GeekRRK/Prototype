//
//  HZQDatePickerView.h
//  HZQDatePickerView
//
//  Created by 1 on 15/10/26.
//  Copyright © 2015年 HZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HZQBlock)(int index1st, int index2nd, int index3rd);

@interface HZQPickerView : UIView

+ (void)showPickerViewInVC:(UIViewController *)parentVC titles:(NSArray *)titles block:(HZQBlock)block;
    
@end
