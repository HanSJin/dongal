//
//  SettingKeywordVC.m
//  Dongal
//
//  Created by 한승진 on 2016. 2. 3..
//  Copyright © 2016년 com.twentyApps. All rights reserved.
//

#import "SettingKeywordVC.h"

#import "Constants.h"
#import "Customs.h"
#import "SingletonData.h"
#import "ConnectionFactory.h"

@interface SettingKeywordVC () <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate> {
    UITableView *keywordTableView;
    NSMutableArray *keywordData;
    NSMutableArray *keywordHeaderData;
    UIView *bottomView;
    UITextView *bottomeViewTextView;
    NSMutableDictionary *keywordUse;
}

@end

@implementation SettingKeywordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:WHITE_COLOR];
    
    [self initNavigationSetting];
    [self setCollegeTableView];
    [self setBottomView];
    [self initDataObject];
}

#pragma mark - INIT AREA

- (void)setBottomView {
    bottomView = [Customs CSViewRect:CGRectMake(0, SCR_HEIGHT-SCR_TAB-IS_HOT_SPOT, SCR_WIDTH, SCR_TAB) backColor:GREENT_COLOR];
    [self.view addSubview:bottomView];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:@"UIKeyboardWillShowNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:@"UIKeyboardWillHideNotification"
                                               object:nil];
    
    bottomeViewTextView = [[UITextView alloc] initWithFrame:CGRectMake(16, 10, SCR_WIDTH-86, 30)];
    bottomeViewTextView.delegate = self;
    bottomeViewTextView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0f];
    bottomeViewTextView.layer.cornerRadius = 5.0f;
    [bottomView addSubview:bottomeViewTextView];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    UIButton *sendBtn = [[UIButton alloc] init];
    sendBtn.frame = CGRectMake(SCR_WIDTH-60, 10, 50, 30);
    sendBtn.font = [UIFont fontWithName:FONT_L size:[UIFont systemFontSize]];
    [sendBtn setTitle:@"등 록" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn setBackgroundColor:CLEAR_COLOR];
    [sendBtn addTarget:self action:@selector(sendBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sendBtn];

    
    
}

- (void)initNavigationSetting {
    self.title = @"공지 알람 설정";
}

- (void)setCollegeTableView {
    keywordTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT-IS_HOT_SPOT)];
    keywordTableView.delegate = self;
    keywordTableView.dataSource = self;
//    keywordTableView.separatorColor = CLEAR_COLOR;
    [self.view addSubview:keywordTableView];
    
}

- (void)initDataObject {
    keywordHeaderData = [[NSMutableArray alloc] init];
    [keywordHeaderData addObject:@"알람 설정"];
    [keywordHeaderData addObject:@"키워드 목록"];
    
    SingletonData *sharedMan = [SingletonData sharedManager];
    NSString *params = [NSString stringWithFormat:@"uuid=%@", sharedMan.UUID];
    NSData *myData = [ConnectionFactory connType:@"GET" connAPI:CONNECT_GET_KEYWORD connParam:params];
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
    
    keywordData = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *dic in result) {
        [keywordData addObject:[NSString stringWithFormat:@"%@", [dic objectForKey:@"keyword_txt"]]];
    }
    
    myData = [ConnectionFactory connType:@"GET" connAPI:CONNECT_GET_KEYWORD_STATE connParam:params];
    keywordUse = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 1;
    else if (section == 1)
        return keywordData.count;
    else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIView *subView in cell.subviews)
        [subView removeFromSuperview];
    if (indexPath.section == 0) {

        NSString *dataStr = [NSString stringWithFormat:@"키워드 알람 받기"];
        UILabel *textLabel = [Customs CSLabelText:dataStr LabelRect:CGRectMake(16, 16, SCR_WIDTH-100, 20) textAlign:@"left" textFont:FONT_L textSize:1 textColor:BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:textLabel];
        
        UISwitch *collegeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        collegeSwitch.center = CGPointMake(SCR_WIDTH-50, cell.center.y+2);
        [collegeSwitch setTag:indexPath.row];
        [collegeSwitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
        [cell addSubview:collegeSwitch];
        
        if ([[keywordUse objectForKey:@"use_keyword"] boolValue])
            [collegeSwitch setOn:YES animated:NO];
        else
            [collegeSwitch setOn:NO animated:NO];
        
    } else {
        NSString *dataStr = [NSString stringWithFormat:@"%@", [keywordData objectAtIndex:indexPath.row]];
        UILabel *textLabel = [Customs CSLabelText:dataStr LabelRect:CGRectMake(16, 16, SCR_WIDTH-100, 20) textAlign:@"left" textFont:FONT_L textSize:1 textColor:BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:textLabel];
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 28;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *string =[keywordHeaderData objectAtIndex:section];
    
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:LIGHT_GRAY_COLOR]; //your background color...
    return view;
}



- (void)changeSwitch:(id)sender{
    SingletonData *sharedMan = [SingletonData sharedManager];
    NSString *params = [NSString stringWithFormat:@"uuid=%@", sharedMan.UUID];
    NSData *myData = [ConnectionFactory connType:@"POST" connAPI:CONNECT_POST_KEYWORD_STATE connParam:params];
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
}


- (void)sendBtnTapped:(id)sender {
    if (![bottomeViewTextView.text isEqualToString:@""]) {
        SingletonData *sharedMan = [SingletonData sharedManager];
        NSString *params = [NSString stringWithFormat:@"uuid=%@&keyword=%@", sharedMan.UUID, bottomeViewTextView.text];
        NSData *myData = [ConnectionFactory connType:@"POST" connAPI:CONNECT_POST_KEYWORD connParam:params];
        NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
        
        [keywordTableView beginUpdates];
        NSIndexPath *index = [NSIndexPath indexPathForRow:keywordData.count inSection:2];
        [keywordData insertObject:[NSString stringWithFormat:@"%@", bottomeViewTextView.text] atIndex:keywordData.count];
        [keywordTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationFade];
        [keywordTableView endUpdates];
    }
}





// 키보드 이벤트들

-(void)dismissKeyboard {
    [bottomeViewTextView resignFirstResponder];
}
- (void)keyboardWillShow:(NSNotification *)note {
    CGRect keyboardBounds;
    
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        bottomView.frame = CGRectMake(bottomView.frame.origin.x,
                                      SCR_HEIGHT-49-keyboardBounds.size.height-IS_HOT_SPOT-(bottomeViewTextView.frame.size.height-30),
                                      bottomView.frame.size.width,
                                      bottomView.frame.size.height);   //resize
        keywordTableView.frame = CGRectMake(keywordTableView.frame.origin.x,
                                     keywordTableView.frame.origin.y,
                                     keywordTableView.frame.size.width,
                                     SCR_HEIGHT-50-keyboardBounds.size.height-IS_HOT_SPOT-(bottomeViewTextView.frame.size.height-30));   //resize
    } completion:^(BOOL finished){}];
}

- (void)keyboardWillHide:(NSNotification *)note {
    CGRect keyboardBounds;
    
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        bottomView.frame = CGRectMake(bottomView.frame.origin.x,
                                      SCR_HEIGHT-49-IS_HOT_SPOT-(bottomeViewTextView.frame.size.height-30)-SCR_TAB,
                                      bottomView.frame.size.width,
                                      bottomView.frame.size.height);   //resize
        keywordTableView.frame = CGRectMake(keywordTableView.frame.origin.x,
                                     keywordTableView.frame.origin.y,
                                     keywordTableView.frame.size.width,
                                     SCR_HEIGHT-50-IS_HOT_SPOT-(bottomeViewTextView.frame.size.height-30)-SCR_TAB);   //resize
    } completion:^(BOOL finished){}];
}

//float lastHeight;
//- (void)textViewDidChange:(UITextView *)textView {
//    CGRect textViewFrame = bottomeViewTextView.frame;
//    CGRect bottomeViewFrame = bottomView.frame;
//    textViewFrame.size.height = bottomeViewTextView.contentSize.height;
//    
//    if (lastHeight < 30)
//        lastHeight = 30;
//    
//    if (textViewFrame.size.height < 30)
//        textViewFrame.size.height = 30;
//    
//    if (textViewFrame.size.height > 100)
//        return;
//    
//    if (textViewFrame.size.height != lastHeight) {
//        bottomeViewFrame.origin.y = bottomeViewFrame.origin.y - (textViewFrame.size.height-lastHeight);
//        bottomeViewFrame.size.height = bottomeViewFrame.size.height + (textViewFrame.size.height-lastHeight);
//        
//        [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
//            bottomeViewTextView.frame = textViewFrame;
//            bottomView.frame = bottomeViewFrame;   //resize
//        } completion:^(BOOL finished){
//            
//        }];
//        lastHeight = textViewFrame.size.height;
//    }
//    
//}
//

@end
