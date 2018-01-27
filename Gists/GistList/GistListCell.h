//
//  GistListCell.h
//  Gists
//
//  Created by Roman S on 27/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GistListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@end
