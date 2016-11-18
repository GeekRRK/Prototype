//
//  BPAlertView.h
//  BaseProject
//
//  Created by UGOMEDIA on 2016/11/18.
//  Copyright © 2016年 UgoMedia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BPAlertBlock)(void);

@interface BPAlertView : UIView

+ (void)showParentVC:(UIViewController *)parentVC block:(BPAlertBlock)block;

@end
