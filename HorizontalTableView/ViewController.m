//
//  ViewController.m
//  HorizontalTableView
//
//  Created by ileo on 16/3/11.
//  Copyright © 2016年 ileo. All rights reserved.
//

#import "ViewController.h"
#import "HorizontalTableView.h"

@interface ViewController () <HorizontalTableViewDataSourse,HorizontalTableViewDelegate>

@property (nonatomic, strong) HorizontalTableView *hTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.hTableView = [[HorizontalTableView alloc] initWithFrame:self.view.bounds];
    self.hTableView.dataSource = self;
    [self.view addSubview:self.hTableView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - datasource

-(NSInteger)numberOfRows{
    return 10;
}

-(HorizontalTableViewCell *)horizontalTableView:(HorizontalTableView *)horizontalTableView cellForRow:(NSInteger)row{
    static NSString *cellID = @"cellID";
    HorizontalTableViewCell *cell = [horizontalTableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[HorizontalTableViewCell alloc] initWithReuseIdentifier:cellID];
        cell.backgroundColor = [UIColor yellowColor];
        cell.layer.borderColor = [UIColor redColor].CGColor;
        cell.layer.borderWidth = 1;
    }
    return cell;
}

-(CGFloat)horizontalTableView:(HorizontalTableView *)horizontalTableView widthForRow:(NSInteger)row{
    return 60;
}

@end
