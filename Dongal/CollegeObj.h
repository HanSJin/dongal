//
//  CollegeObj.h
//  Dongal
//
//  Created by 한승진 on 2016. 2. 3..
//  Copyright © 2016년 com.twentyApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollegeObj : NSObject

@property (nonatomic, strong) NSString *college_id;
@property (nonatomic, strong) NSString *college_title;
@property (nonatomic, strong) NSString *college_name;

- (instancetype)initWithDictionary:(NSMutableDictionary *)dic;
@end
