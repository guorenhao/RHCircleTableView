//
//  RHCircleTableView.m
//  RHKit
//
//  Created by Abner_G on 2018/1/15.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import "RHCircleTableView.h"
#import "UIView+RHCircleTableView.h"

@interface RHCircleTableView ()
// 组数
@property (nonatomic, assign) NSInteger sectionsCount;
// 高与宽的差
@property (nonatomic, assign) CGFloat difference;
// 本身半径（宽的一半）
@property (nonatomic, assign) CGFloat selfRadius;
@end
@implementation RHCircleTableView

- (void)reloadData {
    
    [self addSubviews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    NSLog(@"layout subviews...");
    self.selfRadius = self.bounds.size.width / 2;
    self.difference = (self.bounds.size.height - self.bounds.size.width) / 2;
    [self addSubviews];
}

- (void)addSubviews {
    
    [self rh_removeAllSubviews];
    for (int i = 0; i < self.sectionsCount; i++) {
        
        if ([self.dataSource circleTableView:self numberOfItemsInSection:i] <= 0) {
            
            break;
        }
        CGFloat radius = self.radius;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(circleTableView:radiusInSection:)]) {
            
            radius = [self.dataSource circleTableView:self radiusInSection:i];
        }
        double angle = self.startAngle - 0.5 * M_PI;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(circleTableView:startAngleInSection:)]) {
            
            angle = [self.dataSource circleTableView:self startAngleInSection:i] - 0.5 * M_PI;
        }
        NSInteger itemCount = [self.dataSource circleTableView:self numberOfItemsInSection:i];
        double interval = 2 * M_PI / itemCount;
        if (self.intervalAngle > 0) {
            interval = self.intervalAngle;
        }
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(circleTableView:intervalAngleInSection:)]) {
            
            interval = [self.dataSource circleTableView:self intervalAngleInSection:i];
        }
        for (int j = 0; j < itemCount; j++) {
            
            NSIndexPath * indexPath = [NSIndexPath indexPathForRow:j inSection:i];
            CGSize itemSize = self.itemSize;
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(circleTableView:itemSizeAtIndexPath:)]) {
                
                itemSize = [self.dataSource circleTableView:self itemSizeAtIndexPath:indexPath];
            } else {
                
                if (itemSize.width <= 0 && itemSize.height <= 0) {
                    
                    itemSize = CGSizeMake(40, 40);
                }
            }
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(circleTableView:itemAtIndexPath:)]) {
                
                [self addItemView:[self.dataSource circleTableView:self itemAtIndexPath:indexPath] radius:radius itemSize:itemSize angle:angle indexPath:indexPath];
            } else {
                
                UIView * view = [[UIView alloc] init];
                view.backgroundColor = [UIColor whiteColor];
                [self addItemView:view radius:radius itemSize:itemSize angle:angle indexPath:indexPath];
            }
            angle += interval;
        }
    }
}

- (void)addItemView:(UIView *)itemView radius:(CGFloat)radius itemSize:(CGSize)itemSize angle:(double)angle indexPath:(NSIndexPath *)indexPath {
    
    CGFloat x = radius * cos(angle);
    CGFloat y = radius * sin(angle);
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, itemSize.width, itemSize.height)];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    [view addGestureRecognizer:tap];
    view.rh_indexPath = indexPath;
    view.center = CGPointMake(self.selfRadius + x, self.selfRadius + y + self.difference);
    itemView.frame = CGRectMake(0, 0, itemSize.width, itemSize.height);
    [view addSubview:itemView];
    [self addSubview:view];
}

#pragma mark - event

- (void)tapView:(UITapGestureRecognizer *)tap {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(circleTableView:didSelectAtIndexPath:)]) {
        
        [self.delegate circleTableView:self didSelectAtIndexPath:tap.view.rh_indexPath];
    }
}

#pragma mark -

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

    UIView * view = [super hitTest:point withEvent:event];
    if (view == nil) {

        for (UIView * subView in self.subviews) {

            CGPoint p = [subView convertPoint:point fromView:self];
            if (CGRectContainsPoint(subView.bounds, p)) {

                view = subView;
            }
        }
    }
    return view;
}

#pragma mark - setter and getter

- (NSInteger)sectionsCount {
    
    if (_numberOfSections == 0) {
        
        _numberOfSections = 1;
    }
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionsIncircleTableView:)]) {
        
        _numberOfSections = [self.dataSource numberOfSectionsIncircleTableView:self];
    }
    _sectionsCount = _numberOfSections;
    return _sectionsCount;
}


@end
