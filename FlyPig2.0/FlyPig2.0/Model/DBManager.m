//
//  DBManager.m
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2021/12/3.
//

#import "DBManager.h"

#define keyMap(name) @#name

@interface DBManager ()

@property(nonatomic,strong) OHMySQLStoreCoordinator *coordinator;

@property(nonatomic,strong) OHMySQLQueryContext *context;

@end

@implementation DBManager

#pragma mark -
#pragma mark config
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

#pragma mark -
#pragma mark select

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

#pragma mark -
#pragma mark insert

- (BOOL)insertInto:(NSString*)table value:(NSDictionary*)value {
    OHMySQLQueryRequest* insert = [OHMySQLQueryRequestFactory INSERT:table set:value];
    NSError* error = nil;
    [self.context executeQueryRequestAndFetchResult:insert error:&error];
    
    if (!error) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)insertToBuyWithName:(NSString* _Nonnull)name routeID:( NSNumber* _Nonnull)routeID planeID:( NSNumber* _Nonnull)planeID cnt:(NSNumber* _Nonnull)cnt {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
    [dict setValue:name forKey:@"name"];
    [dict setValue:routeID forKey:@"routeID"];
    [dict setValue:planeID forKey:@"planeID"];
    [dict setValue:cnt forKey:@"cnt"];
    
    // truly insert
    return [self insertInto:@"buy" value:dict];
}

- (BOOL)insertToClientsWithName:(NSString* _Nonnull)name cnt:( NSNumber* _Nonnull)cnt status:( NSNumber* _Nonnull )status plane:(NSNumber* _Nonnull)planeID {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
    [dict setValue:name forKey:@"name"];
    [dict setValue:cnt forKey:@"orderCnt"];
    [dict setValue:status forKey:@"status"];
    [dict setValue:planeID forKey:@"planeID"];
    
    // truly insert
    return [self insertInto:@"clients" value:dict];
}

#pragma mark -
#pragma mark update
- (BOOL)updateToTable:(NSString* _Nonnull)table value:(NSDictionary* _Nonnull)value condition:(NSString*)condition {
    OHMySQLQueryRequest* update = [OHMySQLQueryRequestFactory UPDATE:table set:value condition:condition];
    
    NSError* error = nil;
    [self.context executeQueryRequestAndFetchResult:update error:&error];
    
    if (!error) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)updateLeftTickets:(NSNumber* _Nonnull)left airplaneID:(int)airplaneID {
    NSMutableDictionary* dict = [[NSMutableDictionary alloc]init];
    
    [dict setValue:left forKey:@"leftTickets"];
    
    return [self updateToTable:@"routes" value:dict condition:[NSString stringWithFormat:@"airplaneID = '%d'",airplaneID] ];
}
@end
