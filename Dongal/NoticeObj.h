//
//  NoticeObj.h
//  Dongal
//
//  Created by 한승진 on 2016. 2. 3..
//  Copyright © 2016년 com.twentyApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NoticeObj : NSObject

@property (nonatomic, strong) NSString *wr_id;
@property (nonatomic, strong) NSString *wr_title;
@property (nonatomic, strong) NSString *wr_link;
@property (nonatomic, strong) NSString *wr_writer;
@property (nonatomic, strong) NSString *wr_hit;
@property (nonatomic, strong) NSString *wr_created_on;
@property (nonatomic, strong) NSString *board_title;
@property (nonatomic, strong) NSString *board_name;
@property (nonatomic) UIColor *board_color;
@property (nonatomic, strong) NSString *is_like;

- (instancetype)initWithDictionary:(NSMutableDictionary *)dic;

@end
