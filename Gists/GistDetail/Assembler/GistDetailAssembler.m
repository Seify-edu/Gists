//
//  GistDetailAssembler.m
//  Gists
//
//  Created by Roman S on 28/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import "GistDetailAssembler.h"
#import "GistDetailView.h"
#import "GistDetailPresenter.h"
#import "GistDetailInteractor.h"

@implementation GistDetailAssembler

+ (UIViewController *)assembleWithGist:(GistListElement *)element
{
    GistDetailInteractor *interactor = [GistDetailInteractor new];
    GistDetailPresenter *presenter = [[GistDetailPresenter alloc] initWithGistListElement:element];
    GistDetailView *view = [[GistDetailView alloc] initWithNibName:nil bundle:nil];
    
    interactor.presenter = (id<GistDetailInteractorOutput>)presenter;
    presenter.view = (id<GistDetailPresenterToViewOutput>)view;
    presenter.interactor = (id<GistDetailPresenterToInteractorOutput>)interactor;
    view.presenter = (id<GistDetailViewOutput>)presenter;
    
    return view;
};

@end
