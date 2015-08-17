//
//  ViewController2.m
//  TableViewHeader
//
//  Created by admin.konnech on 15/6/26.
//  Copyright (c) 2015年 Konnech Inc'. All rights reserved.
//

#import "NewVotingInfoViewController.h"
#import "UINavigationBar+Awesome.h"
#import "CustomTopView.h"

#define MAINCOLOR [UIColor colorWithRed:47/255.0 green:72/255.0 blue:85/255.0 alpha:1]

////////////////////////////////////////////////////////////////////////////////////////////////

static float imageHeight = 260.0;
static float titleLabelHeight = 40.0;
static float imageViewTopConstraint = -40.0;

@interface NewVotingInfoViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *topBackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageViewTopConstaint;
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet CustomTopView *customTopView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) NSMutableArray *accessibilityElements;

@end

@implementation NewVotingInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:241/255.0 alpha:1.0];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.customTopView setAddressButtonBlock:^(DCRoundedButton *button) {
        NSLog(@"address Button clicked");
    }];
    [self.customTopView setElectionButtonBlock:^(DCRoundedButton *button) {
        NSLog(@"election button clicked");
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.view.isAccessibilityElement = NO;
    [self.view setAccessibilityElements:self.accessibilityElements];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    NSLog(@"%f",offsetY);
    self.heightConstraint.constant = imageHeight - offsetY;
    if (self.heightConstraint.constant <= 65) {
        self.heightConstraint.constant = 65;
    }
    if (offsetY > 0) {
        self.colorView.alpha = offsetY/(imageHeight - 20 - titleLabelHeight);
        [self.topBackView bringSubviewToFront:self.colorView];
        [self.accessibilityElements removeObject:self.customTopView];
    }
    if (offsetY <= 0) {
        [self.topBackView sendSubviewToBack:self.colorView];
        self.accessibilityElements = nil;
        [self accessibilityElements];
        
        if (offsetY > imageViewTopConstraint) {
            self.imageViewTopConstaint.constant = imageViewTopConstraint - offsetY;
        } else {
            self.imageViewTopConstaint.constant = 0;
        }
    }
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 19;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 260.0;
    }
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"cell %d", (int)indexPath.row];
    return cell;
}

- (NSMutableArray *)accessibilityElements
{
    if (!_accessibilityElements) {
        _accessibilityElements = [NSMutableArray array];
        
        [_accessibilityElements addObject:self.customTopView];
        
        [_accessibilityElements addObject:self.titleLabel];
        
        [_accessibilityElements addObject:self.tableView];
    }
    return _accessibilityElements;
}

@end
