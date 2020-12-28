//
//  ClientModel.h
//  FlyPig2.0
//
//  Created by tino又想吃肉了 on 2020/12/28.
//

#import <Foundation/Foundation.h>
/**
 char* name;//姓名
 int orderCnt;//订票量
 int status;//舱位等级：1｜2｜3
 struct Client* next;//下一位
 */
NS_ASSUME_NONNULL_BEGIN

@interface ClientModel : NSObject

@property(nonatomic,strong) NSString* name;

@property(nonatomic,assign) int orderCnt;

@property(nonatomic,assign) int status;

-(instancetype)initWithName:(NSString*)name Need:(int)cnt andStatus:(int)status;
@end

NS_ASSUME_NONNULL_END
