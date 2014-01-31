//
//  STKMenuViewController.m
//  MenuController
//
//  Created by Joe Conway on 11/19/13.
//  Copyright (c) 2013 Stable Kernel. All rights reserved.
//

#import "STKMenuViewController.h"

// protocols not added yet
@interface STKMenuViewController () <STKMenuViewDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, weak) UIView *transitionView;
@property (nonatomic, weak) UIViewController *selectedViewController;

@end

@implementation STKMenuViewController
@dynamic selectedViewControllerIndex;
@dynamic menuVisible;

- (id)init
{
    self = [super initWithNibName:nil bundle:nil];
    if(self) {
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    return [self init];
}

- (int)selectedIndexForMenuView:(STKMenuView *)sv
{
    return [self selectedViewControllerIndex];
}

- (void)menuView:(STKMenuView *)menuView didSelectItemAtIndex:(int)idx
{
    if(idx != [self selectedViewControllerIndex])
        [self setSelectedViewController:[[self viewControllers] objectAtIndex:idx]];
    
    [self setMenuVisible:NO animated:YES];
}

- (NSArray *)itemsForMenuView:(STKMenuView *)menuView
{
    return [[self viewControllers] valueForKey:@"tabBarItem"];
}

- (void)toggleMenu:(id)sender
{
    [self setMenuVisible:![self isMenuVisible] animated:YES];
}

- (void)setMenuVisible:(BOOL)menuVisible
{
    [self setMenuVisible:menuVisible animated:NO];
}

- (void)setMenuVisible:(BOOL)menuVisible animated:(BOOL)animated
{
    if(menuVisible) {
        [[self view] endEditing:YES];
    }
    [[self menuView] setVisible:menuVisible animated:animated];
}

- (BOOL)isMenuVisible
{
    return [[self menuView] isVisible];
}

- (void)setViewControllers:(NSArray *)viewControllers
{
    for(UIViewController *vc in [self viewControllers]) {
        [vc willMoveToParentViewController:nil];
        if([vc isViewLoaded] && [[vc view] superview] == [self transitionView])
            [[vc view] removeFromSuperview];
        [vc removeFromParentViewController];
    }
    
    _viewControllers = viewControllers;
    
    for(UIViewController *vc in [self viewControllers]) {
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
    }
    
    if([_viewControllers count] > 0) {
        [self setSelectedViewController:[_viewControllers objectAtIndex:0]];
    } else {
        [self setSelectedViewController:nil];
    }
}

- (int)selectedViewControllerIndex
{
    return (int)[[self viewControllers] indexOfObject:[self selectedViewController]];
}

- (void)setSelectedViewControllerIndex:(int)selectedViewControllerIndex
{
    if(selectedViewControllerIndex < 0
    || selectedViewControllerIndex >= [[self viewControllers] count]
    || selectedViewControllerIndex == [self selectedViewControllerIndex])
        return;
    
    [self setSelectedViewController:[[self viewControllers] objectAtIndex:selectedViewControllerIndex]];
}

- (void)setSelectedViewController:(UIViewController *)selectedViewController
{
    if(![[self viewControllers] containsObject:selectedViewController]) {
        return;
    }
    
    UIViewController *previous = [self selectedViewController];
    
    _selectedViewController = selectedViewController;
    
    if([self isViewLoaded]) {
        [[previous view] removeFromSuperview];

        UIView *newView = [[self selectedViewController] view];
        [newView setFrame:[[self transitionView] bounds]];
        [newView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
        [[self transitionView] addSubview:newView];
    }
}

- (void)loadView
{
    UIView *layoutView = [[UIView alloc] init];

    // this needs to be added
    _menuGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                     action:@selector(screenTap:)];
    [_menuGestureRecognizer setNumberOfTouchesRequired:2];
    [_menuGestureRecognizer setDelegate:self];
    [layoutView addGestureRecognizer:_menuGestureRecognizer];
    
    UIView *transitionView = [[UIView alloc] initWithFrame:[layoutView bounds]];
    [transitionView setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    [layoutView addSubview:transitionView];
    
    STKMenuView *menuView = [[STKMenuView alloc] init];
    [menuView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [menuView setDelegate:self];
    [layoutView addSubview:menuView];
    
    [self setView:layoutView];
    [self setTransitionView:transitionView];
    _menuView = menuView;
    
    [self setMenuVisible:NO animated:NO];
}


- (void)screenTap:(UITapGestureRecognizer *)gr
{
    if([gr state] == UIGestureRecognizerStateEnded) {
        [self setMenuVisible:YES animated:YES];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setSelectedViewController:[self selectedViewController]];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end


@implementation UIViewController (STKMenuAdditions)
- (STKMenuViewController *)menuController
{
    UIViewController *parent = [self parentViewController];
    while(parent) {
        if([parent isKindOfClass:[STKMenuViewController class]]) {
            return (STKMenuViewController *)parent;
        }
        parent = [parent parentViewController];
    }
    return nil;
}
@end

