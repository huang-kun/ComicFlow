//
//  UIViewController+Alert.m
//  ComicFlow
//
//  Created by huangkun on 2018/6/16.
//  Copyright © 2018年 vipkid. All rights reserved.
//

#import "UIViewController+Alert.h"

@implementation UIViewController (Alert)

- (void)alertError:(NSError *)error {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Error" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [controller dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [controller addAction:cancel];
    
    [self presentViewController:controller animated:YES completion:nil];
}

@end
