//
//  GistDetailPresenter.m
//  Gists
//
//  Created by Roman S on 28/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import "GistDetailPresenter.h"
#import "GistDetailInteractor.h"
#import "GistDetailView.h"

@interface GistDetailPresenter()<GistDetailViewOutput, GistDetailInteractorOutput>
@property (strong) GistListElement *gistData;
@property (strong) NSArray *files;
@end

@implementation GistDetailPresenter

- (instancetype)initWithGistListElement:(GistListElement *)element {
    if ( self = [super init] ) {
        self.gistData = element;
        self.files = @[];
        [self.view showData:[self allData]];
    }
    return self;
};

- (NSArray *)allData {
    NSMutableArray *allData = [NSMutableArray array];
    [allData addObject:self.gistData];
    [allData addObjectsFromArray:self.files];
    return allData;
}

#pragma mark - GistDetailViewOutput

- (void)didLoad {
    [self.view showData: @[self.gistData]];
    [self.interactor loadContentForGistID:self.gistData.gistID];
    //load other stuff
}

#pragma mark - GistDetailInteractorOutput

- (void)didFailLoadGistsContentWithError:(NSError *)error {
    [self.view showError:error];
}

- (void)didLoadGistContent:(NSArray<GistDetailFile *> *)content {
    self.files = content;
    [self.view showData: [self allData]];
}

@end
