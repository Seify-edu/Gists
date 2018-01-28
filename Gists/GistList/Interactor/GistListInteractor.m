//
//  GistListDataLoader.m
//  Gists
//
//  Created by Roman S on 27/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import "GistListInteractor.h"
#import "AFNetworking.h"
#import "NetworkManager.h"

@interface GistListInteractor()<GistListPresenterToInteractorOutput>
@property int currentPage;
@property BOOL didLoadLastPage;
@property NSNumber *loadingPage;
@end

@implementation GistListInteractor

- (instancetype)init {
    if ( self = [super init] ) {
        self.currentPage = 1; // gists have 1-based paging
    }
    return self;
}

- (void)loadNextGistsListPage {
    
    if ( self.didLoadLastPage ) {
        return;
    }
    
    if ( [self.loadingPage isEqual:@(self.currentPage)] ) {
        return;
    }
    
    self.loadingPage = @(self.currentPage);
    
    NSString *urlString = [NSString stringWithFormat:@"/gists/public?page=%d", self.currentPage];
    [[NetworkManager shared] dataTaskWithString:urlString completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        self.loadingPage = nil;
        if (error) {
            [self.presenter didFailLoadGistsWithError:error];
        }
        else if ( [responseObject isKindOfClass:[NSArray class]] ) {
            NSArray<GistListElement *> *elements = [self gistListElementsFromResponse:responseObject];
            [self.presenter didLoadGists:elements];
            if (elements.count > 0) {
                self.currentPage++;
            } else {
                self.didLoadLastPage = YES;
            }
        } else {
            [self.presenter didFailLoadGistsWithError:[NSError errorWithDomain:@"Unexpected response" code:200 userInfo:@{NSLocalizedDescriptionKey: @"responseObject is not an array"}]];
        }
    }];
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
