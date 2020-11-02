//
//  UserEntity.h
//  NSThread_GCD
//
//  Created by Seven on 2020/11/1.
//  Copyright © 2020 binart. All rights reserved.
//

#import <WCDB/WCDB.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserEntity : NSObject <WCTTableCoding>

@property int user_id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) int age;

WCDB_PROPERTY(user_id)
WCDB_PROPERTY(name)
WCDB_PROPERTY(age)

@end

NS_ASSUME_NONNULL_END
