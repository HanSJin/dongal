//
//  Customs.m
//  twenty
//
//  Created by 한승진 on 2015. 8. 29..
//  Copyright (c) 2015년 Twenty. All rights reserved.
//

#import "Customs.h"
#import "Constants.h"
#import "UIImageView+WebCache.h"

@implementation Customs






/*
    View
 */
+ (UIView *)CSViewRect:(CGRect)rect
             backColor:(UIColor *)backColor {
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = backColor;
    
    return view;
}






/*
    UILabel
 */
+ (UILabel *)CSLabelText:(NSString *)text
               LabelRect:(CGRect)labelRect
               textAlign:(NSString *)align
                textFont:(NSString *)font
                textSize:(double)size
               textColor:(UIColor *)textColor
               backColor:(UIColor *)backColor {
    
    UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
    label.text = text;
    label.font = [UIFont fontWithName:font size:[UIFont systemFontSize]+size];
    label.textColor = textColor;
    label.backgroundColor = backColor;
    
    if ([align isEqualToString:@"center"])
        label.textAlignment = UITextAlignmentCenter;
    else if ([align isEqualToString:@"left"])
        label.textAlignment = UITextAlignmentLeft;
    else if ([align isEqualToString:@"right"])
        label.textAlignment = UITextAlignmentRight;
    
    
    return label;
}






/*
    UIButton
 */
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
                     align:(NSString *)align{
    
    UIButton *btn = [[UIButton alloc] initWithFrame:buttonRect];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setFont:[UIFont fontWithName:font size:[UIFont systemFontSize]+size]];
    [btn setBackgroundColor:backColor];
    btn.layer.borderWidth = borderWidth;
    btn.layer.borderColor = borderColor.CGColor;
    btn.layer.cornerRadius = cornerRadius;
    
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    if ([align isEqualToString:@"left"])
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    else if ([align isEqualToString:@"center"])
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    else if ([align isEqualToString:@"right"])
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
    return btn;
}








/*
    UITextField
 
    typedef enum {
        UIKeyboardTypeDefault,                // Default type for the current input method.
        UIKeyboardTypeASCIICapable,           // Displays a keyboard which can enter ASCII characters, non-ASCII keyboards remain active
        UIKeyboardTypeNumbersAndPunctuation,  // Numbers and assorted punctuation.
        UIKeyboardTypeURL,                    // A type optimized for URL entry (shows . / .com prominently).
        UIKeyboardTypeNumberPad,              // A number pad (0-9). Suitable for PIN entry.
        UIKeyboardTypePhonePad,               // A phone pad (1-9, *, 0, #, with letters under the numbers).
        UIKeyboardTypeNamePhonePad,           // A type optimized for entering a person's name or phone number.
        UIKeyboardTypeEmailAddress,           // A type optimized for multiple email address entry (shows space @ . prominently).
        UIKeyboardTypeDecimalPad,             // A number pad including a decimal point
        UIKeyboardTypeTwitter,                // Optimized for entering Twitter messages (shows # and @)
        UIKeyboardTypeWebSearch,              // Optimized for URL and search term entry (shows space and .)
    
        UIKeyboardTypeAlphabet = UIKeyboardTypeASCIICapable, // Deprecated
    } UIKeyboardType;
 
    [textField setKeyboardType:UIKeyboardTypeDefault];
 
 */
+ (UITextField *)CSTextFieldText:(NSString *)placehole
                          TFRect:(CGRect)rect
                        textFont:(NSString *)font
                        textSize:(double)size
                      returnType:(NSString *)type
                       clearMode:(BOOL)clearMode
                        isSecure:(BOOL)isSecure {
    
    UITextField *tf = [[UITextField alloc] initWithFrame:rect];
    tf.placeholder = placehole;
    tf.font = [UIFont fontWithName:font size:[UIFont systemFontSize]+size];
    if ([type isEqualToString:@"Done"])
        tf.returnKeyType = UIReturnKeyDone;
    else if ([type isEqualToString:@"Search"])
        tf.returnKeyType = UIReturnKeySearch;
    
    if (clearMode)
        tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    tf.secureTextEntry = isSecure;
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    return tf;
}






+ (UIImageView *)CSImageViewImg:(UIImage *)img
                 imgPlachHolder:(UIImage *)holder
                        imgRect:(CGRect)rect
                       isCached:(BOOL)isCached
                         imgUrl:(NSString *)imgUrl
                    contentMode:(NSString *)contentMode
                      backColor:(UIColor *)backColor
                         radius:(float)radius
                    borderWidth:(float)borderWidth
                    borderColor:(UIColor *)borderColor {
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:rect];
    
    if (isCached)
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:holder];
    else
        [imgView setImage:img];
    
    if ([contentMode isEqualToString:@"AspectFill"])
        imgView.contentMode = UIViewContentModeScaleAspectFill;
    else if ([contentMode isEqualToString:@"AspectFit"])
        imgView.contentMode = UIViewContentModeScaleAspectFit;
    else if ([contentMode isEqualToString:@"ToFill"])
        imgView.contentMode = UIViewContentModeScaleToFill;
    
    imgView.layer.backgroundColor = backColor.CGColor;
    imgView.layer.cornerRadius = radius;
    imgView.layer.borderColor = borderColor.CGColor;
    imgView.layer.borderWidth = borderWidth;
    imgView.layer.masksToBounds = YES;
    
    return imgView;
}







// 16진수로부터 color 구하기
+ (UIColor *)colorFromHexString:(NSString *)hexString {
    NSString *colorCode = [NSString stringWithFormat:@"%@",hexString];
    if (colorCode == nil || [colorCode isEqualToString:@"<null>"] || [colorCode length]==0)
        return [UIColor clearColor];
    
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:colorCode];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}





+ (NSString *)getMonthFromString:(NSString *)month; {
    if ([month isEqualToString:@"01"])
        return @"Jan";
    if ([month isEqualToString:@"02"])
        return @"Feb";
    if ([month isEqualToString:@"03"])
        return @"Mar";
    if ([month isEqualToString:@"04"])
        return @"Apr";
    if ([month isEqualToString:@"05"])
        return @"May";
    if ([month isEqualToString:@"06"])
        return @"Jun";
    if ([month isEqualToString:@"07"])
        return @"Jul";
    if ([month isEqualToString:@"08"])
        return @"Aug";
    if ([month isEqualToString:@"09"])
        return @"Sep";
    if ([month isEqualToString:@"10"])
        return @"Oct";
    if ([month isEqualToString:@"11"])
        return @"Nov";
    if ([month isEqualToString:@"12"])
        return @"Dec";
    else
        return @"";
}

+ (float) getFontSizeFromDevice:(float)fontSize {
    float size;
    if (IS_IPHONE_6P) {
        size = 4.5 * fontSize;
    } else if (IS_IPHONE_6) {
        size = 4.3 * fontSize;
    } else if (IS_IPHONE_5) {
        size = 3.7 * fontSize;
    } else if (IS_IPHONE_4_OR_LESS) {
        size = 3.7 * fontSize;
    }
    return size;
}



// 스케일 조정
+ (UIImage *)getNewImage:(UIImage *)image newSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
