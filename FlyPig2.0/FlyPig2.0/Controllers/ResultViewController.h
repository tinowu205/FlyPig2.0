//
//  ResultViewController.h
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/30.
//

#import <UIKit/UIKit.h>
#import "RouteModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ResultViewController : UIViewController

@property(nonatomic,strong) UIView* bgView;

@property(nonatomic,strong) UIImageView* imageView;

@property(nonatomic,strong) UILabel* nameLabel;

@property(nonatomic,strong) UILabel* arID;

@property(nonatomic,strong) UILabel* apID;

@property(nonatomic,strong) UILabel* seatID;

@property(nonatomic,strong) UILabel* airportID;

@property(nonatomic,strong) RouteModel* model;
@end

NS_ASSUME_NONNULL_END
