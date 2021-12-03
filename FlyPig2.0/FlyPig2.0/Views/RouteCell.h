//
//  RouteCell.h
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/28.
//

#import <UIKit/UIKit.h>
#import "RouteModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface RouteCell : UITableViewCell

@property(nonatomic,strong) RouteModel* model;

@property(nonatomic,strong) UILabel* routeID;

@property(nonatomic,strong) UILabel* planeID;

@property(nonatomic,strong) UILabel* date;

@property(nonatomic,strong) UILabel* des;

@property(nonatomic,strong) UILabel* ticket;

@property(nonatomic,strong) UIImageView* imageview;

- (instancetype)initWithModel:(RouteModel*)model;
@end

NS_ASSUME_NONNULL_END
