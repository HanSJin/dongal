//
//  CollegeObj.m
//  Dongal
//
//  Created by 한승진 on 2016. 2. 3..
//  Copyright © 2016년 com.twentyApps. All rights reserved.
//

#import "CollegeObj.h"

@implementation CollegeObj

- (instancetype)initWithDictionary:(NSMutableDictionary *)dic {
    self = [super init];
    if (self) {
        self.college_id = [NSString stringWithFormat:@"%@", [dic objectForKey:@"board_id"]];
        self.college_name = [NSString stringWithFormat:@"%@", [dic objectForKey:@"board_name"]];
        self.college_title = [NSString stringWithFormat:@"%@", [dic objectForKey:@"board_title"]];
    }
    return self;
}

@end
