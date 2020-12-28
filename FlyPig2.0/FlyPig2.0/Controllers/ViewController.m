//
//  ViewController.m
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/27.
//

#import "ViewController.h"
#import "RouteCell.h"
#import "Ports.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController{
    airport a;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"AirRoutes🛩";
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    
    if([_destination isEqual: @""]){
        self.model = [[CBridge alloc]initWithAirport:&a];
    }else{
       self.model = [[CBridge alloc]initWithAirport:&a andDestination:_destination];
    }
    
}

#pragma mark UITableViewDelegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.routes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    RouteModel* model = self.model.routes[indexPath.row];
    
    RouteCell* cell = [[RouteCell alloc]initWithModel:model];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RouteModel* model = self.model.routes[indexPath.row];
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:@"乘客信息👨🏻‍✈️" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    //添加确定
    UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull   action) {
        NSLog(@"确定");
        
        NSString* name = alertView.textFields[0].text;
        int cnt = alertView.textFields[1].text.intValue;
        int status = alertView.textFields[2].text.intValue;
        
        if(model.leftTickets >= cnt){
            ClientModel* client = [[ClientModel alloc]init];
            client.name = name;
            client.orderCnt = cnt;
            client.status = status;
            
            [model.clientModels addObject:client];
            
            model.leftTickets -= cnt;
            
            NSLog(@"成功购票！");
        }else{
            
        }
        
    }];
    [alertView addAction:cancelBtn];
    [alertView addAction:sureBtn];
    
    [alertView addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入乘客姓名";
    }];
    
    [alertView addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入票数";
    }];
    
    [alertView addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入舱位等级";
    }];
    
    [self presentViewController:alertView animated:YES completion:nil];
}
@end
