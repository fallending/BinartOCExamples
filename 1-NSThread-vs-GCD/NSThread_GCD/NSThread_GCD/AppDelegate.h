//
//  AppDelegate.h
//  NSThread_GCD
//
//  Created by Seven on 2020/11/1.
//  Copyright © 2020 binart. All rights reserved.
//

#import <UIKit/UIKit.h>

#undef  singleton
#define singleton( __class ) \
        property (nonatomic, readonly) __class * shared; \
        - (__class *)shared; \
        + (__class *)shared;

#undef  def_singleton
#define def_singleton( __class ) \
        dynamic shared; \
        - (__class *)shared \
        { \
            return [__class shared]; \
        } \
        + (__class *)shared \
        { \
            static dispatch_once_t once; \
            static __strong id __singleton__ = nil; \
            dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
            return __singleton__; \
        }

@interface AppDelegate : UIResponder <UIApplicationDelegate>


@end

