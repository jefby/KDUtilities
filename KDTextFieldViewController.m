//
//  BBSingleTextFieldViewController.m
//  BuddyBook
//
//  Created by Blankwonder on 9/22/13.
//  Copyright (c) 2013 Suixing Tech. All rights reserved.
//

#import "KDTextFieldViewController.h"

@interface KDTextFieldViewController () <UITextFieldDelegate> {
    UITableViewCell *_cell;
}

@end

@implementation KDTextFieldViewController

- (instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsSelection = NO;

    _cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    self.tableView.rowHeight = 44;

    const CGFloat xInset = 20, yInset = 11;
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(xInset, yInset, self.tableView.frame.size.width - xInset * 2.0f, self.tableView.rowHeight - yInset * 2.0f)];
    textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    _textField = textField;
    [_cell addSubview:textField];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];

    if (self.configureBlock) {
        self.configureBlock(textField, self.tableView);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self done];
    return YES;
}

- (void)done {
    if (self.completionBlock) {
        self.completionBlock(_textField.text);
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.textField resignFirstResponder];
}

- (void)dismissViewControllerAnimated {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return self.footerText;
}

@end

@implementation UIViewController (KDSingleTextFieldViewController)

- (void)KD_presentTextFieldViewControllerWithTitle:(NSString *)title
                                        footerText:(NSString *)footerText
                                    configureBlock:(void(^)(UITextField *textField, UITableView *tableView))configureBlock
                                   completionBlock:(void(^)(NSString *text))completionBlock {
    KDTextFieldViewController *vc = [[KDTextFieldViewController alloc] init];
    [vc setConfigureBlock:configureBlock];
    vc.title = title;
    vc.footerText = footerText;
    
    if ([self isKindOfClass:[UINavigationController class]]) {
        [vc setCompletionBlock:^(NSString *str) {
            if (completionBlock) {
                completionBlock(str);
            }
            
            [(UINavigationController *)self popViewControllerAnimated:YES];
        }];
    } else {
        [vc setCompletionBlock:^(NSString *str) {
            if (completionBlock) {
                completionBlock(str);
            }
            
            [self dismissViewControllerAnimated:YES completion:^{}];
        }];
        
        vc.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:vc action:@selector(dismissViewControllerAnimated)];

        UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nvc animated:YES completion:^{}];
    }
}



@end
