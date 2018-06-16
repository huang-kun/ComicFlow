//
//  ImageBrowserViewController.m
//  ComicFlow
//
//  Created by huangkun on 2018/6/16.
//  Copyright © 2018年 vipkid. All rights reserved.
//

#import "ImageBrowserViewController.h"
#import "CMFetcher.h"

@interface ImageBrowserViewController () <MWPhotoBrowserDelegate>
@property (nonatomic, strong) NSArray <MWPhoto *> *photos;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *refresher;
@end

@implementation ImageBrowserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;
    self.refresher.hidden = YES;
    [self fetchImages];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setImageUrls:(NSArray <NSString *> *)urls {
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:urls.count];
    for (NSString *url in urls) {
        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:url]];
        [photos addObject:photo];
    }
    self.photos = photos;
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    return self.photos[index];
}

- (void)fetchImages {
    if (!self.comic || !self.chapter) {
        return;
    }
    
    self.refresher.hidden = NO;
    [self.refresher startAnimating];
    
    [CMFetcher.shared fetchImageUrlsForComic:self.comic chapter:self.chapter idx:0 size:0 completion:^(NSArray<NSString *> *imageUrls, NSError *error) {
        [self.refresher stopAnimating];
        [self setImageUrls:imageUrls];
        [self reloadData];
    }];
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
