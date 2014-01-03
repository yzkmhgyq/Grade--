//
//  MessageList.m
//  Grade
//
//  Created by yzk on 13-11-18.
//  Copyright (c) 2013年 yzk. All rights reserved.
//

#import "MessageList.h"

//@implementation GradeCategory
//@synthesize cateName;
//@synthesize groption;
//- (id)initWithCateName:(NSString *)name ForOptions:(GradeOption *)inoptions;
//{
//    self.cateName = name;
//    self.groption = inoptions;
//    
//    return self;
//}
//
//@end
//
//@implementation GradeOption
//@synthesize options;
//@synthesize description;
//
//- (id)initWithArray:(NSArray *)array
//{
//    self.options = [NSArray arrayWithArray:array];
//    return  self;
//}
//
//@end
@implementation GradeInfo

- (id)initWithTitle:(NSString *)tit Description:(NSString *)des
{
    self.title = [[NSString alloc]initWithString:tit];
    self.description = [[NSString alloc]initWithString:des];
    
    return self;
}

@end


@implementation InfoList

- (id)infoInit
{
//    NSArray *options = @[@"选项1",@"选项2",@"选项3",@"选项4"];
//    GradeOption *grOption1 = [[GradeOption alloc]initWithArray:options];
//    [grOption1 setDescription:@"问题1"];
//    
//    GradeOption *grOption2 = [[GradeOption alloc]initWithArray:options];
//    [grOption2 setDescription:@"问题2"];
//    
//    GradeOption *grOption3 = [[GradeOption alloc]initWithArray:options];
//    [grOption3 setDescription:@"问题3"];
//
//    GradeCategory *Cate1 = [[GradeCategory alloc]initWithCateName:@"name1" ForOptions:grOption1];
//    GradeCategory *Cate2 = [[GradeCategory alloc]initWithCateName:@"name2" ForOptions:grOption2];
//    GradeCategory *Cate3 = [[GradeCategory alloc]initWithCateName:@"name3" ForOptions:grOption3];
//    GradeInfo *question1 = [[GradeInfo alloc]initWithTitle:@"Serve" Description:@"Question 1"];
//    GradeInfo *question2 = [[GradeInfo alloc]initWithTitle:@"Attitude" Description:@"Question 2"];
//    GradeInfo *question3 = [[GradeInfo alloc]initWithTitle:@"Efficiency" Description:@"Question 3"];
//    GradeInfo *question4 = [[GradeInfo alloc]initWithTitle:@"Grade" Description:@"Question 4"];
    
    
//    self.gradeList = [[NSArray alloc]initWithObjects:question1,question2,question3,question4,nil];
    
    return self;
}

@end
