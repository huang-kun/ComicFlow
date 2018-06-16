//
//  CMFetcher.h
//  ComicFlow
//
//  Created by huangkun on 2018/6/16.
//  Copyright © 2018年 vipkid. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CMFetcher : NSObject

+ (instancetype)shared;

- (void)fetchComicsWithCompletion:(void(^)(NSArray <NSString *> *comics, NSError *error))completion;

- (void)fetchChaptersForComic:(NSString *)comic completion:(void(^)(NSArray <NSString *> *chapters, NSError *error))completion;

- (void)fetchImageUrlsForComic:(NSString *)comic chapter:(NSString *)chapter idx:(NSInteger)idx size:(NSInteger)size completion:(void(^)(NSArray <NSString *> *imageUrls, NSError *error))completion;

@end
