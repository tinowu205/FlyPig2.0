//
//  RecommandController.m
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/29.
//

#import "RecommandController.h"
#import "RouteCell.h"
@interface RecommandController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation RecommandController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor whiteColor];
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, self.view.frame.size.width - 20, 100)];
    self.label.font = [UIFont systemFontOfSize:30];
    self.label.text = @"我们还有以下航班推荐👇🏻";
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 0;
    [self.view addSubview:_label];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 20, 700)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _model.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RouteModel* model  = [self.model objectAtIndex:indexPath.row];
    
    RouteCell* cell = [[RouteCell alloc]initWithModel:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
@end
