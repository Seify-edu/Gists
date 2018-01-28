//
//  GistDetailInteractor.h
//  Gists
//
//  Created by Roman S on 28/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GistDetailFile.h"

@protocol GistDetailInteractorOutput
- (void)didLoadGistContent:(NSArray<GistDetailFile *> *)content;
- (void)didFailLoadGistsContentWithError:(NSError *)error;
@end

@interface GistDetailInteractor : NSObject
@property (weak) id<GistDetailInteractorOutput> presenter;
@end
