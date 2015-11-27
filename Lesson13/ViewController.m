//
//  ViewController.m
//  Lesson13
//
//  Created by Azat Almeev on 27.11.15.
//  Copyright © 2015 Azat Almeev. All rights reserved.
//

#import "ViewController.h"
#import "MyClass.h"

@interface ViewController ()
@end

@implementation ViewController

#define kMyKey @"myKey"

- (IBAction)buttonDidClick:(id)sender {
    if (self.presentingViewController)
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    else {
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondVC"];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    NSLog(@"%@", contents);
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLoggedIn"];
}



@end
