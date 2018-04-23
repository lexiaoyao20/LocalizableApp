//
//  FMLanguageBundle.h
//  Followme
//
//  Created by Subo on 2018/4/4.
//  Copyright © 2018年 com.followme. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMLanguageModel : NSObject

@property(nonatomic, copy) NSString *languageKey;
@property(nonatomic, copy) NSString *languageName;

- (instancetype)initWithKey:(NSString *)key name:(NSString *)name;

@end

@interface FMLanguageBundle : NSBundle

/**
 设置默认语言
 */
+ (void)setDefaultLanguage;

+ (FMLanguageModel *)currentLanguage;

/**
 当前所支持的语言
 
 @return 返回支持的语言列表
 */
+ (NSArray<FMLanguageModel *> *)supportedLanguages;

/**
 切换语言
 
 @param language 语言Model
 */
+ (void)switchLanguage:(FMLanguageModel *)language completion:(void (^)(void))completion;

+ (FMLanguageModel *)findLanguageWithKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
