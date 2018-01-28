//
//  GistDetailInteractor.m
//  Gists
//
//  Created by Roman S on 28/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import "GistDetailInteractor.h"
#import "NetworkManager.h"

@implementation GistDetailInteractor

- (void)loadContentForGistID:(NSString *)gistID {
    NSString *urlString = [NSString stringWithFormat:@"/gists/%@", gistID];
    [[NetworkManager shared] dataTaskWithString:urlString completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            [self.presenter didFailLoadGistsContentWithError:error];
        }
        else if ( [responseObject isKindOfClass:[NSDictionary class]] ) {
            NSArray<GistDetailFile *> *files = [self gistFilesFromResponse:responseObject];
            [self.presenter didLoadGistContent:files];
        } else {
            [self.presenter didFailLoadGistsContentWithError:[NSError errorWithDomain:@"Unexpected response" code:200 userInfo:@{NSLocalizedDescriptionKey: @"responseObject is not a dictionary"}]];
        }
    }];
};

- (NSArray<GistDetailFile *> *)gistFilesFromResponse:(NSDictionary *)response {
    
    NSDictionary *filesDict = response[@"files"];
    NSMutableArray *files = [NSMutableArray array];
    for ( NSString *fileDictKey in [filesDict allKeys] ) {
        GistDetailFile *file = [GistDetailFile new];
        file.name = fileDictKey;
        file.content = filesDict[fileDictKey][@"content"];
        [files addObject:file];
    }
    return files;

}

@end
