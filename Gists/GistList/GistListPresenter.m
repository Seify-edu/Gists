//
//  GistListDataSource.m
//  Gists
//
//  Created by Roman S on 27/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import "GistListPresenter.h"

@interface GistListPresenter()<GistListInteractorOutput, GistListViewOutput>
@property NSMutableArray *gists;
@end

@implementation GistListPresenter

- (instancetype)init {
    if ( self = [super init] ) {
        self.gists = [NSMutableArray array];
    }
    return self;
}

#pragma mark - GistListDataLoaderDelegate

- (void)didLoadGists:(NSArray *)gists {
    [self.gists addObjectsFromArray:gists];
    [self.view showData:self.gists];
}

- (void)didFailLoadGistsWithError:(NSError *)error {
    [self.view showError:error];
}

#pragma mark - GistListVCDelegate

- (void)didLoad {
    [self.interactor loadNextGistsListPage];
}

- (void)didScrollToLastElement {
    [self.interactor loadNextGistsListPage];
}

@end
