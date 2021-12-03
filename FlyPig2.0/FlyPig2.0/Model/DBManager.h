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

+ (instancetype)sharedManager;

- (NSArray*)selectAllRoute;

- (NSArray*)selectRoutesFor: (NSString*)dest;

- (NSArray*)mapRoutes: (NSArray*)routes;

@end

NS_ASSUME_NONNULL_END
