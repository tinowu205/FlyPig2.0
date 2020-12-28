//
//  CBridge.h
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/27.
//

#import <Foundation/Foundation.h>
#import "Ports.h"
#import "AirRoute.h"
#import "RouteModel.h"

@interface CBridge : NSObject

@property(nonatomic,strong) NSMutableArray* routes;

-(instancetype)initWithAirport:(airport*)airport;

-(instancetype)initWithAirport:(airport*)airport andDestination:(NSString*)des;
@end


