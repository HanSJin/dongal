//
//  Customs.h
//  twenty
//
//  Created by 한승진 on 2015. 8. 29..
//  Copyright (c) 2015년 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Customs : NSObject


+ (UIView *)CSViewRect:(CGRect)rect
             backColor:(UIColor *)backColor;


+ (UILabel *)CSLabelText:(NSString *)text
               LabelRect:(CGRect)labelRect
               textAlign:(NSString *)align
                textFont:(NSString *)font
                textSize:(double)size
               textColor:(UIColor *)textColor
               backColor:(UIColor *)backColor;


+ (UIButton *)CSButtonText:(NSString *)text
                buttonRect:(CGRect)buttonRect
                  textFont:(NSString *)font
                  textSize:(double)size
                     image:(UIImage *)image
                 textColor:(UIColor *)textColor
                 backColor:(UIColor *)backColor
               borderWidth:(float)borderWidth
               borderColor:(UIColor *)borderColor
              cornerRadius:(float)cornerRadius
                     align:(NSString *)align;


+ (UITextField *)CSTextFieldText:(NSString *)placehole
                          TFRect:(CGRect)rect
                        textFont:(NSString *)font
                        textSize:(double)size
                      returnType:(NSString *)type
                       clearMode:(BOOL)clearMode
                        isSecure:(BOOL)isSecure;


+ (UIImageView *)CSImageViewImg:(UIImage *)img
                 imgPlachHolder:(UIImage *)holder
                        imgRect:(CGRect)rect
                       isCached:(BOOL)isCached
                         imgUrl:(NSString *)imgUrl
                    contentMode:(NSString *)contentMode
                      backColor:(UIColor *)backColor
                         radius:(float)radius
                    borderWidth:(float)borderWidth
                    borderColor:(UIColor *)borderColor;



+ (UIColor *)colorFromHexString:(NSString *)hexString;



+ (NSString *)getMonthFromString:(NSString *)month;

+ (float)getFontSizeFromDevice:(float)fontSize;

+ (UIImage *)getNewImage:(UIImage *)image newSize:(CGSize)newSize;


@end
