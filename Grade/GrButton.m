//
//  GrButton.m
//  Grade
//
//  Created by yzk on 13-11-18.
//  Copyright (c) 2013年 yzk. All rights reserved.
//





#import "GrButton.h"


@interface GrButton ()
{
    CGFloat alphaNum;
    CGFloat alphaNum3;
}
@end

#define IMAGESIDELENGTH 0.0f
#define RIMWIDTH 2.0f

@implementation GrButton
//self.frame.size.width
//self.frame.size.height

- (void)addrimsWithEnabled:(BOOL)hidden;
{
//    0.262,0.349,0.443
//    UIColor *rimColor = [UIColor colorWithRed:0.262 green:2.349 blue:0.443 alpha:1];
    
    if (hidden) {
        alphaNum = 1.0f;
        alphaNum3 = 0.0f;
        self.titleLabel.textColor = [UIColor blackColor];
        //self.titleLabel.tintColor = [UIColor blackColor];
        [self setTintColor:[UIColor blackColor]];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }else{
        alphaNum = 0.0f;
        alphaNum3 = 1.0f;
        self.titleLabel.textColor = [UIColor whiteColor];
    }
    
    self.rim1 = [UIView new];
    self.rim1.frame = CGRectMake(0, 0, self.frame.size.width + IMAGESIDELENGTH, RIMWIDTH);
    self.rim1.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:alphaNum];
    
    [self addSubview:self.rim1];
    
    self.rim2 = [UIView new];
    self.rim2.frame = CGRectMake(self.frame.size.width + IMAGESIDELENGTH, 0, RIMWIDTH, self.frame.size.height);
    self.rim2.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:alphaNum];
    [self addSubview:self.rim2];
    
    self.rim3 = [UIView new];
    self.rim3.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width + IMAGESIDELENGTH, RIMWIDTH);
    self.rim3.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:alphaNum3];
    [self addSubview:self.rim3];
    
    self.rim4 = [UIView new];
    self.rim4.frame = CGRectMake(0, 0, RIMWIDTH, self.frame.size.height);
    self.rim4.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:alphaNum];
    [self addSubview:self.rim4];
    //[self ChangeHidden:hidden];
    
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)ChangeHidden:(BOOL)hidden
{
    if (hidden) {
        alphaNum = 1.0f;
        alphaNum3 = 0.0f;
        //0.862,0.505,0.129
        //0.811,0.560,0.356
        self.backgroundColor = [UIColor colorWithRed:0.811 green:0.560 blue:0.356 alpha:1];
        self.titleLabel.textColor = [UIColor blackColor];
        //self.titleLabel.tintColor = [UIColor blackColor];
        [self setTintColor:[UIColor blackColor]];
    }else{
        alphaNum = 0.0f;
        alphaNum3 = 1.0f;
        //0.529,0.529,0.529
        self.backgroundColor = [UIColor colorWithRed:0.529 green:0.529 blue:0.529 alpha:1];
        self.titleLabel.textColor = [UIColor whiteColor];
    }
    self.rim1.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:alphaNum];
    self.rim2.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:alphaNum];
    self.rim3.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:alphaNum3];
    self.rim4.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:alphaNum];
    
}

- (void)grbuttonAddImageViewWithTag:(NSInteger)tag
{
    UIImage *buttonImage = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",(long)tag]];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:buttonImage];
    imageView.frame = CGRectMake(self.frame.size.width, 1, IMAGESIDELENGTH, IMAGESIDELENGTH-1);
    [self addSubview:self.imageView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
