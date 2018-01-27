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

@protocol GistListPresenterToInteractorOutput
- (void)loadGistsList;
@end


@interface GistListPresenter : NSObject
@property (weak) id<GistListPresenterToViewOutput> view;
@property (strong) id<GistListPresenterToInteractorOutput> interactor;
@end
