//
//  MessageList.h
//  Grade
//
//  Created by yzk on 13-11-18.
//  Copyright (c) 2013年 yzk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GradeInfo : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;

- (id)initWithTitle:(NSString *)tit Description:(NSString *)des;
@end



//@interface GradeOption : NSObject
//@property (nonatomic, strong) NSString *description;
//@property (nonatomic, strong) NSArray *options;
//
//@end
//
//@interface GradeCategory : NSObject
//@property (nonatomic ,strong) NSString *cateName;
//
//@property (nonatomic ,strong) GradeOption *groption;
//
//@end

@interface InfoList : NSObject
@property (nonatomic ,strong) NSArray *gradeList;
//数据初始化
- (id)infoInit;

@end





