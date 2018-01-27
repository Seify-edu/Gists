//
//  GistListDataLoader.h
//  Gists
//
//  Created by Roman S on 27/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GistListElement.h"

@protocol GistListInteractorOutput
- (void)didLoadGists:(NSArray<GistListElement *> *)gists;
- (void)didFailLoadGistsWithError:(NSError *)error;
@end

@interface GistListInteractor : NSObject
@property (weak) id<GistListInteractorOutput> presenter;
- (void)loadGistsList;
@end
