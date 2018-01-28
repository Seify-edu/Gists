//
//  GistListDataSource.h
//  Gists
//
//  Created by Roman S on 27/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GistListInteractor.h"
#import "GistListView.h"

@protocol GistListPresenterToViewOutput
- (void)showData:(NSArray *)data;
- (void)showError:(NSError *)error;
@end

@protocol GistListPresenterToRouterOutput
- (void)showDetailedGistWithID:(NSString *)gistID;
@end

@protocol GistListPresenterToInteractorOutput
- (void)loadNextGistsListPage;
@end

@interface GistListPresenter : NSObject
@property (weak) id<GistListPresenterToViewOutput> view;
@property (strong) id<GistListPresenterToRouterOutput> router;
@property (strong) id<GistListPresenterToInteractorOutput> interactor;
@end
