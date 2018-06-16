//
//  ImageBrowserViewController.h
//  ComicFlow
//
//  Created by huangkun on 2018/6/16.
//  Copyright © 2018年 vipkid. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MWPhotoBrowser/MWPhotoBrowser.h>

@interface ImageBrowserViewController : MWPhotoBrowser

@property (nonatomic, strong) NSString *comic;
@property (nonatomic, strong) NSString *chapter;

@end
