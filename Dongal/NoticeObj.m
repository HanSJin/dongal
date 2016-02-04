//
//  NoticeObj.m
//  Dongal
//
//  Created by 한승진 on 2016. 2. 3..
//  Copyright © 2016년 com.twentyApps. All rights reserved.
//

#import "NoticeObj.h"

@implementation NoticeObj

- (instancetype)initWithDictionary:(NSMutableDictionary *)dic {
    self = [super init];
    if (self) {
        self.wr_id = [NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]];
        self.wr_title = [NSString stringWithFormat:@"%@", [dic objectForKey:@"wr_title"]];
        self.wr_link = [NSString stringWithFormat:@"%@", [dic objectForKey:@"wr_link"]];
        self.wr_writer = [NSString stringWithFormat:@"%@", [dic objectForKey:@"wr_writer"]];
        self.wr_hit = [NSString stringWithFormat:@"%@", [dic objectForKey:@"wr_hit"]];
        self.wr_created_on = [NSString stringWithFormat:@"%@", [dic objectForKey:@"wr_created_on"]];
        self.board_title = [NSString stringWithFormat:@"%@", [dic objectForKey:@"board_title"]];
        self.board_name = [NSString stringWithFormat:@"%@", [dic objectForKey:@"board_name"]];
        self.board_color = [self colorWithHexString:[NSString stringWithFormat:@"%@", [dic objectForKey:@"board_color"]]];
        self.is_like = [NSString stringWithFormat:@"%@", [dic objectForKey:@"is_like"]];
    }
    return self;
}

- (UIColor *)colorWithHexString:(NSString *)str {
    const char *cStr = [str cStringUsingEncoding:NSASCIIStringEncoding];
    long x = strtol(cStr+1, NULL, 16);
    return [self colorWithHex:x];
}

- (UIColor *)colorWithHex:(UInt32)col {
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
}
@end
