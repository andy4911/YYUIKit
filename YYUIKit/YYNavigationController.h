//
//  YYNavigationController.h
//  YYUIKit
//
//  Created by Cazenove on 2016/10/14.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYNavigationControllerDelegate

@optional

@end

@interface YYNavigationController : UINavigationController

- (void)pushVC:(UIViewController *)vc animated:(BOOL)animated complete:(void(^)(UIViewController *vc, UINavigationItem *item))make;

- (void)popWithAnimated:(BOOL)animated complete:(void(^)(UIViewController *vc, UINavigationItem *item))make;

@end
