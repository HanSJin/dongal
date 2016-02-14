//
//  NoticeCell.m
//  Dongal
//
//  Created by 한승진 on 2016. 2. 3..
//  Copyright © 2016년 com.twentyApps. All rights reserved.
//

#import "NoticeCell.h"

@implementation NoticeCell

- (void)awakeFromNib:(NoticeVC *)tableVC object:(NoticeObj *)obj indexPath:(NSIndexPath *)indexPath {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    UIView *circleView = [Customs CSViewRect:CGRectMake(16, 16, 50, 50) backColor:obj.board_color];
//    circleView.layer.cornerRadius = 25;
//    [self addSubview:circleView];
//    [circleView setAlpha:0.5f];
    
    
    UIImageView *circleImage = [Customs CSImageViewImg:[UIImage imageNamed:@"circle"] imgPlachHolder:nil imgRect:CGRectMake(16, 16, 50, 50) isCached:NO imgUrl:@"" contentMode:@"AspectFill" backColor:CLEAR_COLOR radius:0 borderWidth:0 borderColor:CLEAR_COLOR];
    [self addSubview:circleImage];
    
    
    
    UILabel *tableTitme = [Customs CSLabelText:[NSString stringWithFormat:@"%@", obj.board_title]
                                     LabelRect:circleImage.frame textAlign:@"center"
                                      textFont:FONT_L textSize:0 textColor:DONGGUK_COLOR_L backColor:CLEAR_COLOR];
    
    [self addSubview:tableTitme];
    
    float leftMargin = 80;
    UILabel *writer = [Customs CSLabelText:[NSString stringWithFormat:@"%@", obj.wr_writer]
                                 LabelRect:CGRectMake(leftMargin, 16, SCR_WIDTH-leftMargin-16, 20) textAlign:@"left"
                                  textFont:FONT_L textSize:-3 textColor:GRAY_COLOR backColor:CLEAR_COLOR];
    [self addSubview:writer];
    UILabel *title = [Customs CSLabelText:[NSString stringWithFormat:@"%@", obj.wr_title]
                                LabelRect:CGRectMake(leftMargin, 36, SCR_WIDTH-leftMargin-16, 0) textAlign:@"left"
                                 textFont:FONT_L textSize:-1 textColor:BLACK_COLOR backColor:CLEAR_COLOR];
    title.numberOfLines = 2;
    [title sizeToFit];
    [self addSubview:title];
    UILabel *view = [Customs CSLabelText:[NSString stringWithFormat:@"조회수 %@ [%@]", obj.wr_hit, obj.wr_created_on]
                               LabelRect:CGRectMake(leftMargin, title.frame.size.height+40, SCR_WIDTH-leftMargin-16, 20) textAlign:@"left"
                                textFont:FONT_L textSize:-3 textColor:GRAY_COLOR backColor:CLEAR_COLOR];
    [self addSubview:view];
    
    
    
    
    UIView *lineView = [Customs CSViewRect:CGRectMake(leftMargin, 99, SCR_WIDTH-leftMargin, 0.8f) backColor:LIGHT_GRAY_COLOR];
    [self addSubview:lineView];
    
    
    UIButton *likeButton = [Customs CSButtonText:@"" buttonRect:CGRectMake(SCR_WIDTH-50, 53, 50, 50) textFont:FONT_L textSize:0 image:[UIImage imageNamed:@""] textColor:CLEAR_COLOR backColor:CLEAR_COLOR borderWidth:0 borderColor:CLEAR_COLOR cornerRadius:0 align:@"center"];
    UIImage *image = [[UIImage imageNamed:@"ic_stars"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    
    [likeButton setImage:image forState:UIControlStateNormal];
    [likeButton setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    [likeButton setTag:indexPath.row];
    
    if ([obj.is_like isEqualToString:@"1"])
        likeButton.tintColor = DONGGUK_COLOR;
    else
        likeButton.tintColor = GRAY_COLOR;
    
    [likeButton addTarget:tableVC action:@selector(likeButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:likeButton];

    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
