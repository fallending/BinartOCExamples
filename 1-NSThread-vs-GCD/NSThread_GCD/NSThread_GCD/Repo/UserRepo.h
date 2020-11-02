//
//  UserRepo.h
//  NSThread_GCD
//
//  Created by Seven on 2020/11/1.
//  Copyright © 2020 binart. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserRepo : NSObject

@singleton(UserRepo)

- (void)addOne:(NSString *)name age:(int)age;

@end

NS_ASSUME_NONNULL_END
