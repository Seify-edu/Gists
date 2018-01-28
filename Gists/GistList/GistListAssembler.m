//
//  GistListAssembler.m
//  Gists
//
//  Created by Roman S on 27/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import "GistListAssembler.h"
#import "GistListView.h"
#import "GistListPresenter.h"
#import "GistListInteractor.h"
#import "GistListRouter.h"

@implementation GistListAssembler

+ (UIViewController *)assemble
{
    GistListInteractor *interactor = [GistListInteractor new];
    GistListPresenter *presenter = [GistListPresenter new];
    GistListRouter *router = [GistListRouter new];
    GistListView *view = [[GistListView alloc] initWithNibName:nil bundle:nil];

    interactor.presenter = (id<GistListInteractorOutput>)presenter;
    presenter.view = (id<GistListPresenterToViewOutput>)view;
    presenter.interactor = (id<GistListPresenterToInteractorOutput>)interactor;
    presenter.router = (id<GistListPresenterToRouterOutput>)router;
    router.view = (id<GistListRouterOutput>)view;
    view.presenter = (id<GistListViewOutput>)presenter;
    
    return view;
};

@end
