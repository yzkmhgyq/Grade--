//
//  ViewController.m
//  Grade
//
//  Created by yzk on 13-11-18.
//  Copyright (c) 2013年 yzk. All rights reserved.
//

#import "ViewController.h"
//#import "GrButton.h"
#import "GradeView.h"
#import "ASIHTTPRequest.h"


#define kDuration 0.3   // 动画持续时间(秒)

@interface ViewController ()
{
    NSMutableArray *btList;
    NSInteger touchOfSet;
    //InfoList *infolist;
    CGFloat buttonheight;
    
    //NSArray *optionList;
    
    NSMutableArray *infoArr;
    
    UITableView *infoTableView;
    
    GradeView *gradeView;
    
    UIColor *noColor;
    UIColor *enColor;
    UIColor *baColor;
    
    NSMutableArray *anDic;
    
    NSMutableArray *colorArr;
}

@end

#define TOPOFSET 220.0f
#define SIDEOFSET 20.0f

#define OPTIONHEIGHT 60.0f

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //0.949,0.933,0.874
    noColor = [[UIColor alloc]initWithRed:0.949 green:0.933 blue:0.874 alpha:0.7];
    //0.529,0.529,0.529
    enColor = [[UIColor alloc]initWithRed:0.529 green:0.529 blue:0.529 alpha:0.7];
    //0.670,0.819,0.792
    baColor = [[UIColor alloc]initWithRed:0.670 green:0.819 blue:0.792 alpha:1];
    
    //0.921,0.705,0.282
    UIColor *color_title_1 = [[UIColor alloc]initWithRed:0.921 green:0.705 blue:0.282 alpha:1];
    //0.513,0.764,0.270
    UIColor *color_title_2 = [[UIColor alloc]initWithRed:0.513 green:0.764 blue:0.270 alpha:1];
    //0.380,0.6,0.8
    UIColor *color_title_3 = [[UIColor alloc]initWithRed:0.380 green:0.6 blue:0.8 alpha:1];
    //0.745,0.443,0.811
    UIColor *color_title_4 = [[UIColor alloc]initWithRed:0.745 green:0.443 blue:0.811 alpha:1];
    //0.933,0.250,0.254
    UIColor *color_title_5 = [[UIColor alloc]initWithRed:0.933 green:0.250 blue:0.254 alpha:1];
    colorArr  = [[NSMutableArray alloc]initWithCapacity:5];
    
//    colorArr = @[color_title_1,color_title_2,color_title_3,color_title_4,color_title_5];
    [colorArr addObject:color_title_1];
    [colorArr addObject:color_title_2];
    [colorArr addObject:color_title_3];
    [colorArr addObject:color_title_4];
    [colorArr addObject:color_title_5];
    //optionList = [[NSArray alloc]initWithObjects:self.OptionOne,self.OptionTwo,self.OptionThree,self.OptionFour, nil];
    
//    UIView *div1 = [UIView new];
//    div1.frame = CGRectMake(SIDEOFSET, TOPOFSET, self.view.frame.size.height-2*SIDEOFSET,1.0f);
//    div1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
//    [self.view addSubview:div1];
//    
//    UIView *div2 = [UIView new];
//    div2.frame = CGRectMake(self.view.frame.size.height - SIDEOFSET,TOPOFSET,1.0f,self.view.frame.size.width-2*TOPOFSET+1);
//    div2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
//    [self.view addSubview:div2];
//    
//    UIView *div3 = [UIView new];
//    div3.frame = CGRectMake(SIDEOFSET, self.view.frame.size.width - TOPOFSET, self.view.frame.size.height-2*SIDEOFSET,1.0f);
//    div3.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
//    [self.view addSubview:div3];
//    
//    UIView *div4 = [UIView new];
//    div4.frame = CGRectMake(SIDEOFSET,TOPOFSET,1.0f,self.view.frame.size.width-2*TOPOFSET);
//    div4.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
//    [self.view addSubview:div4];
//    
//    UIView *line1 = [UIView new];
//    line1.frame = CGRectMake(SIDEOFSET,TOPOFSET + 70.0f, 10.0f+1.0f, 1.0f);
//    line1.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1.0];
//    [self.view addSubview:line1];
//    //NSLog(@"buttonheight height = %f",self.view.frame.size.height);
//    
//    UIView *line2 = [UIView new];
//    line2.frame = CGRectMake(self.view.frame.size.height-SIDEOFSET-10.0f, TOPOFSET + 70.0f, 10.0f+1.0f, 1.0f);
//    line2.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1.0];
//    [self.view addSubview:line2];
    //NSLog(@"buttonheight height = %f",self.view.frame.size.height);
    
    
    //NSArray * titles = @[@"1",@"2",@"3",@"4"];
    //[UIColor colorWithRed:67 green:89 blue:113 alpha:1];
    //1.0,0.917,0.619
    //0.854,0.818,0.319,0.631
    //0.141,0.101,0.270
    UIColor *backgroundColor = [[UIColor alloc]initWithRed:0.141 green:0.101 blue:0.270 alpha:0.7];
    
    self.view.backgroundColor = backgroundColor;
    //初始化数据
    //infolist = [[InfoList alloc]init];
    //[infolist infoInit];
    //0.388,0.450,0.631
    //self.descriptionLabel.textColor = [UIColor colorWithRed:0.388 green:0.450 blue:0.631 alpha:1];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"GradeInfo" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:path];
//
    infoArr = [dict objectForKey:@"object"];
    touchOfSet = 0;
//    NSLog(@"%@",infoArr);
//    int times = [infoArr count];
//    anDic = [[NSMutableArray alloc]initWithCapacity:infoArr.count];
//    
//    btList = [[NSMutableArray alloc]initWithCapacity:times];
//    NSLog(@"height:%f,width:%f",self.view.frame.size.height,self.view.frame.size.width);
//    buttonheight = (self.view.frame.size.height-2*SIDEOFSET-2*10.0f)/5;
//    NSLog(@"buttonheight:%f",buttonheight);
//    int i = 0;
//    while (i != times) {
//        UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(SIDEOFSET+30.0f+buttonheight*i , TOPOFSET, buttonheight, buttonheight)];
//        lable.tag = i;
//        NSDictionary * gradeCate = [infoArr objectAtIndex:i];
//
//        [lable setText:[gradeCate objectForKey:@"title"]];
//        [lable setFont:[UIFont fontWithName:@"Helvetica Neue" size:30.0f]];
//        lable.backgroundColor = noColor;
//        lable.textAlignment = NSTextAlignmentCenter;
//        [btList addObject:lable];
//        [self.view addSubview:lable];
//        [lable release];
//        i++;
//    }
//    UILabel *label = [btList objectAtIndex:touchOfSet];
//    label.backgroundColor = enColor;
    
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"GradeView" owner:nil options:nil];
    gradeView = [nibView objectAtIndex:0];
    [gradeView setFrame:CGRectMake(20, 158+179, 752+175-20, 355)];
    gradeView.backgroundColor = [colorArr objectAtIndex:touchOfSet];
    gradeView.description.text = [(NSDictionary *)[infoArr objectAtIndex:touchOfSet]objectForKey:@"description"];
    [self.view addSubview:gradeView];
    
    
    
    UIImage *image = [UIImage imageNamed:@"Thank_image.jpg"];
    self.imageView = [[UIImageView alloc]initWithImage:image];
    [self.imageView setUserInteractionEnabled:YES];
    //[self.imageView setMultipleTouchEnabled:YES];
    self.imageView.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:self.imageView];
    [self.imageView release];
    [self addGestuere];
//    int i = 0;
//    while (i != times) {
//        
//        // = [[GrButton alloc]init];
//        GrButton *button= [GrButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake((SIDEOFSET+10.0f)+buttonheight*i , TOPOFSET, buttonheight-2, TOPOFSET-10.0f);
//        button.tag = i;
//        
//        NSDictionary * gradeCate = [infoArr objectAtIndex:i];
//        
//        [button setTitle:[gradeCate objectForKey:@"title"] forState:UIControlStateNormal];
//        
//        [button.titleLabel setFont:[UIFont fontWithName:@"Noteworthy" size:30.0f]];
//        if (i) {
//            [button setTintColor:[UIColor whiteColor]];
//        }else
//            [button setTintColor:[UIColor blackColor]];
//        [button addrimsWithEnabled:NO];
//        [button addTarget:self action:@selector(buttonEnabled:) forControlEvents:UIControlEventTouchUpInside];
//        [button setShowsTouchWhenHighlighted:NO];
//        button.backgroundColor = [UIColor colorWithRed:0.529 green:0.529 blue:0.529 alpha:1];
//        //[button setUserInteractionEnabled:NO];
//        //button.titleLabel.textColor = [UIColor grayColor];
//        [btList addObject:button];
//        [self.view addSubview:button];
//        //[button setShouldGroupAccessibilityChildren:NO];
//        
//        i++;
//    }
//    GrButton *button  = [btList objectAtIndex:0];
//    [button ChangeHidden:YES];
    
    
    
    
//    [self reloadOptionsWithTag:touchOfSet];
    
    //btOne.buttonType = UIButtonTypeCustom;
    //UITapGestureRecognizer *tapText = [UITapGestureRecognizer new];
    
    
    
//    infoTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, TOPOFSET+OPTIONHEIGHT, self.view.frame.size.width/2, infoArr.count*44.0f) style:UITableViewStyleGrouped];
//    
//    infoTableView.delegate = self;
//    infoTableView.dataSource = self;
//    infoTableView.backgroundColor = [UIColor whiteColor];
    
    //[self.view addSubview:infoTableView];
    
    
    
    
//    UIImage *image = [UIImage imageNamed:@"0.jpg"];
//    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
//    CGRect rect = scrollView.frame;
//    imageView.frame = rect;
//    
//    [scrollView addSubview:imageView];
    
   // [self addGestuere];

   // [self tapOnContentView:tapGestureOne];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)addGestuere
{
    UITapGestureRecognizer *tapGestureOne = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnContentView:)];
    //tapGestureOne.description = @"1";
    //UITapGestureRecognizer *tapGestureTwo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnContentView:)];
    UITapGestureRecognizer *tapGestureThree = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnContentView:)];
    
    UITapGestureRecognizer *tapGestureFinish = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Finish)];
    
    [gradeView.imageViewOne addGestureRecognizer:tapGestureOne];
    //[gradeView.imageViewTwo addGestureRecognizer:tapGestureTwo];
    [gradeView.imageViewThree addGestureRecognizer:tapGestureThree];
    [self.imageView addGestureRecognizer:tapGestureFinish];
}

#pragma -mark reloadDescription
//- (void)reloadOptionsWithTag:(NSInteger )OffSet
//{
//    [UIView animateWithDuration:1.2 animations:^{
//        [self.descriptionLabel setAlpha:0];
//        self.descriptionLabel.text =  [((NSDictionary *)[infoArr objectAtIndex:OffSet]) objectForKey:@"description"];
//        [self.descriptionLabel setAlpha:1];
//        }completion:^(BOOL finished){
//            
//        }];
//}

#pragma -mark pressButton
//- (void)buttonEnabled:(id)sender
//{
//    touchOfSet =((GrButton *)sender).tag;
//    [self ChangeTitleStateWithTag:touchOfSet];
//    [self reloadOptionsWithTag:touchOfSet];
//    [self buttonPressed1];
//    //[btOne ChangeHidden:NO];
//}
#pragma -mark ChangeTitleState
//- (void)ChangeTitleStateWithTag:(NSInteger )tag
//{
//    for (GrButton *button in btList ) {
//        [button ChangeHidden:NO];
//    }
//    GrButton *offSetbutton = [btList objectAtIndex:tag];
//    [offSetbutton ChangeHidden:YES];
//}
#pragma -mark TapGesture
- (void)tapOnContentView:(UITapGestureRecognizer *)tapGestureRecognizer
{
    NSString *answer;
    switch (tapGestureRecognizer.view.tag) {
        case 0:
            answer = @"Y";
            break;
        case 1:
            answer = @"M";
            break;
        case 2:
            answer = @"N";
            break;
    }
    NSDictionary * dictionary = [[NSDictionary alloc]initWithObjects:@[[NSNumber numberWithInt:touchOfSet+1],answer] forKeys:@[@"id",@"answer"]];
    [anDic addObject:dictionary];
    
    //NSLog(@"%d",tapGestureRecognizer.numberOfTouchesRequired);
    //NSLog(@"%ld",(long)tapGestureRecognizer.view.tag);
    //tapGestureRecognizer.
    if (touchOfSet != [infoArr count]-1) {
//        UILabel *label = [btList objectAtIndex:touchOfSet];
//        [label setBackgroundColor:noColor];
        touchOfSet++;
//        label = [btList objectAtIndex:touchOfSet];
//        label.backgroundColor = enColor;
        [self buttonPressed1];
        //[self reloadOptionsWithTag:touchOfSet];
    }else [self buttonPressed2];
    
    
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
    [gradeView setBackgroundColor:[colorArr objectAtIndex:touchOfSet]];
    [gradeView.description setText:[(NSDictionary *)[infoArr objectAtIndex:touchOfSet]objectForKey:@"description"]];
}

- (void)buttonPressed2
{
    [UIView animateWithDuration:0.5 animations:^(void){
        self.imageView.frame = CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width);
    }];
}

- (void)Finish
{
   // NSLog(@"%@",anDic);
    
    
   //[NSThread detachNewThreadSelector:@selector(upload) toTarget:self withObject:nil];

//    UILabel *label = [btList objectAtIndex:touchOfSet];
//    label.backgroundColor = noColor;
    touchOfSet = 0;
//    label = [btList objectAtIndex:touchOfSet];
//    label.backgroundColor = enColor;
    gradeView.description.text = [(NSDictionary *)[infoArr objectAtIndex:touchOfSet] objectForKey:@"description"];
    [gradeView setBackgroundColor:[colorArr objectAtIndex:touchOfSet]];
    [UIView animateWithDuration:0.3 animations:^(void){
        self.imageView.frame = CGRectMake(self.view.frame.size.height, 0, self.view.frame.size.height, self.view.frame.size.width);
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
    NSLog(@"Register JSON:%@",[[NSString alloc] initWithData:tempJsonData encoding:NSUTF8StringEncoding]);
//
    [request setRequestMethod:@"POST"];
    [request setPostBody:tempJsonData];
    
    [request startSynchronous];
    
    //if (!error1) {
        NSString *response = [request responseString];
        NSLog(@"Rev：%@",response);
    //}
    
//
//    NSURL *url = [NSURL URLWithString:@"http://cmcenter.azurewebsites.net/Survey/Submit"];
    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    

//    [request setHTTPMethod:@"POST"];
    
    //[request setValuesForKeysWithDictionary:(NSDictionary *)anDic];
    
    //NSString *str = @"type=focus-c";
    //NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//    [request setHTTPBody:tempJsonData];
//    NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",str1);
}

//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//
//{
//
//    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
//
//    NSLog(@"%@",[res allHeaderFields]);
//
//    //self.receiveData = [NSMutableData data];
//
//}

//#pragma -mark UITableViewDelegate
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
//
//
//#pragma -mark UItableViewDataSoure
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return [infoArr count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *result = nil;
//    if ([tableView isEqual:infoTableView]) {
//        static NSString *TableViewCellIdentifier = @"MyCells";
//        result = [tableView dequeueReusableCellWithIdentifier:TableViewCellIdentifier];
//        if (result == nil) {
//            result = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TableViewCellIdentifier];
//        }
//        result.textLabel.text = [[infoArr objectAtIndex:indexPath.row]objectForKey:@"title"];
//    }
//    result.backgroundColor = [UIColor clearColor];
//    NSLog(@"%f",result.frame.size.height);
//    
//    return result;
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)
//    {
//        return YES;
//    } else
//    {
//        return NO;
//    }
//}
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation NS_DEPRECATED_IOS(2_0, 6_0)
//{
//    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
//    {
//        return YES;
//    } else
//    {
//        return NO;
//    }
//    
//}

@end
