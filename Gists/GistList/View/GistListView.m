//
//  ViewController.m
//  Gists
//
//  Created by Roman S on 27/01/2018.
//  Copyright © 2018 RS. All rights reserved.
//

#import "GistListView.h"
#import "GistListCell.h"
#import "GistListElement.h"
#import "UIImageView+WebCache.h"

@interface GistListView ()<GistListPresenterToViewOutput, GistListRouterOutput>
@property NSArray<GistListElement *> *data;
@end

@implementation GistListView

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"GistListCell" bundle:nil] forCellReuseIdentifier:@"GistListCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 122;
    [self.presenter didLoad];
}

#pragma mark - GistListPresenterToViewOutput

- (void)showData:(NSArray<GistListElement *> *)data {
    self.data = data;
    [self.tableView reloadData];
}

- (void)showError:(NSError *)error {
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Error"
                                 message:error.localizedDescription
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* okButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [self dismissViewControllerAnimated:YES completion:nil];
                                }];
    
    [alert addAction:okButton];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - GistListRouterOutput

- (void)presentViewController:(UIViewController *)vc {
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     GistListCell *cell = (GistListCell *)[tableView dequeueReusableCellWithIdentifier:@"GistListCell" forIndexPath:indexPath];
     GistListElement *element = self.data[indexPath.row];
     cell.topLabel.text = element.userName;
     cell.bottomLabel.text = element.gistName;
     NSURL *url = element.pathToImage ? [NSURL URLWithString:element.pathToImage] : nil;
     if (url) {
         [cell.photoView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"default_photo"]];
     }
 
     if ( indexPath.row == [self.data count] - 1 ) {
         [self.presenter didScrollToLastElement];
     }
     
     return cell;
 }

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    [self.presenter didSelectDataAtIndex:indexPath.row];
}

@end
