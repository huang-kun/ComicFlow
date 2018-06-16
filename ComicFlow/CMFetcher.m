//
//  CMFetcher.m
//  ComicFlow
//
//  Created by huangkun on 2018/6/16.
//  Copyright © 2018年 vipkid. All rights reserved.
//

#import "CMFetcher.h"
#import <AFNetworking/AFNetworking.h>

@interface CMFetcher()
@property (nonatomic, strong) AFURLSessionManager *manager;
@property (nonatomic, strong) NSString *baseUrl;
@end

@implementation CMFetcher

+ (instancetype)shared {
    static CMFetcher *fetcher = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fetcher = [self new];
    });
    return fetcher;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        self.baseUrl = @"http://api.skywander.cn";
    }
    return self;
}

- (void)fetchComicsWithCompletion:(void(^)(NSArray <NSString *> *comics, NSError *error))completion {
    [self reqPath:@"/v1/comics" completion:^(id data, NSError *error) {
        completion(data, error);
    }];
}

- (void)fetchChaptersForComic:(NSString *)comic completion:(void(^)(NSArray <NSString *> *chapters, NSError *error))completion {
    NSString *path = [NSString stringWithFormat:@"/v1/comics/%@", comic];
    [self reqPath:path completion:^(id data, NSError *error) {
        completion(data, error);
    }];
}

- (void)fetchImageUrlsForComic:(NSString *)comic chapter:(NSString *)chapter idx:(NSInteger)idx size:(NSInteger)size completion:(void(^)(NSArray <NSString *> *imageUrls, NSError *error))completion {
    NSMutableString *path = [NSMutableString stringWithFormat:@"/v1/comics/%@/%@?idx=%@", comic, chapter, @(idx)];
    if (size > 0) {
        [path appendFormat:@"&size=%@", @(size)];
    }
    [self reqPath:path completion:^(id data, NSError *error) {
        completion(data, error);
    }];
}

- (void)reqPath:(NSString *)urlStr completion:(void(^)(id data, NSError *error))completion {
    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", self.baseUrl, urlStr]];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [self.manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            completion(nil, error);
        } else {
            NSAssert([responseObject isKindOfClass:NSArray.class],
                     @"responseObject has unexpected class: %@", responseObject);
            completion(responseObject, nil);
        }
    }];
    [dataTask resume];
}

@end
