//
//  GrTopicView.m
//  Grade
//
//  Created by yzk on 14-1-6.
//  Copyright (c) 2014年 yzk. All rights reserved.
//

#import "GrTopicView.h"
#import "TopicViewCell.h"


const static CGFloat kJVFieldFontSize = 16.0f;

const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;

@implementation GrTopicView
{
    NSMutableArray *infoArr;
    NSMutableArray *arrayOfSections;
    
    CGFloat CellHeight;
    
    AMDraggableBlurView *superBlur;
    
    BOOL isEditing;
    UIColor *floatingLabelColor ;
    
    UIAlertView *alert;
}

- (void)setSuperBlur:(AMDraggableBlurView *)superView
{
    superBlur = superView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
                // Initialization code
    }
    return self;
}
- (void)TopicDataSoure
{
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"GradeInfo.plist"];
    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:filename];
//    NSString *path = [[NSBundle mainBundle]pathForResource:@"GradeInfo" ofType:@"plist"];
//    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
    infoArr = [[NSMutableArray alloc]initWithArray:[dic objectForKey:@"object"]];
    
    CellHeight = (self.myTableView.frame.size.height-40)/5;
    //infoArr = [dict objectForKey:@"object"];
    
    floatingLabelColor = [UIColor grayColor];

}
#pragma -mark dataSoure
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    NSInteger result = 0;
//    if ([tableView isEqual:self.myTableView]) {
//        result = (NSInteger)[infoArr count];
//    }
//    return 1;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"GradeView" owner:nil options:nil];
    //gradeView = [nibView objectAtIndex:0];
    //UITableViewCell *result = nil;
    TopicViewCell *result = nil;
    if ([tableView isEqual:self.myTableView]) {
        //static  NSString *CellIdentifier = @"CellIdentifier";
        //result = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        //if (result == nil) {
        NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"TopicViewCell" owner:nil options:nil];
        result = [nibView objectAtIndex:0];
        //}
        //result.TopicTextView.tag = indexPath.row;
        result.TopicTextField.delegate = self;
        //UITextView *cellTest = [[UITextView alloc]initWithFrame:result.frame];
        //result.TopicTextField.keyboardType = UIKeyboardTypePhonePad;
//        //设置字体
//        result.TopicTextField.placeholder =[NSString stringWithFormat:@"问题%d",indexPath.row+1];
//        //设置字体大小
//        result.TopicTextField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
//        //设置浮动字体
//        result.TopicTextField.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
//        //设置字体颜色
//        result.TopicTextField.floatingLabelTextColor = floatingLabelColor;
        
        //UITextFieldViewModeWhileEditing,不为空，且在编辑状态时（及获得焦点）显示清空按钮
        //result.TopicTextField.clearButtonMode = UITextFieldViewModeWhileEditing;

        if (indexPath.row < infoArr.count) {
            
            result.TopicTextField.text = [infoArr objectAtIndex:indexPath.row];
            result.TopicTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        }
        //result.backgroundColor = [UIColor clearColor];
    }
    return result;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *result = nil;
    if ([tableView isEqual:self.myTableView]) {
        result = [NSString stringWithFormat:@"问题"];
    }
    return result;
}
#pragma -mark delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (self.myTableView.frame.size.height-40)/5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect frame = tableView.frame;
    switch (indexPath.row) {
        case 0:
            break;
        case 1:
            break;
        default:
            frame.origin.y -= CellHeight*(indexPath.row-1);
            [UIView animateWithDuration:0.5 animations:^{
                [tableView setFrame:frame];
            }];
            break;
    }
}
 
- (IBAction)cancel_self
{
    //self.myTableView.backgroundColor = [UIColor clearColor];
    [_delegate cancel];
}
- (IBAction)ok_self
{
    [self receiveFrame];
    [_delegate ok_withArray:infoArr];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if ([text isEqualToString:@"\n"]) {
//        [textView resignFirstResponder];
//        isEditing = NO;
//        [self receiveFrame];
//        return NO;
//    }
//    return YES;
//}
//- (void)textViewDidBeginEditing:(UITextView *)textView
//{
//    if (!isEditing) {
//        CGRect frame = superBlur.frame;
//        
//        frame.origin.y -= CellHeight*3;
//        [UIView animateWithDuration:0.2 animations:^{
//            [superBlur setFrame:frame];
//        }];
//        isEditing = YES;
//    }
//
//
//}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        isEditing = NO;
        [self receiveFrame];
        return NO;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if ([toBeString length] > 30) {
        textField.text = [toBeString substringToIndex:30];
        if (!alert) {
            
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"已达到最大字数30" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            alert.delegate = self;
        [alert show];
            
        }
        return NO;
    }
    return YES;
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    alert = nil;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (!isEditing) {
        CGRect frame = superBlur.frame;
        frame.origin.y -= CellHeight*3.5;
        [UIView animateWithDuration:0.2 animations:^{
            [superBlur setFrame:frame];
        }];
        isEditing = YES;
    }

}

- (void)receiveFrame
{
    NSMutableArray *plistArr = [[NSMutableArray alloc]initWithCapacity:5];
    //[infoArr removeAllObjects];
    //infoArr = [[NSMutableArray alloc]initWithCapacity:5];
    for (int i = 0; i<5; i++) {
        TopicViewCell *cell = (TopicViewCell*)[self.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (!cell.TopicTextField.text || cell.TopicTextField.text.length != 0) {
            if (cell.TopicTextField.text) {
                [plistArr addObject:cell.TopicTextField.text];
            }
        }
    }
    //NSLog(@"infoArr:%@ plistArr:%@",infoArr,plistArr);
    
    infoArr = plistArr;
    [self.myTableView reloadData];
    
    [UIView animateWithDuration:0.5 animations:^{
        [superBlur setCenter:CGPointMake(512.f, 384.f)];
    } completion:^(BOOL finish){
        
    }];
}

@end
