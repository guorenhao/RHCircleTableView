//
//  UIView+RHCircleTableView.h
//  RHKit
//
//  Created by 郭人豪 on 2018/1/18.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (RHCircleTableView)

/* 位置标记 */
@property (nonatomic, strong) NSIndexPath * rh_indexPath;

/**
 移除所有子视图
 */
- (void)rh_removeAllSubviews;
@end
