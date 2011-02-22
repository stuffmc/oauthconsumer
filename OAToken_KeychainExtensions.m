//
//  OAToken_KeychainExtensions.m
//  TouchTheFireEagle
//
//  Created by Jonathan Wight on 04/04/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "OAToken_KeychainExtensions.h"
#import "SFHFKeychainUtils.h"

@implementation OAToken (OAToken_KeychainExtensions)

- (id)initWithKeychainUsingAppName:(NSString *)name serviceProviderName:(NSString *)provider 
{
    [super init];
    
    NSError *error = nil;
    NSString *keySecret = [SFHFKeychainUtils getPasswordForUsername:provider andServiceName:name error:&error];
    
    if (error != nil || keySecret == nil) {
        return nil;
    } else {
        NSArray *elements = [keySecret componentsSeparatedByString:@"-"];
        self.key = [elements objectAtIndex:0];
        self.secret = [elements objectAtIndex:1];
    }
    
    return self;
}


- (int)storeInDefaultKeychainWithAppName:(NSString *)name serviceProviderName:(NSString *)provider 
{
    NSError *error = nil;
    [SFHFKeychainUtils storeUsername:provider andPassword:[NSString stringWithFormat:@"%@-%@", key, secret] forServiceName:name updateExisting:YES error:&error];
    return error == nil;
}

@end
