//
//  ViewController.h
//  Gists
//
//  Created by Roman S on 27/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GistListPresenter.h"

@protocol GistListViewOutput
- (void)didLoad;
- (void)didScrollToLastElement;
@end

@interface GistListView : UITableViewController
@property id<GistListViewOutput> presenter;
@end

