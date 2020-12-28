//
//  RouteModel.h
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/28.
//

#import <Foundation/Foundation.h>
#import "ClientModel.h"
#import "CandidateModel.h"
NS_ASSUME_NONNULL_BEGIN
/**
 char* destination;//终点站名
 long int airRouteID;//航班号
 int airplaneID;//飞机号
 char* date;//出发日
 int capacity;//乘员定额
 int leftTickets;//余票量
 Client* clients;//已订票乘客名单
 Candidate* candidates;//候选名单
 */
@interface RouteModel : NSObject

@property(nonatomic,strong) NSString* destination;

@property(nonatomic,assign) long int airRouteID;

@property(nonatomic,assign) int airplaneID;

@property(nonatomic,strong) NSString* date;

@property(nonatomic,assign) int capacity;

@property(nonatomic,assign) int leftTickets;

@property(nonatomic,strong) NSMutableArray* clientModels;

@property(nonatomic,strong) NSMutableArray* candidateModels;

@end

NS_ASSUME_NONNULL_END
