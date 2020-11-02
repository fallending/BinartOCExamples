//
//  UserEntity.m
//  NSThread_GCD
//
//  Created by Seven on 2020/11/1.
//  Copyright © 2020 binart. All rights reserved.
//

#import "UserEntity.h"

@implementation UserEntity

WCDB_IMPLEMENTATION(UserEntity)

WCDB_SYNTHESIZE(UserEntity, user_id)
WCDB_SYNTHESIZE(UserEntity, name)
WCDB_SYNTHESIZE(UserEntity, age)

WCDB_PRIMARY_AUTO_INCREMENT(UserEntity, user_id)

- (NSString *)description {
    return [NSString stringWithFormat:@"姓名：%@ 年龄：%@", self.name, @(self.age)];
}
@end
