//
//  ChapterTableViewController.m
//  ComicFlow
//
//  Created by huangkun on 2018/6/16.
//  Copyright © 2018年 vipkid. All rights reserved.
//

#import "ChapterTableViewController.h"
#import "ImageBrowserViewController.h"
#import "UIViewController+Alert.h"
#import "CMFetcher.h"

@interface ChapterTableViewController ()
@property (nonatomic, strong) NSArray <NSString *> *chapters;
@end

@implementation ChapterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"ChapterCell"];

    if (self.comic.length > 0) {
        UIRefreshControl *refresher = self.tableView.refreshControl;
        [refresher beginRefreshing];
        
        [CMFetcher.shared fetchChaptersForComic:self.comic completion:^(NSArray<NSString *> *chapters, NSError *error) {
            [refresher endRefreshing];
            
            if (!error) {
                self.chapters = chapters;
                [self.tableView reloadData];
            } else {
                [self alertError:error];
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setChapters:(NSArray<NSString *> *)chapters {
    _chapters = [chapters sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        if (obj1.integerValue < obj2.integerValue) {
            return NSOrderedDescending;
        } else if (obj1.integerValue > obj2.integerValue) {
            return NSOrderedAscending;
        } else {
            return NSOrderedSame;
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChapterCell" forIndexPath:indexPath];
    cell.textLabel.text = self.chapters[indexPath.row];
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
    if ([dvc isKindOfClass:ImageBrowserViewController.class]) {
        ImageBrowserViewController *ibvc = (ImageBrowserViewController *)dvc;
        ibvc.comic = self.comic;
        ibvc.chapter = self.chapters[index];
    }
}

@end
