//
//  ViewController.m
//  RHCircleTableView
//
//  Created by Abner_G on 2018/1/19.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import "ViewController.h"
#import "RHCircleTableView.h"

@interface ViewController () <RHCircleTableViewDataSource, RHCircleTableViewDelegate>

@property (nonatomic, strong) RHCircleTableView * circleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)addSubviews {
    
    [self.view addSubview:self.circleView];
//    [_circleView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.top.mas_equalTo(SS(30));
//        make.right.mas_equalTo(-SS(30));
//        make.height.mas_equalTo(SS(500));
//    }];
    _circleView.frame = CGRectMake(20, 40, 200, 300);
}

#pragma mark - circle delegate

- (NSInteger)numberOfSectionsIncircleTableView:(RHCircleTableView *)circleTableView {
    
    return 2;
}

- (NSInteger)circleTableView:(RHCircleTableView *)circleTableView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 4;
    }
    return 8;
}

- (UIView *)circleTableView:(RHCircleTableView *)circleTableView itemAtIndexPath:(NSIndexPath *)indexPath {
    
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor yellowColor];
    return view;
}

- (CGFloat)circleTableView:(RHCircleTableView *)circleTableView radiusInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 60;
    }
    return 120;
}

- (CGSize)circleTableView:(RHCircleTableView *)circleTableView itemSizeAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(60, 60);
}

- (double)circleTableView:(RHCircleTableView *)circleTableView startAngleInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 0.25 * M_PI;
    }
    return 0;
}

- (void)circleTableView:(RHCircleTableView *)circleTableView didSelectAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"click section = %zd, row = %zd", indexPath.section, indexPath.row);
}

#pragma mark - setter and getter

- (RHCircleTableView *)circleView {
    
    if (!_circleView) {
        
        _circleView = [[RHCircleTableView alloc] init];
        _circleView.dataSource = self;
        _circleView.delegate = self;
//        _circleView.startAngle = -0.5 * M_PI;
//        _circleView.intervalAngle = 0.25 * M_PI;
//        _circleView.radius = 60;
//        _circleView.itemSize = CGSizeMake(80, 80);
        _circleView.backgroundColor = [UIColor lightGrayColor];
    }
    return _circleView;
}



@end
