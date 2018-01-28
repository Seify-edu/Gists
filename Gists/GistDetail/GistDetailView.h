//
//  GistDetailView.h
//  Gists
//
//  Created by Roman S on 28/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GistDetailViewOutput
- (void)didLoad;
@end

@interface GistDetailView : UITableViewController
@property id<GistDetailViewOutput> presenter;
@end
