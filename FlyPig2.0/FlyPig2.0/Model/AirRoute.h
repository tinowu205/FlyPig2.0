//
//  AirRoute.h
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/27.
//

#ifndef AirRoute_h
#define AirRoute_h

#include <stdio.h>
#define allRoutes 9
struct Client {
    char* name;//姓名
    int orderCnt;//订票量
    int status;//舱位等级：1｜2｜3
    struct Client* next;//下一位
};
typedef struct Client Client;

struct Candidate {
    char* name;//姓名
    int needCnt;//所需票量
    struct Candidate* next;//下一位
};
typedef struct Candidate Candidate;

struct airRoute {
    char* destination;//终点站名
    long int airRouteID;//航班号
    int airplaneID;//飞机号
    char* date;//出发日
    int capacity;//乘员定额
    int leftTickets;//余票量
    Client* clients;//已订票乘客名单
    Candidate* candidates;//候选名单
};
typedef struct airRoute airRoute;

struct airport {
    airRoute routes[allRoutes];//所有航线
    int hasInited;//是否已初始化。1=初始化，0=未初始化，-1=异常
};
typedef struct airport airport;
#endif /* AirRoute_h */
