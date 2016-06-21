//
//  ApiManager.m
//  Login App
//
//  Created by Jaswanth Jeenu on 30/05/16.
//  Copyright © 2016 Jaswanth Jeenu. All rights reserved.
//

#import "ApiManager.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "AFURLResponseSerialization.h"

@implementation ApiManager

-(void)makeNetworkCallOfType:(NSString *)httpType withUrl:(NSString *)url andParameters:(NSDictionary *)parameters withCompletionHandler:(void (^)(id _Nullable))completion andWithFailureHandler:(void (^)(NSError *))failure {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSIndexSet *acceptableStatusCodes = manager.responseSerializer.acceptableStatusCodes;
    NSMutableIndexSet *mutableIndexSet = [acceptableStatusCodes mutableCopy];
    [mutableIndexSet addIndex:400];
    manager.responseSerializer.acceptableStatusCodes = mutableIndexSet;

    
    /*
     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     NSString *accessToken = [defaults stringForKey:@"access_token"];
     if(accessToken != nil) {
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"Bearer %@", accessToken] forHTTPHeaderField:@"Authorization"];
     }
     */
    
    // TODO: Replace the string with enums
    
    if([httpType isEqualToString:@"GET"]) {
        
        [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
            
            if(completion != nil) {
                completion(responseObject);
            }
        } failure:^(NSURLSessionTask *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            if(failure != nil) {
                failure(error);
            }
        }];
        
    } else if([httpType isEqualToString:@"POST"]) {
        
        // Create the request.
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
//        
//        // Specify that it will be a POST request
//        request.HTTPMethod = @"POST";
//        
//        // This is how we set header fields
//        [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Accept"];
//        
//        // Convert your data and set your request's HTTPBody property
//        NSString *stringData = [parameters description];
//        NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
//        request.HTTPBody = requestBodyData;
//        
//        // Create url connection and fire request
//        NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//        self.failure = failure;
//        self.completion = completion;

        
        [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if(completion != nil) {
                completion(responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"Response string: %@", task.response);
            NSLog(@"Response description: %@", task.response.description);
            NSLog(@"Error: %@", error);
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
            NSLog(@"status code: %li", (long)httpResponse.statusCode);
            
            if(failure != nil) {
                failure(error);
            }
        }];
    }
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *jsonString = [[NSString alloc] initWithData: _responseData encoding:NSUTF8StringEncoding];
    NSLog(@"Response Json : %@", jsonString);
    if(self.completion) {
        self.completion(_responseData);
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    if(self.failure) {
        self.failure(error);
    }
}

@end
