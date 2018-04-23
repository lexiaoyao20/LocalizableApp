//
//  UIColor+FMAddtions.h
//  FMEmojiKeyBoard
//
//  Created by Subo on 16/3/7.
//  Copyright © 2016年 Followme. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FMColorWithHex(hexStr) [UIColor fm_colorWithHexString:hexStr]

//r,g,b,a的值范围为0 ~ 1
#define FMColorWithRGB(r,g,b,a) [UIColor colorWithRed:r green:g blue:b alpha:a]
//r,g,b的值范围为0 ~ 255
#define FMColorWithRGB255(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0f]

@interface UIColor (FMAddtions)

+ (instancetype)fm_colorWithHexString:(NSString *)hexStr;

@end
