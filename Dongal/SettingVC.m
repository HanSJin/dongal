//
//  SettingVC.m
//  Dongal
//
//  Created by 한승진 on 2016. 2. 3..
//  Copyright © 2016년 com.twentyApps. All rights reserved.
//

#import "SettingVC.h"
#import "SettingBoardVC.h"
#import "SettingAlarmVC.h"
#import "SettingKeywordVC.h"

#import "Constants.h"
#import "Customs.h"
#import "SingletonData.h"
#import "ConnectionFactory.h"

@interface SettingVC () <UITableViewDataSource, UITableViewDelegate> {
    UITableView *settingTableView;
    NSMutableArray *tableData;
    NSMutableArray *sectionData;
    NSMutableDictionary *keywordUse;
    NSMutableArray *keywordData;
    NSMutableArray *keywordData_no;
    UIView *bottomView;
    UITextView *bottomeViewTextView;
}

@end

@implementation SettingVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self initNavigationSetting];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setNoticeTableView];
    [self initDataObject];
    [self setBottomView];
    
    [self.view setBackgroundColor:BLACK_COLOR];
    [self.navigationController.navigationBar setBarTintColor:DONGGUK_COLOR];
    [self.navigationController.navigationBar setTintColor:WHITE_COLOR];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    sectionData = [[NSMutableArray alloc] init];
    [sectionData addObject:@"키워드 알람 설정"];
    [sectionData addObject:@"키워드 목록"];
    
    tableData = [[NSMutableArray alloc] init];
    [tableData addObject:@"단과 대학 설정"];
    [tableData addObject:@"공지 알람 설정"];
    [tableData addObject:@"키워드 알람 설정"];
}

#pragma mark - INIT AREA


- (void)initNavigationSetting {
    [self.navigationController.navigationBar.topItem setTitle:@"설정"];
    [self.navigationController.navigationBar setTranslucent:NO];
}

- (void)setNoticeTableView {
    settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT-IS_HOT_SPOT-SCR_TAB-49-64)];
    settingTableView.delegate = self;
    settingTableView.dataSource = self;
    [settingTableView setAllowsSelection:YES];
//    settingTableView.separatorColor = CLEAR_COLOR;
    [self.view addSubview:settingTableView];
    
}


- (void)initDataObject {
    SingletonData *sharedMan = [SingletonData sharedManager];
    NSString *params = [NSString stringWithFormat:@"uuid=%@", sharedMan.UUID];
    NSData *myData = [ConnectionFactory connType:@"GET" connAPI:CONNECT_GET_KEYWORD connParam:params];
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
    
    keywordData = [[NSMutableArray alloc] init];
    keywordData_no = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *dic in result) {
        [keywordData addObject:[NSString stringWithFormat:@"%@", [dic objectForKey:@"keyword_txt"]]];
        [keywordData_no addObject:[NSString stringWithFormat:@"%@", [dic objectForKey:@"keyword_no"]]];
    }
    
    myData = [ConnectionFactory connType:@"GET" connAPI:CONNECT_GET_KEYWORD_STATE connParam:params];
    keywordUse = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
}


- (void)setBottomView {
    bottomView = [Customs CSViewRect:CGRectMake(0, SCR_HEIGHT-SCR_TAB-IS_HOT_SPOT-SCR_TAB-64, SCR_WIDTH, SCR_TAB) backColor:DONGGUK_COLOR];
    [self.view addSubview:bottomView];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:@"UIKeyboardWillShowNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:@"UIKeyboardWillHideNotification"
                                               object:nil];
    
    bottomeViewTextView = [[UITextView alloc] initWithFrame:CGRectMake(16, 10, SCR_WIDTH-86-60, 30)];
    bottomeViewTextView.delegate = self;
    bottomeViewTextView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0f];
    bottomeViewTextView.layer.cornerRadius = 5.0f;
    [bottomView addSubview:bottomeViewTextView];
    
    
    
    UIButton *sendBtn = [[UIButton alloc] init];
    sendBtn.frame = CGRectMake(SCR_WIDTH-60-60, 10, 50, 30);
    sendBtn.font = [UIFont fontWithName:FONT_L size:[UIFont systemFontSize]];
    [sendBtn setTitle:@"추 가" forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn setBackgroundColor:CLEAR_COLOR];
    [sendBtn addTarget:self action:@selector(sendBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:sendBtn];
    
    
    UIButton *cancelBtn = [[UIButton alloc] init];
    cancelBtn.frame = CGRectMake(SCR_WIDTH-60, 10, 50, 30);
    cancelBtn.font = [UIFont fontWithName:FONT_L size:[UIFont systemFontSize]];
    [cancelBtn setTitle:@"취 소" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:CLEAR_COLOR];
    [cancelBtn addTarget:self action:@selector(dismissKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:cancelBtn];
}







#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return sectionData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 1;
    else if (section == 1)
        return keywordData.count;
    else
        return 0;
//    return tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIView *subView in cell.subviews)
        [subView removeFromSuperview];
    
    if (indexPath.section == 0) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    }
    
    
    
    else if (indexPath.section == 1) {
        NSString *dataStr = [NSString stringWithFormat:@"%@", [keywordData objectAtIndex:indexPath.row]];
        UILabel *textLabel = [Customs CSLabelText:dataStr LabelRect:CGRectMake(16, 16, SCR_WIDTH-100, 20) textAlign:@"left" textFont:FONT_L textSize:1 textColor:BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:textLabel];
        
    }
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 28;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    /* Create custom view to display section header... */
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, tableView.frame.size.width, 18)];
    [label setFont:[UIFont boldSystemFontOfSize:12]];
    NSString *string =[sectionData objectAtIndex:section];
    /* Section header is in 0th index... */
    [label setText:string];
    [view addSubview:label];
    [view setBackgroundColor:LIGHT_GRAY_COLOR]; //your background color...

    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        UIViewController *toVC = [[SettingBoardVC alloc] init];
        toVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:toVC animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self removeKeyword:indexPath.row];
        [keywordData removeObjectAtIndex:indexPath.row];
        [keywordData_no removeObjectAtIndex:indexPath.row];
        NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row inSection:1];
        [tableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
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
        
        
        [self dismissKeyboard];
        [self initDataObject];
        [settingTableView reloadData];
        bottomeViewTextView.text = @"";
    }
}

- (void)removeKeyword:(NSInteger)index {
    SingletonData *sharedMan = [SingletonData sharedManager];
    NSString *params = [NSString stringWithFormat:@"uuid=%@&keyword_no=%@", sharedMan.UUID, [keywordData_no objectAtIndex:index]];
    NSData *myData = [ConnectionFactory connType:@"POST" connAPI:CONNECT_POST_KEYWORD_DELETE connParam:params];
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
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
                                      SCR_HEIGHT-49-keyboardBounds.size.height-IS_HOT_SPOT-(bottomeViewTextView.frame.size.height-30)-64,
                                      bottomView.frame.size.width,
                                      bottomView.frame.size.height);   //resize
        settingTableView.frame = CGRectMake(settingTableView.frame.origin.x,
                                            settingTableView.frame.origin.y,
                                            settingTableView.frame.size.width,
                                            SCR_HEIGHT-keyboardBounds.size.height-IS_HOT_SPOT-(bottomeViewTextView.frame.size.height)-64-19);   //resize
    } completion:^(BOOL finished){}];
}

- (void)keyboardWillHide:(NSNotification *)note {
    CGRect keyboardBounds;
    
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        bottomView.frame = CGRectMake(bottomView.frame.origin.x,
                                      SCR_HEIGHT-49-IS_HOT_SPOT-(bottomeViewTextView.frame.size.height-30)-SCR_TAB-64,
                                      bottomView.frame.size.width,
                                      bottomView.frame.size.height);   //resize
        settingTableView.frame = CGRectMake(settingTableView.frame.origin.x,
                                            settingTableView.frame.origin.y,
                                            settingTableView.frame.size.width,
                                            SCR_HEIGHT-49-IS_HOT_SPOT-(bottomeViewTextView.frame.size.height-30)-64-49);   //resize
    } completion:^(BOOL finished){}];
}

float lastHeight;
- (void)textViewDidChange:(UITextView *)textView {
    CGRect textViewFrame = bottomeViewTextView.frame;
    CGRect bottomeViewFrame = bottomView.frame;
    textViewFrame.size.height = bottomeViewTextView.contentSize.height;
    
    if (lastHeight < 30)
        lastHeight = 30;
    
    if (textViewFrame.size.height < 30)
        textViewFrame.size.height = 30;
    
    if (textViewFrame.size.height > 100)
        return;
    
    if (textViewFrame.size.height != lastHeight) {
        bottomeViewFrame.origin.y = bottomeViewFrame.origin.y - (textViewFrame.size.height-lastHeight);
        bottomeViewFrame.size.height = bottomeViewFrame.size.height + (textViewFrame.size.height-lastHeight);
        
        [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            bottomeViewTextView.frame = textViewFrame;
            bottomView.frame = bottomeViewFrame;   //resize
        } completion:^(BOOL finished){
            
        }];
        lastHeight = textViewFrame.size.height;
    }
    
}

@end
