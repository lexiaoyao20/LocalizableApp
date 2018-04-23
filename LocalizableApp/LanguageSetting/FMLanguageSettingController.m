//
//  FMLanguageSettingController.m
//  Followme
//
//  Created by Subo on 2018/4/3.
//  Copyright © 2018年 com.followme. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>
#import "FMLanguageSettingController.h"
#import "FMLanguageBundle.h"
#import "UIColor+FMAddtions.h"

@interface FMLanguageCell : UITableViewCell

@end

@implementation FMLanguageCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    UITableViewCellAccessoryType type = selected ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.accessoryType = type;
        }];
    }else {
        self.accessoryType = type;
    }
}

@end


@interface FMLanguageSettingController ()

@property(nonatomic, strong) NSArray<FMLanguageModel *> *languages;
@property(nonatomic, strong) FMLanguageModel *currentLanguage;
@property(nonatomic, strong) UIBarButtonItem *doneItem;

@end

@implementation FMLanguageSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Setting Language", nil);
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.0];
    
    [self.tableView registerClass:[FMLanguageCell class] forCellReuseIdentifier:@"FMLanguageCell"];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.rowHeight = 44;
    self.tableView.tableFooterView = [UIView new];
    
    [self setupNavigationBar];
    [self setupDataSource];
    [self selectCurrentLanguage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupDataSource {
    self.languages = [FMLanguageBundle supportedLanguages];
    [self.tableView reloadData];
}

- (void)selectCurrentLanguage {
    NSInteger index = NSNotFound;
    FMLanguageModel *currentLanguage = [FMLanguageBundle currentLanguage];
    for(NSInteger i = 0; i < self.languages.count; i++) {
        FMLanguageModel *language = self.languages[i];
        if ([language.languageKey isEqualToString:currentLanguage.languageKey]) {
            index = i;
            self.currentLanguage = language;
            break;
        }
    }
    
    if (index != NSNotFound) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        });
    }
}


#pragma mark - UITableView DataSource & Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.languages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMLanguageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FMLanguageCell" forIndexPath:indexPath];

    FMLanguageModel *language = self.languages[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = language.languageName;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FMLanguageModel *language = self.languages[indexPath.row];
    FMLanguageModel *currentLanguage = [FMLanguageBundle currentLanguage];
    if (![language.languageKey isEqualToString:currentLanguage.languageKey]) {
        self.doneItem.enabled = YES;
    }else {
        self.doneItem.enabled = NO;
    }
    self.currentLanguage = language;
}

#pragma mark - Actions

- (void)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)done:(id)sender {
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Setting...", nil)];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [FMLanguageBundle switchLanguage:self.currentLanguage completion:^{
            [SVProgressHUD dismiss];
        }];
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}

#pragma mark - UI

- (void)setupNavigationBar {
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(0, 0, 44, 44);
    [cancelButton setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    self.navigationItem.leftBarButtonItem = cancelItem;
    
    UIColor *titleColor = FMColorWithHex(@"2BB730");
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    doneButton.frame = CGRectMake(0, 0, 44, 44);
    [doneButton setTitle:NSLocalizedString(@"Done", nil) forState:UIControlStateNormal];
    [doneButton setTitleColor:titleColor forState:UIControlStateNormal];
    [doneButton setTitleColor:[titleColor colorWithAlphaComponent:0.5] forState:UIControlStateDisabled];
    doneButton.titleLabel.font = [UIFont systemFontOfSize:16];
    doneButton.enabled = NO;
    [doneButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    self.navigationItem.rightBarButtonItem = doneItem;
    
    doneItem.enabled = NO;
    self.doneItem = doneItem;
}

@end
