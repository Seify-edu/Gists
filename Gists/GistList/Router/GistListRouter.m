//
//  GistListRouter.m
//  Gists
//
//  Created by Roman S on 28/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import "GistListRouter.h"
#import "GistDetailAssembler.h"
#import "GistListElement.h"

@interface GistListRouter()<GistListPresenterToRouterOutput>
@end

@implementation GistListRouter

- (void)showDetailedGist:(GistListElement *)element {
    UIViewController *vc = [GistDetailAssembler assembleWithGist:element];
    [self.view presentViewController:vc];
}

@end
