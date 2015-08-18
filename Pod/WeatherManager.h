//
//  WeatherManager.h
//  ToDo
//
//  Created by PJ on 8/11/15.
//  Copyright (c) 2015 PineApple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherManager : NSObject

    @property (strong) NSString *city;
    @property (strong, nonatomic) NSString *country;

    + (WeatherManager *)singleton;
    - (void)fetchWeather:(void(^)(NSDictionary *info))success failure:(void(^)(NSError *error))failure;

@end
