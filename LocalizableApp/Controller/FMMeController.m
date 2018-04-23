//
//  FMMeController.m
//  LocalizeApp
//
//  Created by Subo on 2018/3/15.
//  Copyright © 2018年 Followme. All rights reserved.
//

#import "FMMeController.h"
#import "FMLanguageSettingController.h"

@interface FMMeController ()

@property (weak, nonatomic) IBOutlet UIButton *settingButton;

@end

@implementation FMMeController

- (instancetype)init {
    if (self = [super initWithNibName:@"FMMeController" bundle:nil]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.settingButton setTitle:NSLocalizedString(@"Settings", nil) forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showSettingController:(id)sender {
    FMLanguageSettingController *settingController = [[FMLanguageSettingController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:settingController];
    [self presentViewController:navController animated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
