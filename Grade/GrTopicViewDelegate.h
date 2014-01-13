//
//  GrTopicViewDelegate.h
//  Grade
//
//  Created by yzk on 14-1-6.
//  Copyright (c) 2014年 yzk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GrTopicViewDelegate <NSObject>

- (void)cancel;

- (void)ok_withArray:(id)arr;

@end
