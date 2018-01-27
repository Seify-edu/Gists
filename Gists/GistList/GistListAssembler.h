//
//  GistListAssembler.h
//  Gists
//
//  Created by Roman S on 27/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GistListView.h"
#import "GistListPresenter.h"
#import "GistListInteractor.h"

@interface GistListAssembler : NSObject
+ (GistListView *)assemble;
@end
