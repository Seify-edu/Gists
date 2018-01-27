//
//  GistListDataLoader.m
//  Gists
//
//  Created by Roman S on 27/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import "GistListInteractor.h"
#import "AFNetworking.h"

@implementation GistListInteractor

- (void)loadGistsList {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"https://api.github.com/gists/public"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            [self.presenter didFailLoadGistsWithError:error];
        } else {
            NSArray<GistListElement *> *elements = [self gistListElementsFromResponse:responseObject];
            [self.presenter didLoadGists:elements];
        }
    }];
    [dataTask resume];
};

- (NSArray<GistListElement *> *)gistListElementsFromResponse:(NSArray *)response
{
    NSMutableArray *elements = [NSMutableArray array];
    for (NSDictionary *elementDict in response) {
        GistListElement *element = [self elementFromDict:elementDict];
        [elements addObject:element];
    }
    return elements;
}

- (GistListElement *)elementFromDict:(NSDictionary *)elementDict
{
    GistListElement *element = [GistListElement new];
    
    element.gistID = [elementDict[@"id"] isKindOfClass:[NSString class]] ? elementDict[@"id"] : @"";
    
    id owner = elementDict[@"owner"];
    if ([owner isKindOfClass:[NSDictionary class]]) {
        element.userName = [owner[@"login"] isKindOfClass:[NSString class]] ? owner[@"login"] : @"anonymous";
        element.pathToImage = [owner[@"avatar_url"] isKindOfClass:[NSString class]] ? owner[@"avatar_url"] : @"";
    } else {
        element.userName = @"anonymous user";
        element.pathToImage = @"";
    }
    
    if ( [elementDict[@"description"] isKindOfClass:[NSString class]] && [elementDict[@"description"] length] > 0 ) {
        element.gistName = elementDict[@"description"];
    } else if ( [elementDict[@"id"] isKindOfClass:[NSString class]] && [elementDict[@"id"] length] > 0 ) {
        element.gistName = elementDict[@"id"];
    } else {
        element.gistName = elementDict[@"unknown name"];
    }
    
    return element;
}

@end
