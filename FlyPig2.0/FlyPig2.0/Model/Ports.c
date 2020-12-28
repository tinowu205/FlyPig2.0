//
//  Ports.c
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/27.
//

#include "Ports.h"
#include <stdlib.h>

#pragma mark 相关接口实现

//初始化机场Airport实例
State initAirport(airport* airport){
    char* dest[] = {"北京","上海","深圳","广州","杭州","成都","北京","杭州","上海"};
    long int routesID[allRoutes] = {342,182,900,154,872,797,484,255,192};
    int planesID[allRoutes] = {19,29,33,11,16,82,91,24,66};
    char* date[] = {"周三","周一","周日","周六","周一","周二","周五","周二","周三"};
    int capacity[allRoutes] = {400,420,350,300,320,280,300,280,340};
    int leftTickets[allRoutes] = {182,112,152,83,49,72,89,112,211};
    
    if(airport == NULL){
        return -1;
    }else{
        for (int i = 0; i<allRoutes; i++) {
            airRoute* route = &airport->routes[i];
            
            route->airRouteID = routesID[i];
            
            route->airplaneID = planesID[i];
            
            route->destination = (char*)malloc(sizeof(dest[i]));
            route->destination = dest[i];
            
            route->date = (char*)malloc(sizeof(date[i]));
            route->date = date[i];
            
            route->capacity = capacity[i];
            
            route->leftTickets = leftTickets[i];
            
            route->clients = NULL;
            
            route->candidates = NULL;
        }
        airport->hasInited = 1;
    }
    return 1;
}

//在机场中依据终点站名寻找航班
State searchWithDestination(airport airport,char* des){
    int had = 0;
    for(int i = 0;i<allRoutes;i++){
        airRoute route = airport.routes[i];
        if(strcmp(route.destination, des) == 0){
            printf("----Airroute----\n");
            printf("Destination = %s\n",route.destination);
            printf("Airroute'id = %ld\n",route.airRouteID);
            printf("Airplane'id = %d\n",route.airplaneID);
            printf("Date = %s\n",route.date);
            printf("LeftTickets = %d\n",route.leftTickets);
            printf("------End-------\n");
            had = 1;
            
            break;
        }else{
            
        }
    }
    if(had == 1){
        return 1;
    }else{
        printf("We don't have this airroute\n");
        return 0;
    }
}

//订票操作
State orderTicket(airport* airport,long int arID,int number){
    int had = 0;
    for(int i = 0;i<allRoutes;i++){
        airRoute* route = &airport->routes[i];
        if(route->airRouteID == arID){ //找到客户指定的航线
            if(route->leftTickets >= number){ //如果余票充足满足客户需要
                had = 1;
                
                Client* client = NULL;
                char* clientName = NULL;
                clientName = (char*)malloc(sizeof(char));
                int status = 0;
                
                askClient(clientName, &status);
                
                client = (Client*)malloc(sizeof(Client));
                client->name = (char*)malloc(30 * sizeof(char));
                client->name = clientName;
                client->orderCnt = number;
                client->status = status;
                client->next = NULL;
                
                //向route的clients链表中插入新增的客户
                if(route->clients == NULL){
                    route->clients = (Client*)malloc(sizeof(Client));
                    route->clients->name = client->name;
                    route->clients->orderCnt = number;
                    route->clients->status = status;
                    route->clients->next = NULL;
                }else{
                    Client* p = route->clients;
                    while (p->next != NULL) {
                        p = route->clients->next;
                    }
                    p->next = (Client*)malloc(sizeof(Client));
                    p->next->name = client->name;
                    p->next->orderCnt = client->orderCnt;
                    p->next->status = client->status;
                    p->next->next = NULL;
                }
                //更新客户购买完成后的余票量
                route->leftTickets -= number;
                break;
            }else{ //余票不足，询问客户是否需要候补
                had = 0;
                printf("余票不足，请问是否需要继续购买？ 1/0 \n");
                int temp = 0;
                scanf("%d",&temp);
                if(temp == 1){ //继续候补购买
                    Candidate* candidate = NULL;
                    char* clientName = NULL;
                    clientName = (char*)malloc(sizeof(char));
                    int status = 0;
                    
                    askClient(clientName, &status);
                    
                    //将新增的候补客户插入到route的candidates链表中
                    if(route->candidates == NULL){
                        route->candidates = (Candidate*)malloc(sizeof(Candidate));
                        route->candidates->name = clientName;
                        route->candidates->needCnt = number;
                        route->candidates->next = NULL;
                    }else{
                        Candidate* temp = route->candidates;
                        while (temp->next != NULL) {
                            temp = temp->next;
                        }
                        
                        temp->next = (Candidate*)malloc(sizeof(Candidate));
                        temp->next->name = clientName;
                        temp->next->needCnt = number;
                        temp->next->next = NULL;
                    }
                }else{ //不继续购买，退出系统
                    
                }
            }
        }else{ //本班航线不是客户指定航线，继续轮询
            
        }
    }
    
    if(had == 1){ //成功完成购票
        return 1;
    }else if (had == 0){ //余票不足
        return 0;
    }else{ //本机场无客户指定的航班
        printf("无此班次的航班\n");
        return -1;
    }
}

//退票操作
State cancelTicket(airport* airport,char* date,long int arID,int number){
    for(int i = 0;i<allRoutes;i++){
        airRoute* route = &airport->routes[i];
        char* name = NULL;
        name = (char*)malloc(sizeof(char));
        
        if(route->airRouteID == arID){ //找到要退票的航班
            printf("为您办理退票\n");
            printf("请输入乘客姓名\n");
            scanf("%s",name);
            getchar();
            
            Client* client = route->clients;
            if(strcmp(client->name, name) == 0){
                if(client->orderCnt - number > 0){
                    client->orderCnt -= number;
                }else if(client->orderCnt - number == 0){
                    Client* temp = route->clients->next;
                    free(route->clients);
                    route->clients = temp;
                }else{
                    return -1;
                }
                printf("退票成功\n");
            }else{
                while ( ( client->next!=NULL) && strcmp(client->next->name, name) != 0) {
                    client = client->next;
                }
                if(client->next != NULL){
                    cancelTicketWith(client, number);
                }else{
                    printf("没有找到该顾客\n");
                    return -1;
                }
                
            }
            
        }else{ //不是要退票的航班，继续轮询
            
        }
    }
    return 1;
}

//询问客户的个人相关信息
void askClient(char* name,int* status){
    printf("请输入乘客姓名\n");
    scanf("%s",name);
    getchar();
    printf("请输入舱位等级(1,2,3)\n");
    scanf("%d",status);
    getchar();
}

State cancelTicketWith(Client* client,int number){
    if(client->next->orderCnt - number > 0){
        client->next->orderCnt -= number;
    }else if(client->next->orderCnt - number == 0){
        Client* temp = client->next->next;
        free(client->next);
        client->next = temp;
    }else{
        return -1;
    }
    printf("退票成功\n");
    return 1;
}
