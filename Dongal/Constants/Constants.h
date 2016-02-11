//
//  Customs.m
//  twenty
//
//  Created by 한승진 on 2015. 8. 29..
//  Copyright (c) 2015년 Twenty. All rights reserved.
//


// DOMAIN
//#define TWENTY_DOMAIN                   @"http://1.255.54.157"
#define DONGAL_DOMAIN                   @"http://14.63.227.27"
//http:/.20s.kr/editor?mb_no=1


// API
#define CONNECT_TEST                    @"/test"

#define CONNECT_GET_NOTICE              @"/notice.php?"
#define CONNECT_GET_NOTICE_LIKE         @"/notice_like.php?"
#define CONNECT_GET_NOTICE_SEARCH       @"/notice_search.php?"
#define CONNECT_GET_COLLEGE             @"/college.php?"
#define CONNECT_GET_ALARM               @"/alarm.php?"
#define CONNECT_GET_MB_COLLEGE          @"/mb_college.php?"
#define CONNECT_GET_MB_ALARM            @"/mb_alarm.php?"
#define CONNECT_GET_KEYWORD             @"/keyword.php?"
#define CONNECT_GET_KEYWORD_STATE       @"/keyword_state.php?"

#define CONNECT_POST_LOGIN              @"/login.php"
#define CONNECT_POST_LIKE               @"/like.php"
#define CONNECT_POST_COLLEGE_UPDATE     @"/college_update.php"
#define CONNECT_POST_MB_COLLEGE         @"/mb_college.php"
#define CONNECT_POST_MB_ALARM           @"/mb_alarm.php"
#define CONNECT_POST_KEYWORD            @"/keyword.php"
#define CONNECT_POST_KEYWORD_STATE      @"/keyword_state.php"



// HOT SPOT
#define IS_HOT_SPOT             ([[UIApplication sharedApplication] statusBarFrame].size.height-20)


// SCREEN
#define SCR_WIDTH               [[UIScreen mainScreen] bounds].size.width
#define SCR_HEIGHT              [[UIScreen mainScreen] bounds].size.height
#define SCR_TAB                 49
//#define SCR_WIDTH               CGRectGetMaxX([[UIScreen mainScreen] bounds])
//#define SCR_HEIGHT              CGRectGetMaxY([[UIScreen mainScreen] bounds])


// COLOR
#define WHITE_COLOR             [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0  alpha:1.0]
#define BLACK_COLOR             [UIColor colorWithRed:0/255.0   green:0/255.0   blue:0/255.0    alpha:1.0]
#define MINT_COLOR              [UIColor colorWithRed:35/255.0  green:186/255.0 blue:197/255.0  alpha:1.0]
#define GRAY_COLOR              [UIColor colorWithRed:166/255.0 green:166/255.0 blue:166/255.0  alpha:1.0]
#define DARK_GRAY_COLOR         [UIColor colorWithRed:194/255.0 green:194/255.0 blue:194/255.0  alpha:1.0]
#define LIGHT_GRAY_COLOR        [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0  alpha:1.0]
#define ULTRA_GRAY_COLOR        [UIColor colorWithRed:249/255.0 green:247/255.0 blue:247/255.0  alpha:1.0]

#define SEMI_BLACK_COLOR        [UIColor colorWithRed:90/255.0  green:90/255.0  blue:90/255.0   alpha:1.0]
#define SEMI_BLUE_COLOR         [UIColor colorWithRed:47/255.0  green:130/255.0 blue:248/255.0  alpha:1.0]
#define SEMI_RED_COLOR          [UIColor colorWithRed:251/255.0 green:84/255.0  blue:39/255.0   alpha:1.0]
#define GREENT_COLOR            [UIColor colorWithRed:26/255.0  green:198/255.0 blue:131/255.0  alpha:1.0]

#define CLEAR_COLOR             [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0  alpha:0.0]


// COLOR - FONT
#define C_FONT_BLACK            [UIColor colorWithRed:0.2   green:0.2   blue:0.2    alpha:1]
#define C_FONT_SOFT_BLACK       [UIColor colorWithRed:0.27  green:0.27  blue:0.27   alpha:1]

// NAVI - FONT COLOR
#define N_FONT_BLACK            [UIColor colorWithRed:21/255.0  green:21/255.0  blue:21/255.0   alpha:1.0]



// DETECT IPHONE SIZE
#define IS_IPAD                 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE               (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA               ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH            ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT           ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH       (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH       (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS     (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5             (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6             (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P            (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)




// FONT - HelveticaNeue
//#define FONT_N                  @"HelveticaNeue"
//#define FONT_UL                 @"HelveticaNeue-UltraLight"
#define FONT_L                  @"HelveticaNeue-Light"
//#define FONT_T                  @"HelveticaNeue-Thin"
//#define FONT_M                  @"HelveticaNeue-Medium"
//#define FONT_B                  @"HelveticaNeue-Bold"
//#define FONT_CB                 @"HelveticaNeue-CondensedBold"



// FONT - AppleSDGothicNeo
#define FONT_T                    @"AppleSDGothicNeo-Thin"
#define FONT_L                    @"AppleSDGothicNeo-Light"
#define FONT_R                    @"AppleSDGothicNeo-Regular"
#define FONT_M                    @"AppleSDGothicNeo-Medium"
#define FONT_SB                   @"AppleSDGothicNeo-SemiBold"
#define FONT_B                    @"AppleSDGothicNeo-Bold"

// FONT - 윤고딕
//#define FONT_Y_320              @"YDVYGO32"
//#define FONT_Y_330              @"YDVYGO33"
//#define FONT_Y_320MJ            @"YDVYMjO32"
//#define FONT_Y_330MJ            @"YDVYMjO33"
//
//#define FONT_Y_720              @"YoonGothicPro720"
//#define FONT_Y_730              @"YoonGothicPro730"
//#define FONT_Y_740              @"YoonGothicPro740"
//#define FONT_Y_760              @"YoonGothicPro760"


#define CS_ALERT(title,msg) UIAlertView *alert = [[UIAlertView alloc]initWithTitle:title\
                            message:msg\
                            delegate:self\
                            cancelButtonTitle:nil\
                            otherButtonTitles:@"EXIT", nil];\
                            [alert show];\




