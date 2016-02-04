//
//  SettingAlarmVC.m
//  Dongal
//
//  Created by 한승진 on 2016. 2. 3..
//  Copyright © 2016년 com.twentyApps. All rights reserved.
//

#import "SettingAlarmVC.h"
#import "CollegeObj.h"

#import "Constants.h"
#import "Customs.h"
#import "SingletonData.h"
#import "ConnectionFactory.h"

@interface SettingAlarmVC () <UITableViewDataSource, UITableViewDelegate> {
    UITableView *alarmTableView;
    NSMutableArray *alarmData;
    NSMutableDictionary *mbAlarmData;
}

@end

@implementation SettingAlarmVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:WHITE_COLOR];
    
    [self initNavigationSetting];
    [self setCollegeTableView];
    [self initDataObject];
}

#pragma mark - INIT AREA


- (void)initNavigationSetting {
    self.title = @"공지 알람 설정";
    [self.navigationController.navigationBar setTintColor:GREENT_COLOR];
}

- (void)setCollegeTableView {
    alarmTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT-IS_HOT_SPOT)];
    alarmTableView.delegate = self;
    alarmTableView.dataSource = self;
    [self.view addSubview:alarmTableView];
    
}

- (void)initDataObject {
    SingletonData *sharedMan = [SingletonData sharedManager];
    NSString *params = [NSString stringWithFormat:@"uuid=%@", sharedMan.UUID];
    NSData *myData = [ConnectionFactory connType:@"GET" connAPI:CONNECT_GET_ALARM connParam:params];
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
    
    alarmData = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *dic in result) {
        CollegeObj *obj = [[CollegeObj alloc] initWithDictionary:dic];
        [alarmData addObject:obj];
    }
    
    myData = [ConnectionFactory connType:@"GET" connAPI:CONNECT_GET_MB_ALARM connParam:params];
    mbAlarmData = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return alarmData.count;
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
    
    CollegeObj *data = ((CollegeObj *) [alarmData objectAtIndex:indexPath.row]);
    UILabel *textLabel = [Customs CSLabelText:data.college_title LabelRect:CGRectMake(16, 16, SCR_WIDTH-100, 20) textAlign:@"left" textFont:FONT_L textSize:1 textColor:BLACK_COLOR backColor:CLEAR_COLOR];
    [cell addSubview:textLabel];
    
    UISwitch *collegeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    collegeSwitch.center = CGPointMake(SCR_WIDTH-50, cell.center.y+2);
    [collegeSwitch setTag:indexPath.row];
    [collegeSwitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    [cell addSubview:collegeSwitch];
    
    if ([[mbAlarmData objectForKey:data.college_name] boolValue])
        [collegeSwitch setOn:YES animated:NO];
    else
        [collegeSwitch setOn:NO animated:NO];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)changeSwitch:(id)sender{
    UISwitch *swit = (UISwitch *) sender;
    CollegeObj *obj = ((CollegeObj *)[alarmData objectAtIndex:swit.tag]);
    
    SingletonData *sharedMan = [SingletonData sharedManager];
    NSString *params = [NSString stringWithFormat:@"uuid=%@&college=%@", sharedMan.UUID,obj.college_name];
    NSData *myData = [ConnectionFactory connType:@"POST" connAPI:CONNECT_POST_MB_ALARM connParam:params];
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
}

@end
