//
//  ViewController.h
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/27.
//

#import <UIKit/UIKit.h>
#import "CBridge.h"
@interface ViewController : UIViewController

@property(nonatomic,strong) UITableView* tableView;

@property(nonatomic,strong) CBridge* model;

@property(nonatomic,strong) NSString* destination;
@end

