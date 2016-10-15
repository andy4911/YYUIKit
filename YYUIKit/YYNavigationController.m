//
//  YYNavigationController.m
//  YYUIKit
//
//  Created by Cazenove on 2016/10/14.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "YYNavigationController.h"

@interface YYNavigationController () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@end

@implementation YYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBarHidden = NO;
    self.navigationBar.translucent = NO;
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = [UIColor blueColor];
    self.navigationBar.titleTextAttributes = @{
                                               NSForegroundColorAttributeName: [UIColor whiteColor],
                                               NSFontAttributeName: [UIFont systemFontOfSize:19]};
    
    // remove the border on navigation bar
    [self.navigationBar setShadowImage:[UIImage new]];
    [self.navigationBar setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    
    self.delegate = self;
    
    [self setCustomBackButton];
}

- (void)setCustomBackButton {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [button setBackgroundColor:[UIColor greenColor]];
//    button setImage:<#(nullable UIImage *)#> forState:[UIControlStateNormal];
    [button addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.backBarButtonItem = item;
}

- (void)pop:(UIButton *)sender {
    [self popWithAnimated:YES complete:nil];
}

- (void)pushVC:(UIViewController *)vc animated:(BOOL)animated complete:(void (^)(UIViewController *, UINavigationItem *))make {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = NO;
    [self pushViewController:vc animated:animated];
    make(vc, self.navigationItem);
}

- (void)popWithAnimated:(BOOL)animated complete:(void (^)(UIViewController *, UINavigationItem *))make {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = NO;
    [self popViewControllerAnimated:animated];
    make((UIViewController *)[self.viewControllers lastObject], self.navigationItem);
}

- (BOOL)prefersStatusBarHidden {
    return [self.topViewController prefersStatusBarHidden];
}

#pragma mark - UINavigationControllerDelegare

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)])
        self.interactivePopGestureRecognizer.enabled = YES;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.interactivePopGestureRecognizer)
        if (self.viewControllers.count <= 1 )
            return NO;
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class] && [otherGestureRecognizer.view isDescendantOfView:otherGestureRecognizer.view])
        return true;
    else
        return false;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
