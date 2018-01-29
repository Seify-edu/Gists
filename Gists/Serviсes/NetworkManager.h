//
//  NetworkManager.h
//  Gists
//
//  Created by Roman S on 28/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NetworkManager : AFHTTPSessionManager
+ (NetworkManager *)shared;
- (NSURLSessionDataTask *)dataTaskWithString:(NSString *)requestString completionHandler:(void (^)(NSURLResponse *response, id responseObject, NSError *error))completionHandler;
@end
