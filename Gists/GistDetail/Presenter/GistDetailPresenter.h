//
//  GistDetailPresenter.h
//  Gists
//
//  Created by Roman S on 28/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GistListElement.h"

@protocol GistDetailPresenterToViewOutput
- (void)showData:(NSArray *)data;
- (void)showError:(NSError *)error;
@end

@protocol GistDetailPresenterToInteractorOutput
- (void)loadContentForGistID:(NSString *)gistID;
- (void)loadCommitsForGistID:(NSString *)gistID;
@end

@interface GistDetailPresenter : NSObject
- (instancetype)initWithGistListElement:(GistListElement *)element;
@property (weak) id<GistDetailPresenterToViewOutput> view;
@property (strong) id<GistDetailPresenterToInteractorOutput> interactor;
@end
