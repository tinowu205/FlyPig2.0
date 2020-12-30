//
//  RecommandController.h
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecommandController : UIViewController

@property(nonatomic,strong) UITableView* tableView;

@property(nonatomic,strong) NSMutableArray* model;

@property(nonatomic,strong) UILabel* label;
@end

NS_ASSUME_NONNULL_END
