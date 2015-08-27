//
//  WeatherManager.m
//  ToDo
//
//  Created by PJ on 8/11/15.
//  Copyright (c) 2015 PineApple Tech. All rights reserved.
//

#import "WeatherManager.h"


static NSString * const URL = @"http://api.openweathermap.org/data/2.5/weather"; //{city name},{country code 2 digits}"

@interface WeatherManager ()

@end


@implementation WeatherManager


float kelvinToCelcius(float kelvin) {
    return kelvin - 273.15;
}

+ (WeatherManager *)singleton
{
    static WeatherManager *_sharedWeatherManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedWeatherManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:URL]];
    });
    
    return _sharedWeatherManager;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer]; //[AFHTTPResponseSerializer serializer];
    }
    
    return self;
}


- (void)fetchWeatherForCity:(void(^)(NSDictionary *info))success failure:(void(^)(NSError *error))failure {
    
    NSAssert(self.city != nil, @"City is not set");
    NSAssert(self.country != nil, @"Country is not set");
    
    
    NSDictionary *params = @{
                             @"q": [[NSString alloc] initWithFormat:@"%@,%@", self.city, self.country]
                             };
    
    [self GET:@"" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dJSON = responseObject;
        
        if (success != nil) {
            NSString *description = [dJSON[@"weather"] firstObject][@"description"];
            
            NSString *min = [[NSString alloc] initWithFormat:@"%.2f",kelvinToCelcius(  [dJSON[@"main"][@"temp_min"] floatValue]  )];
            
            NSString *max = [[NSString alloc] initWithFormat:@"%.2f",kelvinToCelcius(  [dJSON[@"main"][@"temp_max"] floatValue]  )];
            
            NSString *current = [[NSString alloc] initWithFormat:@"%.2f",kelvinToCelcius(  [dJSON[@"main"][@"temp"] floatValue]  )];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                success(@{@"min": min, @"max": max, @"current": current, @"description": description});
            });
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
        }
    }];
    
}

- (void)fetchWeatherForLatitude:(double)lat Longitude:(double)lon success:(void(^)(NSDictionary *info))success failure:(void(^)(NSError *error))failure {
    
    NSDictionary *params = @{
                             @"lat": @(lat),
                             @"lon": @(lon),
                             };
    
    
    [self GET:@"" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dJSON = responseObject;
        
        if (success != nil) {
            NSString *description = [dJSON[@"weather"] firstObject][@"description"];
            
            NSString *min = [[NSString alloc] initWithFormat:@"%.2f",kelvinToCelcius(  [dJSON[@"main"][@"temp_min"] floatValue]  )];
            
            NSString *max = [[NSString alloc] initWithFormat:@"%.2f",kelvinToCelcius(  [dJSON[@"main"][@"temp_max"] floatValue]  )];
            
            NSString *current = [[NSString alloc] initWithFormat:@"%.2f",kelvinToCelcius(  [dJSON[@"main"][@"temp"] floatValue]  )];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                success(@{@"min": min, @"max": max, @"current": current, @"description": description});
            });
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
        }
    }];
}


@end
