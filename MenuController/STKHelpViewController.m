//
//  STKHelpViewController.m
//  MenuController
//
//  Created by Joe Conway on 11/19/13.
//  Copyright (c) 2013 Stable Kernel. All rights reserved.
//

#import "STKHelpViewController.h"
#import "STKMoreHelpViewController.h"

@interface STKHelpViewController ()

@end

@implementation STKHelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[self tabBarItem] setTitle:@"Help"];
        [[self tabBarItem] setImage:[UIImage imageNamed:@"nav_icon_help_gray"]];
        [[self tabBarItem] setSelectedImage:[UIImage imageNamed:@"nav_icon_help_white"]];

    }
    return self;
}
- (IBAction)showMoreHelp:(id)sender
{
    STKMoreHelpViewController *mvc = [[STKMoreHelpViewController alloc] init];
    [[self navigationController] pushViewController:mvc animated:YES];
}

- (IBAction)goBackToMap:(id)sender
{
    [[self menuController] setSelectedViewControllerIndex:0];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%@ %@", [self class], NSStringFromSelector(_cmd));
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"%@ %@", [self class], NSStringFromSelector(_cmd));
}

@end
