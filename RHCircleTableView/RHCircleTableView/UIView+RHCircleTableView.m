//
//  UIView+RHCircleTableView.m
//  RHKit
//
//  Created by 郭人豪 on 2018/1/18.
//  Copyright © 2018年 Abner_G. All rights reserved.
//

#import "UIView+RHCircleTableView.h"
#import <objc/runtime.h>

static char kRHIndexPathKey;
@implementation UIView (RHCircleTableView)

- (void)setRh_indexPath:(NSIndexPath *)rh_indexPath {
    
    objc_setAssociatedObject(self, &kRHIndexPathKey, rh_indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSIndexPath *)rh_indexPath {
    
    return objc_getAssociatedObject(self, &kRHIndexPathKey);
}

/**
 移除所有子视图
 */
- (void)rh_removeAllSubviews {
    
    while (self.subviews.count) {
        
        [self.subviews.lastObject removeFromSuperview];
    }
}

@end
