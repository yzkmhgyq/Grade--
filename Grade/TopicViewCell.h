//
//  TopicViewCell.h
//  Grade
//
//  Created by yzk on 14-1-7.
//  Copyright (c) 2014年 yzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"

@interface TopicViewCell : UITableViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *TopicTextField;

@end
