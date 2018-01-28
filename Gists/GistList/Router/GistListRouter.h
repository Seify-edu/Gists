//
//  GistListRouter.h
//  Gists
//
//  Created by Roman S on 28/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GistListPresenter.h"

@protocol GistListRouterOutput
- (void)presentViewController:(UIViewController *)vc;
@end

@interface GistListRouter : NSObject
@property (weak) id<GistListRouterOutput> view;
@end
