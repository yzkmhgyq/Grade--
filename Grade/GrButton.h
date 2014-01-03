//
//  GrButton.h
//  Grade
//
//  Created by yzk on 13-11-18.
//  Copyright (c) 2013年 yzk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GrButton : UIButton
@property (nonatomic ,strong) UIView *rim1;
@property (nonatomic ,strong) UIView *rim2;
@property (nonatomic ,strong) UIView *rim3;
@property (nonatomic ,strong) UIView *rim4;

- (void)addrimsWithEnabled:(BOOL)hidden;
- (void)ChangeHidden:(BOOL)hidden;

@end
