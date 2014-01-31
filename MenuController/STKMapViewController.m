//
//  STKMapViewController.m
//  MenuController
//
//  Created by Joe Conway on 11/19/13.
//  Copyright (c) 2013 Stable Kernel. All rights reserved.
//

#import "STKMapViewController.h"
@import MapKit;

@interface STKMapViewController () <MKMapViewDelegate>

@end

@implementation STKMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[self tabBarItem] setTitle:@"Map"];
        [[self tabBarItem] setImage:[UIImage imageNamed:@"nav_icon_badge_gray"]];
        [[self tabBarItem] setSelectedImage:[UIImage imageNamed:@"nav_icon_badge_white"]];
    }
    return self;
}

- (void)loadView
{
    MKMapView *mv = [[MKMapView alloc] init];
    [mv setDelegate:self];
    [self setView:mv];
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
    NSLog(@"will move %@", parent);
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
