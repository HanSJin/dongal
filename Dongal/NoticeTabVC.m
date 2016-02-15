//
//  NoticeTabVC.m
//  Dongal
//
//  Created by 한승진 on 2016. 2. 15..
//  Copyright © 2016년 com.twentyApps. All rights reserved.
//

#import "NoticeTabVC.h"
#import "NoticeVC.h"

#import "Constants.h"
#import "Customs.h"
#import "SingletonData.h"
#import "ConnectionFactory.h"

@interface NoticeTabVC () <KHTabPagerDataSource, KHTabPagerDelegate> {
    BOOL isLoaded;
    NSMutableArray *boardList;
}

@property (assign, nonatomic) BOOL isProgressive;

@end

@implementation NoticeTabVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    boardList = [[NSMutableArray alloc] init];
    [boardList addObject:@"전체보기"];
    
    [boardList addObject:@"일반"];
    [boardList addObject:@"학사"];
    [boardList addObject:@"장학"];
    [boardList addObject:@"학술"];
    [boardList addObject:@"입학"];
    [boardList addObject:@"국제"];
    
    [boardList addObject:@"예술대"];
    [boardList addObject:@"불교대"];
    [boardList addObject:@"사범대"];
    [boardList addObject:@"공과대"];
    [boardList addObject:@"법과대"];
    [boardList addObject:@"문과대"];
    [boardList addObject:@"바이오시스템대"];
    [boardList addObject:@"약학대"];
    [boardList addObject:@"경영대"];
    [boardList addObject:@"이과대"];
    [boardList addObject:@"사회과학대"];
    
    [self setDataSource:self];
    [self setDelegate:self];
    
    [self reloadData];
}





#pragma mark - KHTabPagerDataSource

- (NSInteger)numberOfViewControllers {
    return boardList.count;
}

- (UIViewController *)viewControllerForIndex:(NSInteger)index {
    NoticeVC *vc = [NoticeVC new];
    NSString *title = (NSString *) [boardList objectAtIndex:index];
    vc.board_name = title;
    
    return vc;
}

- (NSString *)titleForTabAtIndex:(NSInteger)index {
//    UnivNoticeBoardObject *obj = (UnivNoticeBoardObject *) [self.noticeBoardObjList objectAtIndex:index];
    NSString *title = (NSString *) [boardList objectAtIndex:index];
    return title;
}

- (CGFloat)tabHeight {
    return 40.0f;
}

- (CGFloat)tabBarTopViewHeight {
    return 0;
}

- (UIColor *)tabColor {
    return DONGGUK_COLOR;
}

-(UIColor *)tabBackgroundColor {
    return WHITE_COLOR;
}

-(UIColor *)titleColor {
    return BLACK_COLOR;
}

-(UIFont *)titleFont {
    return [UIFont fontWithName:FONT_L size:[UIFont systemFontSize]+0];
}

-(BOOL)isProgressiveTabBar{
    return self.isProgressive;
}

#pragma mark - Tab Pager Delegate

- (void)tabPager:(KHTabPagerViewController *)tabPager willTransitionToTabAtIndex:(NSInteger)index {
    NSLog(@"Will transition from tab %ld to %ld", [self selectedIndex], (long)index);
    
//    UnivNoticeBoardObject *obj = (UnivNoticeBoardObject *) [self.noticeBoardObjList objectAtIndex:index];
//    self.title = obj.notice_name;
}

- (void)tabPager:(KHTabPagerViewController *)tabPager didTransitionToTabAtIndex:(NSInteger)index {
    NSLog(@"Did transition to tab %ld", (long)index);
}



@end
