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

@interface GistListView ()
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

#pragma mark - GistListDataSourceDelegate

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
    [self presentViewController:alert animated:YES completion:nil];}

#pragma mark -

#pragma mark - Table view data source

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
 
     return cell;
 }

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


@end
