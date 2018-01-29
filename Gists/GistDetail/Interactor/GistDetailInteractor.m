//
//  GistDetailInteractor.m
//  Gists
//
//  Created by Roman S on 28/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import "GistDetailInteractor.h"
#import "GistDetailPresenter.h"
#import "NetworkManager.h"

@interface GistDetailInteractor()<GistDetailPresenterToInteractorOutput>
@end

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

- (void)loadCommitsForGistID:(NSString *)gistID {
    NSString *urlString = [NSString stringWithFormat:@"/gists/%@/commits", gistID];
    [[NetworkManager shared] dataTaskWithString:urlString completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            [self.presenter didFailLoadGistsCommitsWithError:error];
        }
        else if ( [responseObject isKindOfClass:[NSArray class]] ) {
            NSArray<GistDetailCommit *> *commits = [self gistCommitsFromResponse:responseObject];
            [self.presenter didLoadGistCommits:commits];
        } else {
            [self.presenter didFailLoadGistsCommitsWithError:[NSError errorWithDomain:@"Unexpected response" code:200 userInfo:@{NSLocalizedDescriptionKey: @"responseObject is not an array"}]];
        }
    }];
};

- (NSArray<GistDetailCommit *> *)gistCommitsFromResponse:(NSArray *)response {
    
    NSMutableArray *commits = [NSMutableArray array];
    for ( NSDictionary *commitDict in response ) {
        GistDetailCommit *commit = [self commitFromDict:commitDict];
        [commits addObject:commit];
    }
    return commits;
}

- (GistDetailCommit *)commitFromDict:(NSDictionary *)commitDict {
    GistDetailCommit *commit = [GistDetailCommit new];
    commit.name = [commitDict[@"version"] isKindOfClass:[NSString class]] ? commitDict[@"version"] : @"unknown version";
    id changeStatus = commitDict[@"change_status"];
    if ( [changeStatus isKindOfClass:[NSDictionary class]] ) {
        commit.stringsAdded = [changeStatus[@"additions"] isKindOfClass:[NSNumber class]] ? [changeStatus[@"additions"] stringValue] : @"?";
        commit.stringsAdded = [@"+" stringByAppendingString:commit.stringsAdded];
        commit.stringsDeleted = [changeStatus[@"deletions"] isKindOfClass:[NSNumber class]] ? [changeStatus[@"deletions"] stringValue] : @"?";
        commit.stringsDeleted = [@"-" stringByAppendingString:commit.stringsDeleted];
    } else {
        commit.stringsAdded = @"?";
        commit.stringsDeleted = @"?";
    }
    return commit;
}

@end
