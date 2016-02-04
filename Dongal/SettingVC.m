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
    
    tableData = [[NSMutableArray alloc] init];
    [tableData addObject:@"단과 대학 설정"];
    [tableData addObject:@"공지 알람 설정"];
    [tableData addObject:@"키워드 알람 설정"];
}

#pragma mark - INIT AREA


- (void)initNavigationSetting {
    [self.navigationController.navigationBar.topItem setTitle:@"설정"];
}

- (void)setNoticeTableView {
    settingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT-IS_HOT_SPOT)];
    settingTableView.delegate = self;
    settingTableView.dataSource = self;
//    settingTableView.separatorColor = CLEAR_COLOR;
    [self.view addSubview:settingTableView];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    for (UIView *subView in cell.subviews)
        [subView removeFromSuperview];
    
    UILabel *textLabel = [Customs CSLabelText:[tableData objectAtIndex:indexPath.row] LabelRect:CGRectMake(16, 16, SCR_WIDTH-100, 20) textAlign:@"left" textFont:FONT_L textSize:1 textColor:BLACK_COLOR backColor:CLEAR_COLOR];
    [cell addSubview:textLabel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *toVC;
    if (indexPath.row == 0)
        toVC = [[SettingBoardVC alloc] init];
    else if (indexPath.row == 1)
        toVC = [[SettingAlarmVC alloc] init];
    else if (indexPath.row == 2)
        toVC = [[SettingKeywordVC alloc] init];
//    toVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:toVC animated:YES];
        
}



@end
