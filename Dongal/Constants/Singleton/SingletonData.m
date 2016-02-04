//
//  SingletonData.m
//  SidebarDemo
//
//  Created by Han on 2015. 7. 15..
//  Copyright (c) 2015년 Appcoda. All rights reserved.
//


/*************************************************************************************
 드로어랑 스택뷰의 이동간에 최근에 본 스택뷰 인덱스를 저장하여 인덱스를 다시 활용함
 *************************************************************************************/


#import "SingletonData.h"

@implementation SingletonData

#pragma mark Singleton Methods

+ (id)sharedManager {
    static SingletonData *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        self.UUID = @"editor_uuid_1";
//        self.UUID = @"editor_uuid_1";
    }
    return self;
}


@end



