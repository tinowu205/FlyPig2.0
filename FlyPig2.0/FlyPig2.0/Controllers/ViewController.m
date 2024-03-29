//
//  ViewController.m
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/27.
//

#import "ViewController.h"
#import "RouteCell.h"
#import "Ports.h"
#import "RecommandController.h"
#import "ResultViewController.h"
#import "DBManager.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) DBManager* manager;

@end

@implementation ViewController{
    airport a;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"AirRoutes🛩";
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    [self.view addSubview:_tableView];
    
    if([_destination isEqual: @""]){
        DBManager *manager = [DBManager sharedManager];
        //self.model = [[CBridge alloc]initWithAirport:&a];
        self.model = [[CBridge alloc]init];
        self.model.routes = [[manager selectAllRoute] mutableCopy];
    }else{
//       self.model = [[CBridge alloc]initWithAirport:&a andDestination:_destination];
        self.model = [[CBridge alloc]init];
        self.model.routes = [[[DBManager sharedManager] selectRoutesFor:_destination] mutableCopy];
    }
    
    self.manager = [DBManager sharedManager];
    
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
            
            BOOL result = [self.manager insertToClientsWithName:name cnt:[NSNumber numberWithInt:cnt] status:[NSNumber numberWithInt:status] plane:[NSNumber numberWithInt:model.airplaneID]];
            
            result = result && [self.manager insertToBuyWithName:name routeID:[NSNumber numberWithLong:model.airRouteID] planeID:[NSNumber numberWithInt:model.airplaneID] cnt:[NSNumber numberWithInt:cnt]];
            
            [model.clientModels addObject:client];
            
            model.leftTickets -= cnt;
            
            result = result && [self.manager updateLeftTickets:[NSNumber numberWithInt:model.leftTickets] airplaneID:model.airplaneID];
            
            if (result == YES) {
                NSLog(@"成功购票！");
            } else {
                NSLog(@"购票失败!");
            }
            
            [self.tableView reloadData];
            
            ResultViewController* resultVC = [[ResultViewController alloc]init];
            resultVC.model = model;
            [self.navigationController pushViewController:resultVC animated:YES];
        }else{
            NSMutableArray* temp = self.model.routes;
            [temp removeObject:model];
            
            if(temp.count > 0){
                RecommandController* recommandVC = [[RecommandController alloc]init];
                recommandVC.model = temp;
                recommandVC.modalPresentationStyle = UIModalPresentationFormSheet;
                [self presentViewController:recommandVC animated:YES completion:^{
                    
                }];
            }else{
                NSLog(@"购票失败");
            }
            
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
