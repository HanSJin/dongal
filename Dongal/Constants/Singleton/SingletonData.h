//
//  SingletonData.h
//  SidebarDemo
//
//  Created by Han on 2015. 7. 15..
//  Copyright (c) 2015년 Appcoda. All rights reserved.
//


#import <Foundation/Foundation.h>



@interface SingletonData : NSObject {
    
}


/*************************************************************************************
 
 *************************************************************************************/
@property (nonatomic) NSString *UUID;

/*************************************************************************************

 *************************************************************************************/
@property (nonatomic) BOOL initValue;



+ (id)sharedManager;
@end



