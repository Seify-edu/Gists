//
//  GistCommitCell.h
//  Gists
//
//  Created by Roman S on 29/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GistCommitCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addedLabel;
@property (weak, nonatomic) IBOutlet UILabel *removedLabel;
@end
