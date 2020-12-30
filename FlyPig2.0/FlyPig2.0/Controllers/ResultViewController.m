//
//  ResultViewController.m
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/30.
//

#import "ResultViewController.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"机票信息🎫";
    [self setupSubviews];
}

-(void)setupSubviews{
    //self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    self.airportID = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, 200, 30)];
    self.airportID.font = [UIFont systemFontOfSize:20];
    self.airportID.textColor = [UIColor orangeColor];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 70, 50, 50)];
    
    self.arID = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-50, 50, 80, 50)];
    self.arID.font = [UIFont systemFontOfSize:25];
    
    self.apID = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-50, 100, 80, 50)];
    self.apID.font = [UIFont systemFontOfSize:25];
    self.apID.textColor = [UIColor grayColor];
    
    self.seatID = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-90, 70, 100, 50)];
    self.seatID.font = [UIFont systemFontOfSize:25];
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(15, 150, ScreenWidth - 30, 200)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = 15;
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0,0);
    self.bgView.layer.shadowOpacity = 0.5;
    self.bgView.layer.shadowRadius = 5;
    
    [self.view addSubview:_bgView];
    [self.bgView addSubview:_imageView];
    [self.bgView addSubview:_arID];
    [self.bgView addSubview:_apID];
    [self.bgView addSubview:_seatID];
    [self.bgView addSubview:_airportID];
    
    [self setupData];
}
-(void)setupData{
    self.imageView.image = [UIImage systemImageNamed:@"person"];
    
    self.arID.text = [NSString stringWithFormat:@"AR%ld",self.model.airRouteID];
    
    self.apID.text = [NSString stringWithFormat:@"CW%d",self.model.airplaneID];
    
    self.seatID.text = [NSString stringWithFormat:@"A%d",arc4random() % 100];
    
    self.airportID.text = @"CW AIRPORT";
}
@end
