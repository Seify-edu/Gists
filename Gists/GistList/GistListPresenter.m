//
//  GistListDataSource.m
//  Gists
//
//  Created by Roman S on 27/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import "GistListPresenter.h"

@interface GistListPresenter()<GistListInteractorOutput, GistListViewOutput>
@end

@implementation GistListPresenter

#pragma mark - GistListDataLoaderDelegate

- (void)didLoadGists:(NSArray *)gists {
    [self.view showData:gists];
}

- (void)didFailLoadGistsWithError:(NSError *)error {
    [self.view showError:error];
}

#pragma mark - GistListVCDelegate

- (void)didLoad {
    [self.interactor loadGistsList];
}

@end
