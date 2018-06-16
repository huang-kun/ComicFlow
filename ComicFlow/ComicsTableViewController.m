//
//  ComicsTableViewController.m
//  ComicFlow
//
//  Created by huangkun on 2018/6/16.
//  Copyright © 2018年 vipkid. All rights reserved.
//

#import "ComicsTableViewController.h"
#import "UIViewController+Alert.h"
#import "ChapterTableViewController.h"
#import "CMFetcher.h"

@interface ComicsTableViewController ()
@property (nonatomic, strong) NSArray <NSString *> *comics;
@end

@implementation ComicsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"ComicCell"];
    
    UIRefreshControl *refresher = self.tableView.refreshControl;
    [refresher beginRefreshing];
    
    [CMFetcher.shared fetchComicsWithCompletion:^(NSArray<NSString *> *comics, NSError *error) {
        [refresher endRefreshing];

        if (!error) {
            self.comics = comics;
            [self.tableView reloadData];
        } else {
            [self alertError:error];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.comics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ComicCell" forIndexPath:indexPath];
    cell.textLabel.text = self.comics[indexPath.row];
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController *dvc = segue.destinationViewController;
    NSInteger index = self.tableView.indexPathForSelectedRow.row;
    if ([dvc isKindOfClass:ChapterTableViewController.class]) {
        ChapterTableViewController *ctvc = (ChapterTableViewController *)dvc;
        ctvc.comic = self.comics[index];
    }
}

@end
