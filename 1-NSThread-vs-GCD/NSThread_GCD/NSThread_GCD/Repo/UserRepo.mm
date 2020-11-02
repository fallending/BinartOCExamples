//
//  UserRepo.m
//  NSThread_GCD
//
//  Created by Seven on 2020/11/1.
//  Copyright © 2020 binart. All rights reserved.
//

#import "UserRepo.h"
#import "DBManager.h"
#import "UserEntity.h"

@implementation UserRepo

@def_singleton(UserRepo)

- (void)addOne:(NSString *)name age:(int)age {
    UserEntity *user = [[UserEntity alloc] init];
    user.isAutoIncrement = YES; // 如果你的模型里使用了WCDB_PRIMARY_AUTO_INCREMENT，就要把该属性设置为YES，否则会报错
    user.age = age;
    user.name = name;
    
    [[DBManager shared].database insertObject:user into:@"user"];
}

@end
