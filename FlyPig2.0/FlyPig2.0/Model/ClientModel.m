//
//  ClientModel.m
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/28.
//

#import "ClientModel.h"

@implementation ClientModel

-(instancetype)initWithName:(NSString*)name Need:(int)cnt andStatus:(int)status{
    self = [super init];
    
    self.name = name;
    
    self.orderCnt = cnt;
    
    self.status = status;
    
    return self;
}

@end
