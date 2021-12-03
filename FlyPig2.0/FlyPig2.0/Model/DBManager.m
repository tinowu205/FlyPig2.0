//
//  DBManager.m
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2021/12/3.
//

#import "DBManager.h"

@interface DBManager ()

@property(nonatomic,strong) OHMySQLStoreCoordinator *coordinator;

@property(nonatomic,strong) OHMySQLQueryContext *context;

@end

@implementation DBManager

+ (instancetype)sharedManager {
    static DBManager *_manager;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        if (!_manager) {
            _manager = [super allocWithZone:nil];
            [_manager configDB];
        }
    });
    return _manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [DBManager sharedManager];
}

- (void)configDB {
    OHMySQLUser *user = [[OHMySQLUser alloc]initWithUserName:@"root"                                                       password:@"wcw136688"                                                serverName:@"localhost"                                                    dbName:@"flypig"                                                         port:3306
                                                      socket:nil];
    OHMySQLStoreCoordinator *coordinator = [[OHMySQLStoreCoordinator alloc]initWithUser:user];
    
    [coordinator connect];

    [coordinator setEncoding:CharsetEncodingUTF8MB4];

    OHMySQLQueryContext *queryContext = [OHMySQLQueryContext new];
    queryContext.storeCoordinator = coordinator;
    [OHMySQLContainer sharedContainer].mainQueryContext = queryContext;
    
    self.coordinator = coordinator;
    self.context = queryContext;
}

- (NSArray *)selectAllRoute {
    OHMySQLQueryRequest* query = [OHMySQLQueryRequestFactory SELECT:@"routes" condition:nil];
    NSError* error = nil;
    NSArray* response = [self.context executeQueryRequestAndFetchResult:query error:&error];
    
    NSArray* routes = [self mapRoutes:response];
    
    return routes;
}

- (NSArray *)selectRoutesFor:(NSString *)dest {
    OHMySQLQueryRequest* query = [OHMySQLQueryRequestFactory SELECT:@"routes" condition:[NSString stringWithFormat:@"destination = '%@'",dest]];
    NSError* error = nil;
    NSArray* response = [self.context executeQueryRequestAndFetchResult:query error:&error];
    
    NSArray* routes = [self mapRoutes:response];
    
    return routes;
}
- (NSArray *)mapRoutes: (NSArray*)routes {
    if (routes.count == 0) {
        return [NSArray array];
    }
    
    NSMutableArray* array = [[NSMutableArray alloc]init];
    for (int i = 0; i<routes.count; i++) {
        NSDictionary* dict = routes[i];
        RouteModel* model = [[RouteModel alloc]init];
        
        NSArray* keys = dict.allKeys;
        for (int i = 0; i < keys.count; i++) {
            [model setValue:dict[keys[i]] forKey:keys[i]];
        }
        [array addObject:model];
    }
    
    return array;
}
@end
