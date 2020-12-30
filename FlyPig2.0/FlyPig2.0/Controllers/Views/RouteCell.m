//
//  RouteCell.m
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/28.
//

#import "RouteCell.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
@implementation RouteCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithModel:(RouteModel*)model{
    self = [super init];
    self.model = model;
    
    [self layoutViews];
    
    return self;
}
-(void)layoutViews{
    self.routeID = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 100, 20)];
    self.des = [[UILabel alloc]initWithFrame:CGRectMake(15, 50, 100, 50)];
    self.planeID = [[UILabel alloc]initWithFrame:CGRectMake(15, 120, 80, 20)];
    self.date = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth/2-20, 20, 80, 50)];
    self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth/2-25, 70, 40, 40)];
    self.ticket = [[UILabel alloc]initWithFrame:CGRectMake(ScreenWidth-85, 50, 100, 50)];
    
    [self addSubview:_routeID];
    [self addSubview:_des];
    [self addSubview:_planeID];
    [self addSubview:_date];
    [self addSubview:_ticket];
    [self addSubview:_imageview];
    
    _routeID.text = [NSString stringWithFormat:@"AR%ld",_model.airRouteID];
    
    _des.text = _model.destination;
    _des.font = [UIFont systemFontOfSize:25];
    
    _planeID.text = [NSString stringWithFormat:@"CW%d",_model.airplaneID];
    _planeID.textColor = [UIColor grayColor];
    
    _date.text = _model.date;
    
    _imageview.image = [UIImage systemImageNamed:@"paperplane"];
    
    _ticket.text = [NSString stringWithFormat:@"%d/%d",_model.leftTickets,_model.capacity];
    _ticket.textColor = [UIColor orangeColor];
}
@end
