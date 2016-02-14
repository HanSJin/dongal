//
//  SearchVC.m
//  Dongal
//
//  Created by 한승진 on 2016. 2. 3..
//  Copyright © 2016년 com.twentyApps. All rights reserved.
//

#import "SearchVC.h"
#import "NoticeObj.h"
#import "NoticeCell.h"
#import "NoticeDetailVC.h"
#import "TOWebViewController.h"

#import "Constants.h"
#import "Customs.h"
#import "SingletonData.h"
#import "ConnectionFactory.h"

@interface SearchVC () <UITableViewDataSource, UITableViewDelegate> {
    UITableView *noticeTableView;
    NSMutableArray *noticeList;
    
    UISearchBar *searchBar;
    UISearchDisplayController *searchDisplayController;
}


@end

@implementation SearchVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:BLACK_COLOR];
    [self.navigationController.navigationBar setBarTintColor:DONGGUK_COLOR];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    
    noticeList = [[NSMutableArray alloc] init];
    [self initNavigationSetting];
    [self setNoticeTableView];
}

#pragma mark - INIT AREA


- (void)initDataObject:(NSString *)stx offset:(NSInteger)offset limit:(NSInteger)limit {
    SingletonData *sharedMan = [SingletonData sharedManager];
    NSString *params = [NSString stringWithFormat:@"uuid=%@&offset=%d&limit=%d&stx=%@", sharedMan.UUID, offset, limit, stx];
    NSData *myData = [ConnectionFactory connType:@"GET" connAPI:CONNECT_GET_NOTICE_SEARCH connParam:params];
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
    
    for (NSMutableDictionary *dic in result) {
        NoticeObj *obj = [[NoticeObj alloc] initWithDictionary:dic];
        [noticeList addObject:obj];
    }
    
    [noticeTableView reloadData];
}

- (void)initNavigationSetting {
    [self.navigationController.navigationBar.topItem setTitle:@"검색"];
}

- (void)setNoticeTableView {
    noticeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCR_WIDTH, SCR_HEIGHT-IS_HOT_SPOT)];
    noticeTableView.delegate = self;
    noticeTableView.dataSource = self;
    noticeTableView.separatorColor = CLEAR_COLOR;
    [self.view addSubview:noticeTableView];
    
    
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    /*the search bar widht must be > 1, the height must be at least 44
     (the real size of the search bar)*/
    
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
    /*contents controller is the UITableViewController, this let you to reuse
     the same TableViewController Delegate method used for the main table.*/
    
    searchDisplayController.delegate = self;
    searchDisplayController.searchResultsDelegate = self;
    searchDisplayController.searchResultsDataSource = self;
    //set the delegate = self. Previously declared in ViewController.h
    
    noticeTableView.tableHeaderView = searchBar; //this line add the searchBar
    //on the top of tableView.
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    if (![searchBar.text isEqualToString:@""]) {
        [noticeList removeAllObjects];
        [self initDataObject:searchBar.text offset:0 limit:80];
    }
    return YES;
}
- (void)searchDisplayController:(UISearchDisplayController *)controller willShowSearchResultsTableView:(UITableView *)tableView {
    [tableView setRowHeight:100];
    [tableView numberOfRowsInSection:0];
    [tableView reloadData];
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
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NoticeObj *obj = (NoticeObj *)[noticeList objectAtIndex:indexPath.row];
    TOWebViewController *webViewController = [[TOWebViewController alloc] initWithURL:[NSURL URLWithString:obj.wr_link]];
    webViewController.pushOrPop = @"psuh";
    webViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([searchDisplayController isActive]) {
//        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        [self performSegueWithIdentifier:@"detailSegue" sender:cell];
//    }
//}


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
