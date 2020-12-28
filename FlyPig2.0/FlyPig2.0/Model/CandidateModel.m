//
//  CandidateModel.m
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/28.
//

#import "CandidateModel.h"

@implementation CandidateModel
- (instancetype) initWithName:(NSString*)name andNeed:(int)cnt{
    self = [super init];
    
    self.name = name;
    
    self.needCnt = cnt;
    
    return self;
}
@end
