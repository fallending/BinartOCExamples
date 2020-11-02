//
//  DBManager.m
//  NSThread_GCD
//
//  Created by Seven on 2020/11/2.
//  Copyright © 2020 binart. All rights reserved.
//

#import "DBManager.h"
#import "UserEntity.h"

@implementation DBManager

@def_singleton(DBManager)

- (WCTDatabase *)database {
    static WCTDatabase *db = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSLog(@"db path = %@", docDir);
        db = [[WCTDatabase alloc] initWithPath:[docDir stringByAppendingPathComponent:@"my_db"]];
        if ([db canOpen]) {
//            [db createTableAndIndexesOfName:@"user" withClass:[UserEntity class]];
//            [db crate]
            if (![db isTableExists:@"user"]) {
                [db createTableAndIndexesOfName:@"user" withClass:[UserEntity class]];
            }
            //如果表不存在就创建表，如果字段有更新，就更新表，所以不用判断是否已经存在该表
        }
    });
    _database = db;
    return _database;
}

@end
