//
//  Ports.h
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/27.
//

#ifndef Ports_h
#define Ports_h

#include <stdio.h>
#include <string.h>
#include "AirRoute.h"

typedef int State;

/**
 初始化操作
 @param airport 传入一个airport类型的指针
 @return 返回值{
               1 = 成功初始化
               0 = 初始化失败
               -1 = 初始化异常
              }
 */
State initAirport(airport* airport);

/**
 依据终点站名查询相关航班
 @param airport 传入一个airport类型的实例 des 传入一个指向终点站名字符串的字符型指针
 @return 返回值{
               1 = 成功找到航班
               0 = 无到达此终点的航班
               -1 = 查询异常
              }
 */
State searchWithDestination(airport airport,char* des);

/**
 订购机票
 @param airport 传入一个airport类型的指针
        arID 传入一个long int类型的航班ID号
        number 传入一个int类型的购票量
 @return 返回值{
               1 = 成功购票
               0 = 余票不足
               -1 = 购票异常，无此班航班
              }
 */
State orderTicket(airport* airport,long int arID,int number);

/**
 退订机票
 @param airport 传入一个airport类型的指针
        arID 传入一个long int类型的航班ID号
        date 传入一个指向起飞日期字符串的字符型指针
        number 用户需要退票的张数
 @return 返回值{
               1 = 成功退票
               0 = 退票失败
               -1 = 退票异常
              }
 */
State cancelTicket(airport* airport,char* date,long int arID,int number);

/**
 询问客户相关个人信息
 @param name 传入指向客户姓名字符串的字符型指针
        status 传入一个指向客户舱位要求数据的int类型指针
 */
void askClient(char* name,int* status);

/**
 退订机票
 @param client 传入一个Client类型的指针
        number 传入需要退票的张数
 */
State cancelTicketWith(Client* client,int number);
#endif /* Ports_h */
