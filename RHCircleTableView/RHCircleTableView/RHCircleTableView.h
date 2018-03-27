//
//  RHCircleTableView.h
//  RHKit
//
//  Created by Abner_G on 2018/1/15.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RHCircleTableViewDataSource;
@protocol RHCircleTableViewDelegate;
@interface RHCircleTableView : UIView

@property (nonatomic, weak) id<RHCircleTableViewDataSource> dataSource;
@property (nonatomic, weak) id<RHCircleTableViewDelegate> delegate;

// section的个数
@property (nonatomic, assign) NSInteger numberOfSections;
// 半径（item中心点与圆心的距离）
@property (nonatomic, assign) CGFloat radius;
// item宽高
@property (nonatomic, assign) CGSize itemSize;

// 起始角度（顺时针）默认为 0
@property (nonatomic, assign) double startAngle;
// 间隔角度 默认为 2*M_PI/个数
@property (nonatomic, assign) double intervalAngle;

/**
 刷新数据
 */
- (void)reloadData;

@end
@protocol RHCircleTableViewDataSource <NSObject>

/**
 获取item个数

 @param circleTableView circleTableView
 @param section         分组
 @return                item个数
 */
- (NSInteger)circleTableView:(RHCircleTableView *)circleTableView numberOfItemsInSection:(NSInteger)section;

/**
 获取item视图

 @param circleTableView circleTableView
 @param indexPath       位置
 @return                item视图
 */
- (UIView *)circleTableView:(RHCircleTableView *)circleTableView itemAtIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 获取分组个数 默认是1

 @param circleTableView circleTableView
 @return                分组个数
 */
- (NSInteger)numberOfSectionsIncircleTableView:(RHCircleTableView *)circleTableView;

/**
 获取半径（item中心与圆心距离）

 @param circleTableView circleTableView
 @param section         分组
 @return                半径
 */
- (CGFloat)circleTableView:(RHCircleTableView *)circleTableView radiusInSection:(NSInteger)section;

/**
 获取item尺寸

 @param circleTableView circleTableView
 @param indexPath       位置
 @return                item尺寸
 */
- (CGSize)circleTableView:(RHCircleTableView *)circleTableView itemSizeAtIndexPath:(NSIndexPath *)indexPath;

/**
 获取起始角度

 @param circleTableView circleTableView
 @param section         分组
 @return                起始角度
 */
- (double)circleTableView:(RHCircleTableView *)circleTableView startAngleInSection:(NSInteger)section;

/**
 获取角度间隔

 @param circleTableView circleTableView
 @param section         分组
 @return                角度间隔
 */
- (double)circleTableView:(RHCircleTableView *)circleTableView intervalAngleInSection:(NSInteger)section;

@end
@protocol RHCircleTableViewDelegate <NSObject>

@optional

/**
 点击item响应事件

 @param circleTableView circleTableView
 @param indexPath       位置
 */
- (void)circleTableView:(RHCircleTableView *)circleTableView didSelectAtIndexPath:(NSIndexPath *)indexPath;

@end
