//
//  CandidateModel.h
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/28.
//

#import <Foundation/Foundation.h>
/**
 char* name;//姓名
 int needCnt;//所需票量
 struct Candidate* next;//下一位
 */
NS_ASSUME_NONNULL_BEGIN

@interface CandidateModel : NSObject

@property(nonatomic,strong) NSString* name;

@property(nonatomic,assign) int needCnt;

-(instancetype) initWithName:(NSString*)name andNeed:(int)cnt;
@end

NS_ASSUME_NONNULL_END
