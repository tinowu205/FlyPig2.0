//
//  DBManager.h
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2021/12/3.
//

#import <Foundation/Foundation.h>
#import <OHMySQL/OHMySQL.h>
#import "RouteModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DBManager : NSObject

/// 数据库管理类
+ (instancetype)sharedManager;

/// 从数据库提取所有航班信息
- (NSArray*)selectAllRoute;

/// 从数据库提取特定目的地的航班信息
/// @param dest 目的地名称
- (NSArray*)selectRoutesFor: (NSString*)dest;

/// 向已购买表（buy表）中插入一条记录
/// @param name 购买者姓名
/// @param routeID 购买航线ID
/// @param planeID 购买航班ID
/// @param cnt 购买数量
- (BOOL)insertToBuyWithName:(NSString* _Nonnull)name routeID:( NSNumber* _Nonnull)routeID planeID:( NSNumber* _Nonnull)planeID cnt:(NSNumber* _Nonnull)cnt;

/// 向顾客表（clients表）插入一条记录
/// @param name 购买者姓名
/// @param cnt 购买数量
/// @param status 仓位等级
/// @param planeID 购买航班ID
- (BOOL)insertToClientsWithName:(NSString* _Nonnull)name cnt:( NSNumber* _Nonnull)cnt status:( NSNumber* _Nonnull )status plane:(NSNumber* _Nonnull)planeID;

/// 更新Routes表中的剩余票数信息
/// @param left 剩余票数
/// @param airplaneID 航班ID
- (BOOL)updateLeftTickets:(NSNumber* _Nonnull)left airplaneID:(int)airplaneID;

@end

NS_ASSUME_NONNULL_END
