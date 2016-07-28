//
//  KDAlertView.h
//  KDBlockAlert
//
//  Created by Blankwonder on 11/20/12.
//

#import <Foundation/Foundation.h>

#if TARGET_OS_IOS
#import <UIKit/UIKit.h>
#endif

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

@interface KDAlertView : NSObject

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
            cancelButtonTitle:(NSString *)cancelButtonTitle
                  cancelAction:(void ( ^)(KDAlertView *alertView))cancelAction;

- (void)addButtonWithTitle:(NSString *)title action:(void ( ^)(KDAlertView *alertView))action;
- (void)show;

#if TARGET_OS_IOS
- (UIAlertView *)systemAlertView;
#endif

+ (void)showMessage:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle;
+ (void)showErrorMessage:(NSString *)message;

+ (KDAlertView *)presentingAlertView;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;

@end

#pragma clang diagnostic pop
