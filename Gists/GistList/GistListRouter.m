//
//  GistListRouter.m
//  Gists
//
//  Created by Roman S on 28/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import "GistListRouter.h"

@interface GistListRouter()<GistListPresenterToRouterOutput>
@end

@implementation GistListRouter

- (void)showDetailedGistWithID:(NSString *)gistID { 
    [self.view presentViewController:[UIViewController new]];
}

@end
