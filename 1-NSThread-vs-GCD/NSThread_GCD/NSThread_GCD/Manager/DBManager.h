//
//  DBManager.h
//  NSThread_GCD
//
//  Created by Seven on 2020/11/2.
//  Copyright © 2020 binart. All rights reserved.
//

#import <WCDB/WCDB.h>
#import <Foundation/Foundation.h>
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface DBManager : NSObject

@property (nonatomic, strong) WCTDatabase *database;

@singleton(DBManager)

@end

NS_ASSUME_NONNULL_END
