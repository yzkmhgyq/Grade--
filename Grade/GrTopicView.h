//
//  GrTopicView.h
//  Grade
//
//  Created by yzk on 14-1-6.
//  Copyright (c) 2014年 yzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrTopicViewDelegate.h"
#import "AMDraggableBlurView.h"

@interface GrTopicView : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) id<GrTopicViewDelegate> delegate;
- (void)TopicDataSoure;
- (void)setSuperBlur:(AMDraggableBlurView *)superView;
@end
