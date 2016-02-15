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
#import "NoticeDetailVC.h"
#import "TOWebViewController.h"

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
    
    [self initDataObject];
    [noticeTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:WHITE_COLOR];
    [self.navigationController.navigationBar setBarTintColor:DONGGUK_COLOR];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self initNavigationSetting];
    [self setNoticeTableView];
    
}

#pragma mark - INIT AREA

-(NSString *)getBoardName {
    
    NSString *board = @"";
    if ([self.board_name isEqualToString:@"전체보기"])
        board = @"all";
    else if ([self.board_name isEqualToString:@"일반"])
        board = @"normals";
    else if ([self.board_name isEqualToString:@"학사"])
        board = @"studies";
    else if ([self.board_name isEqualToString:@"장학"])
        board = @"scholars";
    else if ([self.board_name isEqualToString:@"학술"])
        board = @"proceedings";
    else if ([self.board_name isEqualToString:@"입학"])
        board = @"entrances";
    else if ([self.board_name isEqualToString:@"국제"])
        board = @"globals";
    
    else if ([self.board_name isEqualToString:@"예술대"])
        board = @"arts";
    else if ([self.board_name isEqualToString:@"불교대"])
        board = @"bs";
    else if ([self.board_name isEqualToString:@"사범대"])
        board = @"edus";
    else if ([self.board_name isEqualToString:@"공과대"])
        board = @"engineers";
    else if ([self.board_name isEqualToString:@"법과대"])
        board = @"laws";
    else if ([self.board_name isEqualToString:@"문과대"])
        board = @"liberals";
    else if ([self.board_name isEqualToString:@"바이오시스템대"])
        board = @"lives";
    else if ([self.board_name isEqualToString:@"약학대"])
        board = @"pharms";
    else if ([self.board_name isEqualToString:@"경영대"])
        board = @"sbas";
    else if ([self.board_name isEqualToString:@"이과대"])
        board = @"sciences";
    else if ([self.board_name isEqualToString:@"사회과학대"])
        board = @"socials";
    
    return board;
}

- (void)initDataObject {
    
    SingletonData *sharedMan = [SingletonData sharedManager];
    NSString *params = [NSString stringWithFormat:@"uuid=%@&board=%@&offset=%d&limit=%d", sharedMan.UUID, [self getBoardName], 0, 20];
    NSData *myData = [ConnectionFactory connType:@"GET" connAPI:CONNECT_GET_NOTICE connParam:params];
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
    
    noticeList = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *dic in result) {
        NoticeObj *obj = [[NoticeObj alloc] initWithDictionary:dic];
        [noticeList addObject:obj];
    }
    
}

- (void)initNavigationSetting {
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar.topItem setTitle:@"동꾸기"];
}

- (void)setNoticeTableView {
    noticeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT-IS_HOT_SPOT-40-64-50)];
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
    NoticeObj *obj = (NoticeObj *)[noticeList objectAtIndex:indexPath.row];
    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:[NSURL URLWithString:obj.wr_link]];
    webViewController.pushOrPop = @"psuh";
    webViewController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:webViewController animated:YES];
}



- (void)launchReload {
    
    UIView *loading = [Customs CSViewRect:self.view.frame backColor:[UIColor colorWithWhite:0 alpha:0.3f]];
    [self.view addSubview:loading];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            SingletonData *sharedMan = [SingletonData sharedManager];
            NSString *params = [NSString stringWithFormat:@"uuid=%@&board=%@&offset=%lu&limit=%d", sharedMan.UUID, [self getBoardName], (unsigned long)noticeList.count, 20];
            NSData *myData = [ConnectionFactory connType:@"GET" connAPI:CONNECT_GET_NOTICE connParam:params];
            NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
            
            for (NSMutableDictionary *dic in result) {
                NoticeObj *obj = [[NoticeObj alloc] initWithDictionary:dic];
                [noticeList addObject:obj];
            }
            if ([result count] == 0)
                endOfLoadMore = YES;
            
            [noticeTableView reloadData];
            
            [loading removeFromSuperview];
            
        });
    });
}

- (void)likeButtonTapped:(id)sender {
    SingletonData *sharedMan = [SingletonData sharedManager];
    UIButton *button = sender;
    NoticeObj *obj = ((NoticeObj *) [noticeList objectAtIndex:button.tag]);
    NSString *params = [NSString stringWithFormat:@"uuid=%@&wr_id=%@&bo_table=%@", sharedMan.UUID, obj.wr_id, obj.board_name];
    NSData *myData = [ConnectionFactory connType:@"POST" connAPI:CONNECT_POST_LIKE connParam:params];
    
    
    params = [NSString stringWithFormat:@"uuid=%@&board=%@&offset=%d&limit=%lu", sharedMan.UUID, [self getBoardName], 0, (unsigned long)noticeList.count];
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
