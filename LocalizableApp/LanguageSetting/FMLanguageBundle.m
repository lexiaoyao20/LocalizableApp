//
//  FMLanguageBundle.m
//  Followme
//
//  Created by Subo on 2018/4/4.
//  Copyright © 2018年 com.followme. All rights reserved.
//

#import "FMLanguageBundle.h"
#import "AppDelegate.h"
#import <objc/runtime.h>

#define LANGUAGEBUNDLE ((FMLanguageBundle *)[FMLanguageBundle mainBundle])

static NSString * const kAppLanguageKey = @"FMAppLanguage";

@implementation FMLanguageModel

- (instancetype)initWithKey:(NSString *)key name:(NSString *)name {
    if (self = [super init]) {
        self.languageKey = key;
        self.languageName = name;
    }
    return self;
}

- (NSDictionary *)convertToDictionary {
    NSAssert(self.languageKey != nil, @"languageKey can't be nil.");
    NSAssert(self.languageName != nil, @"languageName can't be nil.");
    
    return @{@"languageKey" : self.languageKey,
             @"languageName" : self.languageName};
}

@end

@interface FMLanguageBundle ()

@property(nonatomic, strong) NSArray<FMLanguageModel *> *supportedLanguages;
@property(nonatomic, strong) FMLanguageModel *currentLanguage;

@end

@implementation FMLanguageBundle

- (NSString *)localizedStringForKey:(NSString *)key value:(NSString *)value table:(NSString *)tableName{
    NSBundle *bundle = [NSBundle mainBundle];
    FMLanguageModel *currentLanguage = [FMLanguageBundle currentLanguage]; // 从存储中取值
    NSString *path = [bundle pathForResource:currentLanguage.languageKey ofType:@"lproj"];
    if (path) {
        return [[NSBundle bundleWithPath:path] localizedStringForKey:key value:value table:tableName];
    } else {
        return [super localizedStringForKey:key value:value table:tableName];
    }
}

+ (NSArray<FMLanguageModel *> *)supportedLanguages {
    return LANGUAGEBUNDLE.supportedLanguages;
}

- (NSArray<FMLanguageModel *> *)supportedLanguages {
    if (!_supportedLanguages) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Languages" ofType:@"plist"];
        NSArray *langugeContent = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray<FMLanguageModel *> *languageList = [NSMutableArray new];
        for(NSDictionary *dict in langugeContent) {
            FMLanguageModel *language = [[FMLanguageModel alloc] init];
            [language setValuesForKeysWithDictionary:dict];
            [languageList addObject:language];
        }
        
        _supportedLanguages = languageList.copy;
    }
    return _supportedLanguages;
}

+ (FMLanguageModel *)findLanguageWithKey:(NSString *)key {
    return [LANGUAGEBUNDLE findLanguageWithKey:key];
}

- (FMLanguageModel *)findLanguageWithKey:(NSString *)key {
    for(FMLanguageModel *language in self.supportedLanguages) {
        if ([language.languageKey isEqualToString:key]) {
            return language;
        }
    }
    
    return nil;
}

+ (void)switchLanguage:(FMLanguageModel *)language completion:(void (^)(void))completion {
    LANGUAGEBUNDLE.currentLanguage = language;
    
    // 重置rootViewController,达到重启app的目的
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate resetRootController];
    
    [[NSUserDefaults standardUserDefaults] setObject:[language convertToDictionary] forKey:kAppLanguageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    !completion ?: completion();
}

+ (void)setDefaultLanguage {
    FMLanguageModel *currentLanguage = [FMLanguageBundle currentLanguage];
    if (currentLanguage) {
        //已经设置过了，就跳过
        return;
    }
    
    NSArray *languages = [[NSBundle mainBundle] preferredLocalizations];
    NSString *languageKey = languages.firstObject;
    
    FMLanguageModel *language = [self findLanguageWithKey:languageKey];
    if (!language) {
        language = LANGUAGEBUNDLE.supportedLanguages.firstObject;
    }
    
    LANGUAGEBUNDLE.currentLanguage = language;
}

+ (FMLanguageModel *)currentLanguage {
    return LANGUAGEBUNDLE.currentLanguage;
}

- (FMLanguageModel *)currentLanguage {
    FMLanguageModel *language = objc_getAssociatedObject(self, @selector(currentLanguage));
    if (!language) {
        NSDictionary *languageDict = [[NSUserDefaults standardUserDefaults] objectForKey:kAppLanguageKey];
        if (!languageDict) {
            return nil;
        }
        
        language = [[FMLanguageModel alloc] init];
        [language setValuesForKeysWithDictionary:languageDict];
    }
    return language;
}

- (void)setCurrentLanguage:(FMLanguageModel *)currentLanguage {
    objc_setAssociatedObject(self, @selector(currentLanguage), currentLanguage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [[NSUserDefaults standardUserDefaults] setObject:[currentLanguage convertToDictionary] forKey:kAppLanguageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
