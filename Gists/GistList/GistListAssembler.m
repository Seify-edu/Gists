//
//  GistListAssembler.m
//  Gists
//
//  Created by Roman S on 27/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import "GistListAssembler.h"

@implementation GistListAssembler

+ (GistListView *)assemble
{
    GistListInteractor *interactor = [GistListInteractor new];
    GistListPresenter *presenter = [GistListPresenter new];
    GistListView *view = [[GistListView alloc] initWithNibName:nil bundle:nil];
    
    presenter.view = (id<GistListPresenterToViewOutput>)view;
    presenter.interactor = (id<GistListPresenterToInteractorOutput>)interactor;
    view.presenter = (id<GistListViewOutput>)presenter;
    interactor.presenter = (id<GistListInteractorOutput>)presenter;
    
    return view;
};

@end
