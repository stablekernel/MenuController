//
//  STKMenuView.h
//  MenuController
//
//  Created by Joe Conway on 11/19/13.
//  Copyright (c) 2013 Stable Kernel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class STKMenuView;

@protocol STKMenuViewDelegate <NSObject>

- (NSArray *)itemsForMenuView:(STKMenuView *)menuView;
- (int)selectedIndexForMenuView:(STKMenuView *)menuView;
- (void)menuView:(STKMenuView *)menuView didSelectItemAtIndex:(int)idx;

@end

@interface STKMenuView : UIControl

@property (nonatomic, weak) id <STKMenuViewDelegate> delegate;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, getter = isVisible) BOOL visible;

- (void)setVisible:(BOOL)menuVisible animated:(BOOL)animated;

@end
