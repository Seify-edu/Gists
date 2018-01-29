//
//  NetworkManager.m
//  Gists
//
//  Created by Roman S on 28/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import "NetworkManager.h"

@interface NetworkManager()
@property NSString *urlPrefix;
@end

@implementation NetworkManager

static NetworkManager *sharedManager = nil;

+ (NetworkManager *)shared
{
    if (sharedManager == nil) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sharedManager = [[NetworkManager alloc] initWithSessionConfiguration:configuration];
        sharedManager.urlPrefix = @"https://api.github.com";
    }
    
    return sharedManager;
}

- (NSURLSessionDataTask *)dataTaskWithString:(NSString *)requestString
                            completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler
{
    NSString *urlString = [self.urlPrefix stringByAppendingString:requestString];
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];

    NSURLSessionDataTask *dataTask = [self dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:completionHandler];
    [dataTask resume];
    return dataTask;
}

@end
