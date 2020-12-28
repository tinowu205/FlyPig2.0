//
//  CBridge.m
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/27.
//

#import "CBridge.h"

@implementation CBridge

-(instancetype)initWithAirport:(airport*)airport{
    self = [super init];
    
    self.routes = [[NSMutableArray alloc]init];
    
    initAirport(airport);
    
    for(int i = 0;i<allRoutes;i++){
        airRoute route = airport->routes[i];
        RouteModel* temp = [[RouteModel alloc]init];
        temp.clientModels = [[NSMutableArray alloc]init];
        temp.candidateModels = [[NSMutableArray alloc]init];
        
        temp.airRouteID = route.airRouteID;
        temp.airplaneID = route.airplaneID;
        temp.capacity = route.capacity;
        temp.leftTickets = route.leftTickets;
        temp.date = [NSString stringWithCString:route.date encoding:NSUTF8StringEncoding];
        temp.destination = [NSString stringWithCString:route.destination encoding:NSUTF8StringEncoding];
        
        Client* p = route.clients;
        while (p) {
            Client* client = route.clients;
            ClientModel* clientModel = [[ClientModel alloc]init];
            
            clientModel.name = [NSString stringWithCString:client->name encoding:NSUTF8StringEncoding];
            clientModel.orderCnt = client->orderCnt;
            clientModel.status = client->status;
            
            [temp.clientModels addObject:clientModel];
            
            p = p->next;
        }
        
        Candidate* q = route.candidates;
        while (q) {
            Candidate* candidate = route.candidates;
            CandidateModel* candidateModel = [[CandidateModel alloc]init];
            
            candidateModel.name = [NSString stringWithCString:candidate->name encoding:NSUTF8StringEncoding];
            candidateModel.needCnt = candidate->needCnt;
            
            [temp.candidateModels addObject:candidateModel];
            
            q = q->next;
        }
        
        [self.routes addObject:temp];
    }
    
    return self;
}

-(instancetype)initWithAirport:(airport*)airport andDestination:(NSString*)des{
    self = [super init];
    
    self.routes = [[NSMutableArray alloc]init];
    
    initAirport(airport);
    
    for(int i = 0;i<allRoutes;i++){
        airRoute route = airport->routes[i];
        if( ![ [NSString stringWithCString:route.destination encoding:NSUTF8StringEncoding] isEqualToString:des] ){
            //NSLog(@"%d",[NSString stringWithCString:route.destination encoding:NSUTF8StringEncoding] == des);
            continue;
        }else{
            //NSLog(@"%@",[NSString stringWithCString:route.destination encoding:NSUTF8StringEncoding]);
        }
        RouteModel* temp = [[RouteModel alloc]init];
        temp.clientModels = [[NSMutableArray alloc]init];
        temp.candidateModels = [[NSMutableArray alloc]init];
        
        temp.airRouteID = route.airRouteID;
        temp.airplaneID = route.airplaneID;
        temp.capacity = route.capacity;
        temp.leftTickets = route.leftTickets;
        temp.date = [NSString stringWithCString:route.date encoding:NSUTF8StringEncoding];
        temp.destination = [NSString stringWithCString:route.destination encoding:NSUTF8StringEncoding];
        
        Client* p = route.clients;
        while (p) {
            Client* client = route.clients;
            ClientModel* clientModel = [[ClientModel alloc]init];
            
            clientModel.name = [NSString stringWithCString:client->name encoding:NSUTF8StringEncoding];
            clientModel.orderCnt = client->orderCnt;
            clientModel.status = client->status;
            
            [temp.clientModels addObject:clientModel];
            
            p = p->next;
        }
        
        Candidate* q = route.candidates;
        while (q) {
            Candidate* candidate = route.candidates;
            CandidateModel* candidateModel = [[CandidateModel alloc]init];
            
            candidateModel.name = [NSString stringWithCString:candidate->name encoding:NSUTF8StringEncoding];
            candidateModel.needCnt = candidate->needCnt;
            
            [temp.candidateModels addObject:candidateModel];
            
            q = q->next;
        }
        
        [self.routes addObject:temp];
    }
    
    return self;
}
@end
