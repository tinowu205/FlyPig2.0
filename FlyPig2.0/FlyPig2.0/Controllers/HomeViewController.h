//
//  HomeViewController.h
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/28.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController

@property(nonatomic,strong) UIView* bgView;

@property(nonatomic,strong) UITextView* searchView;

@property(nonatomic,strong) UILabel* buttonView;

@property(nonatomic,strong) ViewController* detailVC;

@end

NS_ASSUME_NONNULL_END
