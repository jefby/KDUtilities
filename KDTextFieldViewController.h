//
//  BBSingleTextFieldViewController.h
//  BuddyBook
//
//  Created by Blankwonder on 9/22/13.
//  Copyright (c) 2013 Suixing Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KDTextFieldViewController : UITableViewController {
}

- (instancetype)init;

@property (nonatomic, readonly) UITextField *textField;
@property (nonatomic, copy) NSString *footerText;

@property (nonatomic, copy) void(^configureBlock)(UITextField *textField, UITableView *tableView);
@property (nonatomic, copy) void(^completionBlock)(NSString *text);

@end

@interface UIViewController (KDSingleTextFieldViewController)

- (void)KD_presentTextFieldViewControllerWithTitle:(NSString *)title
                                        footerText:(NSString *)footerText
                                    configureBlock:(void(^)(UITextField *textField, UITableView *tableView))configureBlock
                                   completionBlock:(void(^)(NSString *text))completionBlock;

@end
