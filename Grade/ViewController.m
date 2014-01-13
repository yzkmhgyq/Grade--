//
//  ViewController.m
//  Grade
//
//  Created by yzk on 13-11-18.
//  Copyright (c) 2013年 yzk. All rights reserved.
//

#import "ViewController.h"
#import "GradeView.h"
#import "ASIHTTPRequest.h"
//#import "DRNRealTimeBlurView.h"
#import "AMDraggableBlurView.h"
#import "GrTopicView.h"
#import "TopicViewCell.h"
#import "CLProgressHUD.h"
#define kDuration 0.3   // 动画持续时间(秒)

@interface ViewController ()
{
    NSInteger touchOfSet;/*当前标签位置*/
    
    NSMutableArray *infoArr;/*数据数组*/
    NSMutableArray *anDic;/*网络请求数据数组*/
    NSMutableArray *colorArr;//标签颜色数组
    NSArray *titleArr;//标签数组
    
    GradeView *gradeView;//标签对应页面
    //DRNRealTimeBlurView *blurView;//弹窗背景图层
    AMDraggableBlurView *blurView;
    GrTopicView *topicView;//弹窗图层
    CGRect topicFrame;//弹窗初始frame
    
    //点击手势
    UITapGestureRecognizer *tapGestureOne;
    UITapGestureRecognizer *tapGestureThree;
    UITapGestureRecognizer *tapGestureLogo;
    UITapGestureRecognizer *tapGestureFinish;
    
    UIView * titleView_one;
    
    BOOL isThankView;
    
    //NSTimer *timer;
    
}
@end

//#define TOPOFSET 220.0f
//#define SIDEOFSET 20.0f
//
//#define OPTIONHEIGHT 60.0f

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self colorInit];
    [self InitInfo];
    
    //UIColor *backgroundColor = [[UIColor alloc]initWithRed:0.141 green:0.101 blue:0.270 alpha:0.7];
    ;
//    UIImageView *background = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pic_back"]];
////    imgView.frame = self.view.bounds;
////    imgView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
////    [self.view insertSubview:imgView atIndex:0];
//    [self.view addSubview:background];
//    [self.view sendSubviewToBack:background];
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"pic_back"]];
    
    
//    titleView_one = [[UIView alloc]initWithFrame:CGRectMake(gradeView.frame.origin.x, gradeView.frame.origin.y-180.f, gradeView.frame.size.width, 180.0f)];
//    titleView_one.backgroundColor = [colorArr objectAtIndex:0];
//    titleView_one.alpha = 0.0f;
//    [self.view addSubview:titleView_one];
    //UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-440, 670, 420, 78)];
    //UIImageView
    
    
    //self.view.backgroundColor = [UIColor whiteColor];
    UIImage *image = [UIImage imageNamed:@"Thank_image.jpg"];
    self.imageView = [[UIImageView alloc]initWithImage:image];
    self.imageView.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.imageView];
    [self.imageView setUserInteractionEnabled:YES];
    
    [self removepanGestureReconginzerWhileTopicShow:NO];
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)colorInit
{
    isThankView = NO;
    //0.933,0.725,0.309
    //0.945,0.756,0.349
    UIColor *color_title_1 = [[UIColor alloc]initWithRed:0.945 green:0.756 blue:0.349 alpha:1];
    //UIColor *color_title_1 =[[UIColor alloc]initWithRed:0xc6/255 green:0x7c/255 blue:0xd6/255 alpha:1];
    //0.513,0.764,0.270
    //0.556,0.792,0.305
    UIColor *color_title_2 = [[UIColor alloc]initWithRed:0.556 green:0.792 blue:0.305 alpha:1];
    //0.376,0.6,0.8
    //0.419,0.639,0.823
    UIColor *color_title_3 = [[UIColor alloc]initWithRed:0.419 green:0.639 blue:0.823 alpha:1];
    //0.745,0.443,0.811
    //0.776,0.486,0.839
    UIColor *color_title_4 = [[UIColor alloc]initWithRed:0.776 green:0.486 blue:0.839 alpha:1];
    //0.933,0.250,0.254
    //0.945,0.290,0.290
    UIColor *color_title_5 = [[UIColor alloc]initWithRed:0.945 green:0.290 blue:0.290 alpha:1];
    colorArr  = [[NSMutableArray alloc]initWithCapacity:5];
    [colorArr addObject:color_title_1];
    [colorArr addObject:color_title_2];
    [colorArr addObject:color_title_3];
    [colorArr addObject:color_title_4];
    [colorArr addObject:color_title_5];
    
    titleArr = [[NSArray alloc]initWithObjects:self.title_1,self.title_2,self.title_3,self.title_4,self.title_5,nil];
    if (!anDic) {
        anDic = [[NSMutableArray alloc]initWithCapacity:5];
    }
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"GradeView" owner:nil options:nil];
    gradeView = [nibView objectAtIndex:0];
    [gradeView setFrame:CGRectMake(20, 140+170, 1000-20, 360)];
    [self.view addSubview:gradeView];
    UIImage *image = [UIImage imageNamed:@"dibiao"];
    
    UIImageView *imageview = [[UIImageView alloc]initWithImage:image];
    [imageview setFrame:CGRectMake(self.view.frame.size.width-433-24, gradeView.frame.origin.y + gradeView.frame.size.height, 433, 78)];
    [self.view addSubview:imageview];
}

- (void)InitInfo
{
    //初始化数据
    //NSString *path = [[NSBundle mainBundle]pathForResource:@"GradeInfo" ofType:@"plist"];
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"GradeInfo.plist"];
    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:filename];
    infoArr = [dic objectForKey:@"object"];
    touchOfSet = 0;
    NSLog(@"%@",infoArr);
    //c67cd6 04
    
    gradeView.backgroundColor = [colorArr objectAtIndex:touchOfSet];
    
    if (infoArr == nil || infoArr.count == 0 ) {
        NSLog(@"数据出错");
        NSString *path = [[NSBundle mainBundle]pathForResource:@"GradeInfo" ofType:@"plist"];
        NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
        
        //获取应用程序沙盒的Documents目录
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *plistPath = [paths objectAtIndex:0];
        //得到完整的文件名
        NSString *filename=[plistPath stringByAppendingPathComponent:@"GradeInfo.plist"];
        //输入写入
        [dic writeToFile:filename atomically:YES];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"数据出错" message:@"程序已进行初始化" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [self InitInfo];
    }
    gradeView.description.text = [infoArr objectAtIndex:touchOfSet];
    
    [self ShowTitle];
}


- (void)ShowTitle
{
    int i =0;
    while (i < 5) {
        if (i<infoArr.count) {
            ((UIImageView *)[titleArr objectAtIndex:i]).alpha = 1;
        }
        else
            ((UIImageView *)[titleArr objectAtIndex:i]).alpha = 0.1;
        i++;
    }
    

    
    [self reloadOptionsInit:YES];
}
#pragma -mark tapGesture

- (void)removepanGestureReconginzerWhileTopicShow:(BOOL)show
{
    if (show) {
        if (tapGestureOne) {
            [gradeView.imageViewOne removeGestureRecognizer:tapGestureOne];
            tapGestureOne = nil;
        }
        if (tapGestureThree) {
            [gradeView.imageViewThree removeGestureRecognizer:tapGestureThree];
            tapGestureThree = nil;
        }
        if (tapGestureLogo) {
            [self.logoImage removeGestureRecognizer:tapGestureLogo];
            tapGestureLogo = nil;
        }
        if (tapGestureFinish) {
            [self.imageView removeGestureRecognizer:tapGestureFinish];
            tapGestureFinish = nil;
        }
    }
    else{
        if (!tapGestureOne) {
            tapGestureOne = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnContentView:)];
            [gradeView.imageViewOne addGestureRecognizer:tapGestureOne];
        }
        if (!tapGestureThree) {
            tapGestureThree = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnContentView:)];
            [gradeView.imageViewThree addGestureRecognizer:tapGestureThree];
        }
        if (!tapGestureLogo) {
            tapGestureLogo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnlogoImage)];
            [self.logoImage addGestureRecognizer:tapGestureLogo];
        }
        if (!tapGestureFinish) {
            tapGestureFinish = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Finish)];
            [self.imageView addGestureRecognizer:tapGestureFinish];
        }
    }
}

#pragma -mark TapGesture
- (void)tapOnContentView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    NSString *answer;
    switch (tapGestureRecognizer.view.tag) {
        case 0:
            answer = @"Y";
            break;
        case 1:
            answer = @"N";
            break;
    }
    NSDictionary * dictionary = [[NSDictionary alloc]initWithObjects:@[[NSNumber numberWithInt:touchOfSet+1],answer] forKeys:@[@"id",@"answer"]];
    [anDic addObject:dictionary];
    
    if (touchOfSet != [infoArr count]-1) {
        touchOfSet++;
        [self buttonPressed1];
        //[self reloadOptionsWithTag:touchOfSet];
    }else [self buttonPressed2];
    
    
}

- (void)reloadOptionsInit:(BOOL)_bool
{
    if (!_bool) {
        UIImageView *oldImage = [titleArr objectAtIndex:touchOfSet-1];
        [oldImage setAlpha:0.8];
        UIImageView *newImage = [titleArr objectAtIndex:touchOfSet];
        [newImage setAlpha:1];
    }else{
        UIImageView *Image_1 = [titleArr objectAtIndex:0];
        [Image_1 setAlpha:1];
        for (int i = 1; i<5; i++) {
            if (i<infoArr.count){
                UIImageView *oneImage = [titleArr objectAtIndex:i];
                [oneImage setAlpha:0.8];
            }
        }
//        if (infoArr.count == 1) {
//            if (titleView_one) {
//                titleView_one.alpha = 1.0f;
//                //[self.imageView bringSubviewToFront:self.view];
//            }
//        }else{
//            if (titleView_one) {
//                titleView_one.alpha = 0.0f;
////                [titleView_one removeFromSuperview];
////                titleView_one = nil;
//            }
//        }
    }

}

- (void)tapOnlogoImage
{
    [self removepanGestureReconginzerWhileTopicShow:YES];
    topicFrame =CGRectMake(self.view.frame.size.height/2-300, -400.f, 600.f, 400.f);
    blurView = [[AMDraggableBlurView alloc]initWithFrame:topicFrame];
    //NSLog(@"x:%f,y:%f",self.view.center.x,self.view.center.y);
    //blurView.center = CGPointMake(512.0f, 0);
    [blurView setCornerRadius:10];
    [blurView setDraggable:NO];
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"GrTopicView" owner:nil options:nil];
    topicView = [nibView objectAtIndex:0];
    [topicView TopicDataSoure];
    [topicView setSuperBlur:blurView];
    topicView.delegate = self;
    //topicView.backgroundColor = [UIColor clearColor];
    [blurView addSubview:topicView];
    
    [self.view addSubview:blurView];
    [self ShowHide];
}

- (void)Finish
{

    
    if (isThankView) {
        [NSThread detachNewThreadSelector:@selector(upload) toTarget:self withObject:nil];
        touchOfSet = 0;
        gradeView.description.text = [infoArr objectAtIndex:touchOfSet];
        [gradeView setBackgroundColor:[colorArr objectAtIndex:touchOfSet]];
        [self reloadOptionsInit:YES];
    
        [UIView animateWithDuration:0.3 animations:^(void){
            self.imageView.frame = CGRectMake(self.view.frame.size.height, 0, self.view.frame.size.height, self.view.frame.size.width);
        } completion:^(BOOL finish){
            isThankView = NO;
    }];
    }
}


- (void)ShowHide
{
    [UIView animateWithDuration:1 animations:^{
        blurView.center = CGPointMake(512.0f, 384.0f);
        
    } completion:^(BOOL finish){
       // [blurView deallocBlurView];
    }];
    //
}


- (void)buttonPressed1 {
    //UIButton *button = (UIButton *)sender;
    //NSInteger tag = button.tag;
    
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = kDuration;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromRight;
    //[UIView setAnimationDidStopSelector:@selector(finished)];
    [[gradeView layer] addAnimation:animation forKey:@"animation"];
    [self changeInfoWithPress];
    
}
- (void)changeInfoWithPress
{
    [gradeView setBackgroundColor:[colorArr objectAtIndex:touchOfSet]];
    [gradeView.description setText:[infoArr objectAtIndex:touchOfSet]];
    [self reloadOptionsInit:NO];
    
}

- (void)buttonPressed2
{
    [self.imageView bringSubviewToFront:self.view];
    [UIView animateWithDuration:0.5 animations:^(void){
        self.imageView.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
    } completion:^(BOOL finish){
        isThankView = YES;
        [self performSelector:@selector(Finish) withObject:nil afterDelay:4];
        //[timer fire];
    }];
}



- (void)upload
{
    NSURL *url = [NSURL URLWithString:@"http://cmcenter.azurewebsites.net/Survey/Submit"];
    
    //AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:url];
    [request addRequestHeader:@"Content-Type" value:@"application/json; encoding=utf-8"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    
    NSData* jsonData =[NSJSONSerialization dataWithJSONObject:anDic options:NSJSONWritingPrettyPrinted error:nil];
    NSMutableData *tempJsonData = [NSMutableData dataWithData:jsonData];
    [request setRequestMethod:@"POST"];
    [request setPostBody:tempJsonData];
    [request startSynchronous];
    NSString *response = [request responseString];
//    if (!response) {
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请检查您的网络状况" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//    }
    NSLog(@"Rev：%@",response);
}

- (void)cancel
{
    if (blurView) {
        [UIView animateWithDuration:0.3 animations:^{
           blurView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [blurView removeFromSuperview];
            [self removepanGestureReconginzerWhileTopicShow:NO];
        }];
    }
}

- (void)ok_withArray:(id)arr
{
    //NSMutableArray *plistArr = [[NSMutableArray alloc]initWithCapacity:5];
    //[infoArr removeAllObjects];
    //infoArr = [[NSMutableArray alloc]initWithCapacity:5];
//    for (int i = 0; i<5; i++) {
//        TopicViewCell *cell = (TopicViewCell*)[topicView.myTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//        if (!cell.TopicTextField.text || cell.TopicTextField.text.length == 0) {
//            if (cell.TopicTextField.text) {
//                [plistArr addObject:cell.TopicTextField.text];
//            }
//        }
//    }
//    NSLog(@"%@",plistArr);
    
    NSMutableDictionary *plistDic = [[NSMutableDictionary alloc]init];
    [plistDic setObject:arr forKey:@"object"];
    [self reloadDataForPlist:plistDic];
    //topicView.myTableView
}

- (void)reloadDataForPlist:(NSDictionary *)_dictionary
{
    //获取应用程序沙盒的Documents目录
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath = [paths objectAtIndex:0];
    //得到完整的文件名
    NSString *filename=[plistPath stringByAppendingPathComponent:@"GradeInfo.plist"];
    //NSString *path = [[NSBundle mainBundle]pathForResource:@"GradeInfo" ofType:@"plist"];

    //输入写入
    [_dictionary writeToFile:filename atomically:YES];
    
    //NSMutableDictionary *data1 = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    //NSString *path = [[NSBundle mainBundle]pathForResource:@"GradeInfo" ofType:@"plist"];
    //NSLog(@"path：%@",path);
    //NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:filename];
    //NSLog(@"%@",dict);
    if (blurView) {
        [UIView animateWithDuration:0.5 animations:^{
            blurView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [blurView removeFromSuperview];
            [self ShowAlert];
    }];
    }
}

- (void)ShowAlert
{
//    blurView = [[AMDraggableBlurView alloc]initWithFrame:CGRectMake(0, 0, 400, 400)];
//    [blurView setCenter:CGPointMake(512.0f, 384.f)];
//    blurView.alpha = 1.0f;
//    [self.view addSubview:blurView];
    CLProgressHUD *hud = [CLProgressHUD shareInstance];
    hud.type = CLProgressHUDTypeDarkForground;
    hud.shape = CLProgressHUDShapeCircle;
    [hud showInView:self.view withText:@"  初始化中"];
    [hud performSelector:@selector(dismiss) withObject:nil afterDelay:2];
    
    [self performSelector:@selector(initLoading) withObject:nil afterDelay:1];
}
- (void)initLoading
{
    NSLog(@"初始化中");
    [self InitInfo];
    [self removepanGestureReconginzerWhileTopicShow:NO];
}





@end
