//
//  STKMenuViewController.h
//  MenuController
//
//  Created by Joe Conway on 11/19/13.
//  Copyright (c) 2013 Stable Kernel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STKMenuView.h"

@class STKMenuViewController;

@interface UIViewController (STKMenuAdditions)
@property (nonatomic, readonly) STKMenuViewController *menuController;
@end

@interface STKMenuViewController : UIViewController

@property (nonatomic) int selectedViewControllerIndex;
@property (nonatomic, copy) NSArray *viewControllers;

@property (nonatomic, weak, readonly) STKMenuView *menuView;
@property (nonatomic, getter = isMenuVisible) BOOL menuVisible;

// This needs to be added
@property (nonatomic, strong, readonly) UITapGestureRecognizer *menuGestureRecognizer;

- (void)setMenuVisible:(BOOL)menuVisible animated:(BOOL)animated;

@end
