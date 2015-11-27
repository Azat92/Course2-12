//
//  SecondViewController.m
//  Lesson13
//
//  Created by Azat Almeev on 27.11.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "SecondViewController.h"
#import "MyClass.h"

@interface SecondViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *items;
@end

@implementation SecondViewController

- (IBAction)exitDidClick:(id)sender {
    if (self.presentingViewController)
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    else {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"FirstVC"];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (NSString *)itemsPath {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    return [path stringByAppendingPathComponent:@"items"];
}

- (NSString *)items2Path {
    return [self.itemsPath stringByAppendingString:@"2"];
}

- (NSString *)items3Path {
    return [self.itemsPath stringByAppendingString:@"3"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *barbutton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    self.navigationItem.rightBarButtonItem = barbutton;
    UIBarButtonItem *exitBarbutton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(exitDidClick:)];
    self.navigationItem.leftBarButtonItem = exitBarbutton;
//    self.items = [NSArray arrayWithContentsOfFile:self.itemsPath];
    self.items = [NSKeyedUnarchiver unarchiveObjectWithFile:self.items3Path];
}

- (IBAction)addItem:(id)sender {
    MyClass *myClass = [MyClass randomObject];
//    NSString *item = [NSString stringWithFormat:@"%d", arc4random_uniform(100)];
    self.items = [(self.items ?: @[]) arrayByAddingObject:myClass];
//    [self.items writeToFile:self.itemsPath atomically:YES];
    [NSKeyedArchiver archiveRootObject:self.items toFile:self.items3Path];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLoggedIn"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"] ?: [UITableViewCell.alloc initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
    cell.textLabel.text = [self.items[indexPath.row] fullTitle];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableArray *mArray = [NSMutableArray new];
    [self.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != indexPath.row)
            [mArray addObject:obj];
    }];
    self.items = mArray.copy;
    [NSKeyedArchiver archiveRootObject:self.items toFile:self.items3Path];
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
