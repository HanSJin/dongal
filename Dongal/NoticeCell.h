//
//  NoticeCell.h
//  Dongal
//
//  Created by 한승진 on 2016. 2. 3..
//  Copyright © 2016년 com.twentyApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoticeObj.h"
#import "NoticeVC.h"

#import "Constants.h"
#import "Customs.h"
#import "SingletonData.h"
#import "ConnectionFactory.h"

@interface NoticeCell : UITableViewCell

- (void)awakeFromNib:(NoticeVC *)tableVC object:(NoticeObj *)object indexPath:(NSIndexPath *)indexPath;

@end
