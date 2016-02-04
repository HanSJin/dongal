//
//  NoticeVC.m
//  Dongal
//
//  Created by 한승진 on 2016. 2. 3..
//  Copyright © 2016년 com.twentyApps. All rights reserved.
//

#import "NoticeVC.h"
#import "NoticeObj.h"
#import "NoticeCell.h"

#import "Constants.h"
#import "Customs.h"
#import "SingletonData.h"
#import "ConnectionFactory.h"

@interface NoticeVC () <UITableViewDataSource, UITableViewDelegate> {
    UITableView *noticeTableView;
    NSMutableArray *noticeList;
    BOOL endOfLoadMore;
}

@end

@implementation NoticeVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:WHITE_COLOR];
    
    [self initNavigationSetting];
    [self setNoticeTableView];
    [self initDataObject];
    
}

#pragma mark - INIT AREA


- (void)initDataObject {
    SingletonData *sharedMan = [SingletonData sharedManager];
    NSString *params = [NSString stringWithFormat:@"uuid=%@&offset=%d&limit=%d", sharedMan.UUID, 0, 20];
    NSData *myData = [ConnectionFactory connType:@"GET" connAPI:CONNECT_GET_NOTICE connParam:params];
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
    
    noticeList = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *dic in result) {
        NoticeObj *obj = [[NoticeObj alloc] initWithDictionary:dic];
        [noticeList addObject:obj];
    }
    
}

- (void)initNavigationSetting {
    [self.navigationController.navigationBar.topItem setTitle:@"동알 앤 동알"];
}

- (void)setNoticeTableView {
    noticeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT-IS_HOT_SPOT)];
    noticeTableView.delegate = self;
    noticeTableView.dataSource = self;
    noticeTableView.separatorColor = CLEAR_COLOR;
    [self.view addSubview:noticeTableView];
    
}







#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return noticeList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    for (UIView *subView in cell.subviews)
        [subView removeFromSuperview];
    
    NoticeObj *obj = (NoticeObj *)[noticeList objectAtIndex:indexPath.row];
    
    
    NoticeCell *csCell = [[NoticeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    [csCell awakeFromNib:self object:obj indexPath:indexPath];
    cell = csCell;
    
    if (indexPath.row == [noticeList count] - 1 && !endOfLoadMore)
        [self launchReload];
        
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



- (void)launchReload {
    SingletonData *sharedMan = [SingletonData sharedManager];
    NSString *params = [NSString stringWithFormat:@"uuid=%@&offset=%lu&limit=%d", sharedMan.UUID, (unsigned long)noticeList.count, 20];
    NSData *myData = [ConnectionFactory connType:@"GET" connAPI:CONNECT_GET_NOTICE connParam:params];
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
    
    for (NSMutableDictionary *dic in result) {
        NoticeObj *obj = [[NoticeObj alloc] initWithDictionary:dic];
        [noticeList addObject:obj];
    }
    if ([result count] == 0)
        endOfLoadMore = YES;
    
    [noticeTableView reloadData];
}

- (void)likeButtonTapped:(id)sender {
    SingletonData *sharedMan = [SingletonData sharedManager];
    UIButton *button = sender;
    NoticeObj *obj = ((NoticeObj *) [noticeList objectAtIndex:button.tag]);
    NSString *params = [NSString stringWithFormat:@"uuid=%@&wr_id=%@&bo_table=%@", sharedMan.UUID, obj.wr_id, obj.board_name];
    NSData *myData = [ConnectionFactory connType:@"POST" connAPI:CONNECT_POST_LIKE connParam:params];
    
    
    params = [NSString stringWithFormat:@"uuid=%@&offset=%d&limit=%lu", sharedMan.UUID, 0, (unsigned long)noticeList.count];
    myData = [ConnectionFactory connType:@"GET" connAPI:CONNECT_GET_NOTICE connParam:params];
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
    
    [noticeList removeAllObjects];
    for (NSMutableDictionary *dic in result) {
        NoticeObj *obj = [[NoticeObj alloc] initWithDictionary:dic];
        [noticeList addObject:obj];
    }
    
    [noticeTableView reloadData];
}

@end
