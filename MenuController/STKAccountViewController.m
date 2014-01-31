//
//  STKAccountViewController.m
//  MenuController
//
//  Created by Joe Conway on 11/19/13.
//  Copyright (c) 2013 Stable Kernel. All rights reserved.
//

#import "STKAccountViewController.h"

@interface STKAccountViewController ()

@end

@implementation STKAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[self tabBarItem] setTitle:@"Profile"];
        [[self tabBarItem] setImage:[UIImage imageNamed:@"nav_icon_profile_gray"]];
        [[self tabBarItem] setSelectedImage:[UIImage imageNamed:@"nav_icon_profile_white"]];

    }
    return self;
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
