//
//  ViewController.h
//  Grade
//
//  Created by yzk on 13-11-18.
//  Copyright (c) 2013年 yzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrTopicViewDelegate.h"

@interface ViewController : UIViewController<GrTopicViewDelegate>

@property (strong, nonatomic)  UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIImageView *title_1;
@property (weak, nonatomic) IBOutlet UIImageView *title_2;
@property (weak, nonatomic) IBOutlet UIImageView *title_3;
@property (weak, nonatomic) IBOutlet UIImageView *title_4;
@property (weak, nonatomic) IBOutlet UIImageView *title_5;

@end
