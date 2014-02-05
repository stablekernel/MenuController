//
//  STKMenuView.m
//  MenuController
//
//  Created by Joe Conway on 11/19/13.
//  Copyright (c) 2013 Stable Kernel. All rights reserved.
//

#import "STKMenuView.h"
@import QuartzCore;

@interface STKMenuView ()

+ (float)controlSize;
+ (float)minimumDiameter;

@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) NSArray *itemViews;

@end

@implementation STKMenuView

- (id)initWithFrame:(CGRect)frame
{
    return [self init];
}

- (id)init
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        [self addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
        
        [self setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.5]];
        
        _circleLayer = [CAShapeLayer layer];
        [_circleLayer setFillColor:[[UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.3] CGColor]];
        [_circleLayer setStrokeColor:[[UIColor colorWithWhite:1 alpha:1] CGColor]];
        [_circleLayer setLineWidth:3.0];

        [[self layer] addSublayer:_circleLayer];
        
    }
    return self;
}

- (void)dismiss:(id)sender
{
    [self setVisible:NO animated:YES];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    int ctlCount = (int)[[self itemViews] count];
    float ctlSize = [[self class] controlSize];
    float ctlDiameter = sqrtf(powf(ctlSize, 2) + powf(ctlSize, 2));
    float ctlDiameterPadding = ctlDiameter + 30;
    float ctlCircumference = ctlDiameterPadding * ctlCount;
    float boxDiameter = ctlCircumference / M_PI;
    if(boxDiameter < [[self class] minimumDiameter]) {
        boxDiameter = [[self class] minimumDiameter];
    }
    
    UIBezierPath *bp = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, boxDiameter, boxDiameter)];
    CGRect bounds = [self bounds];
    CGRect frame = CGRectMake((bounds.size.width - boxDiameter) / 2.0 , (bounds.size.height - boxDiameter) / 2.0, boxDiameter, boxDiameter);
    [[self circleLayer] setFrame:frame];
    [[self circleLayer] setPath:[bp CGPath]];

    
    float tStep = 1.0 / ctlCount;
    [[self itemViews] enumerateObjectsUsingBlock:^(UIControl *obj, NSUInteger idx, BOOL *stop) {
        float t = tStep * idx;
        float x = bounds.size.width / 2.0 + 0.5 * boxDiameter * cos(t * M_PI * 2.0);
        float y = bounds.size.height / 2.0 + 0.5 * boxDiameter * sin(t * M_PI * 2.0);
        [obj setCenter:CGPointMake(x, y)];
    }];
}

- (void)setVisible:(BOOL)visible
{
    [self setVisible:visible animated:NO];
}
- (void)setVisible:(BOOL)menuVisible animated:(BOOL)animated
{
    if (menuVisible == _visible && menuVisible) {
        return;
    }
    
    _visible = menuVisible;
    if(menuVisible) {
        
        [self setItems:[[self delegate] itemsForMenuView:self]];
        [self setNeedsLayout];
        
        [self setHidden:NO];
        int selectedIndex = [[self delegate] selectedIndexForMenuView:self];
        [[self itemViews] enumerateObjectsUsingBlock:^(UIControl *obj, NSUInteger idx, BOOL *stop) {
            [obj setSelected:(selectedIndex == idx)];
        }];
        
        if(animated) {
            [self setAlpha:0];
            [UIView animateWithDuration:0.2 delay:0.0 options:0 animations:^{
                [self setAlpha:1];
            } completion:^(BOOL finished) {
                
            }];
        }
        
    } else {
        if(animated) {
            [UIView animateWithDuration:0.2
                                  delay:0.0
                                options:0
                             animations:^{
                                 [self setAlpha:0];
                             } completion:^(BOOL finished) {
                                 if(finished)
                                     [self setHidden:YES];
                             }];
        } else {
            [self setHidden:YES];
        }
    }
}

+ (float)minimumDiameter
{
    return 200.0f;
}

+ (float)controlSize
{
    return 45.0f;
}

- (void)setItems:(NSArray *)items
{
    [[self itemViews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    _items = items;
    
    NSMutableArray *itemViews = [NSMutableArray array];
    for(UITabBarItem *i in _items) {
        UIControl *ctl = [self controlForItem:i];
        [itemViews addObject:ctl];
        [self addSubview:ctl];
    }
    _itemViews = [itemViews copy];
}

- (void)itemViewTapped:(id)sender
{
    int idx = (int)[[self itemViews] indexOfObject:sender];
    [[self delegate] menuView:self didSelectItemAtIndex:idx];
}

- (UIControl *)controlForItem:(UITabBarItem *)item
{
    float sz = [[self class] controlSize];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, sz, sz)];
    [btn setBackgroundImage:[item image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[item selectedImage] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[item selectedImage] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(itemViewTapped:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor colorWithWhite:00 alpha:0.85]];

    [[btn layer] setCornerRadius:22.5];
    
    return btn;
}

@end
