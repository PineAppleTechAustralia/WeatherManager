//
//  WeatherManager.m
//  ToDo
//
//  Created by PJ on 8/11/15.
//  Copyright (c) 2015 PineApple Tech. All rights reserved.
//

#import "WeatherManager.h"

#define URL @"http://api.openweathermap.org/data/2.5/weather?" //{city name},{country code 2 digits}"

@interface WeatherManager ()

@end


@implementation WeatherManager

+ (WeatherManager *)singleton
{
    static WeatherManager *_sharedWeatherManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedWeatherManager = [[self alloc] init];
    });
    
    return _sharedWeatherManager;
}

float kelvinToCelcius(float kelvin) {
    return kelvin - 273.15;
}

- (void)fetchWeatherForCity:(void(^)(NSDictionary *info))success failure:(void(^)(NSError *error))failure {
    
    NSAssert(self.city != nil, @"City is not set");
    NSAssert(self.country != nil, @"Country is not set");
    
    NSString *fullUrl = [[NSString alloc] initWithFormat:@"%@q=%@,%@", URL, self.city,self.country];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:fullUrl]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                
                NSError *jsonError;
                NSMutableDictionary *dJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                if (error != nil) {
                    if (failure != nil) {
                        failure(error);
                    }
                    
                    return;
                }
                
                if (jsonError != nil) {
                    if (failure != nil) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            failure(jsonError);
                        });
                    }
                    return;
                }
                
                if (success != nil) {
                    NSString *description = [dJSON[@"weather"] firstObject][@"description"];
                    
                    NSString *min = [[NSString alloc] initWithFormat:@"%.2f",kelvinToCelcius(  [dJSON[@"main"][@"temp_min"] floatValue]  )];
                    
                    NSString *max = [[NSString alloc] initWithFormat:@"%.2f",kelvinToCelcius(  [dJSON[@"main"][@"temp_max"] floatValue]  )];
                    
                    NSString *current = [[NSString alloc] initWithFormat:@"%.2f",kelvinToCelcius(  [dJSON[@"main"][@"temp"] floatValue]  )];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        success(@{@"min": min, @"max": max, @"current": current, @"description": description});
                    });
                    
                }
                
            }] resume];
    
    
    
}

- (void)fetchWeatherForLatitude:(double)lat Longitude:(double)lon success:(void(^)(NSDictionary *info))success failure:(void(^)(NSError *error))failure {
    
    NSString *fullUrl = [[NSString alloc] initWithFormat:@"%@lat=%f&lon=%f", URL,lat,lon];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:fullUrl]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                
                NSError *jsonError;
                NSMutableDictionary *dJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                
                if (error != nil) {
                    if (failure != nil) {
                        failure(error);
                    }
                    
                    return;
                }
                
                if (jsonError != nil) {
                    if (failure != nil) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            failure(jsonError);
                        });
                    }
                    return;
                }
                
                if (success != nil) {
                    NSString *description = [dJSON[@"weather"] firstObject][@"description"];
                    
                    NSString *min = [[NSString alloc] initWithFormat:@"%.2f",kelvinToCelcius(  [dJSON[@"main"][@"temp_min"] floatValue]  )];
                    
                    NSString *max = [[NSString alloc] initWithFormat:@"%.2f",kelvinToCelcius(  [dJSON[@"main"][@"temp_max"] floatValue]  )];
                    
                    NSString *current = [[NSString alloc] initWithFormat:@"%.2f",kelvinToCelcius(  [dJSON[@"main"][@"temp"] floatValue]  )];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        success(@{@"min": min, @"max": max, @"current": current, @"description": description});
                    });
                    
                }
                
            }] resume];
    
    
    
}


@end
