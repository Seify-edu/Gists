//
//  GistDetailPresenter.m
//  Gists
//
//  Created by Roman S on 28/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import "GistDetailPresenter.h"

@interface GistDetailPresenter()
@property (strong) GistListElement *gistData;
@end

@implementation GistDetailPresenter

- (instancetype)initWithGistListElement:(GistListElement *)element {
    if ( self = [super init] ) {
        self.gistData = element;
    }
    return self;
};

#pragma mark - GistListViewOutput

- (void)didLoad {
    [self.view showData: self.gistData ? @[self.gistData] : @[]];
    //load other stuff
}

@end
