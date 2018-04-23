//
//  FMTabBarController.m
//  LocalizeApp
//
//  Created by Subo on 2018/3/15.
//  Copyright © 2018年 Followme. All rights reserved.
//

#import "FMTabBarController.h"
#import "FMWeChatController.h"
#import "FMContactController.h"
#import "FMDiscoverController.h"
#import "FMMeController.h"
#import "UIColor+FMAddtions.h"


@interface FMTabBarController ()

@end

@implementation FMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpViewControllers];
    [self setupTheme];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpViewControllers {
    FMWeChatController *wechatController = [[FMWeChatController alloc] init];
    UINavigationController *weChatNavController = [[UINavigationController alloc] initWithRootViewController:wechatController];
    weChatNavController.tabBarItem.image = [[UIImage imageNamed:@"tabbar_wechat_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    weChatNavController.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_wechat_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    weChatNavController.tabBarItem.title = NSLocalizedString(@"Chats", nil);
    wechatController.navigationItem.title = NSLocalizedString(@"WeChat", nil);
    
    FMContactController *contactController = [[FMContactController alloc] init];
    contactController.title = NSLocalizedString(@"Contacts", nil);
    UINavigationController *contactNavController = [[UINavigationController alloc] initWithRootViewController:contactController];
    contactNavController.tabBarItem.image = [[UIImage imageNamed:@"tabbar_contacts_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    contactNavController.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_contacts_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    FMDiscoverController *discoverController = [[FMDiscoverController alloc] init];
    discoverController.title = NSLocalizedString(@"Discover", nil);
    UINavigationController *discoverNavController = [[UINavigationController alloc] initWithRootViewController:discoverController];
    discoverNavController.tabBarItem.image = [[UIImage imageNamed:@"tabbar_discover_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    discoverNavController.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_discover_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    FMMeController *meController = [[FMMeController alloc] init];
    meController.title = NSLocalizedString(@"Me", nil);
    UINavigationController *meNavController = [[UINavigationController alloc] initWithRootViewController:meController];
    meNavController.tabBarItem.image = [[UIImage imageNamed:@"tabbar_me_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    meNavController.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_me_select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self setViewControllers:@[weChatNavController, contactNavController, discoverNavController, meNavController]];
}

- (void)setupTheme {
    NSDictionary *selectedAttributes = @{ NSForegroundColorAttributeName : FMColorWithHex(@"2BB730")};
    [[UITabBarItem appearance] setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
    [[UINavigationBar appearance] setBarTintColor:FMColorWithRGB(0.1, 0.1, 0.1, 0.9)];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

@end
