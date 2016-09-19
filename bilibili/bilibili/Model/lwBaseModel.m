//
//  lwBaseModel.m
//  bilibili
//
//  Created by lw on 16/8/30.
//  Copyright © 2016年 lw. All rights reserved.
//

#import "lwBaseModel.h"

@implementation lwBaseModel

- (id)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSDictionary *)propertyValueForKey{
    return @{};
}

- (NSDictionary *)modelChangeToDictionary{
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    BOOL isIimplementation = class_respondsToSelector([self class],@selector(propertyValueForKey));
    
    NSAssert(isIimplementation, @"please implementation Method <propertyValueForKey> in you Class!");
    
    unsigned int outCount = 0;
    
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    
    for (int i = 0; i<outCount; i++) {
        
        Ivar ivar = *(ivars + i);
        
        NSString *key = [[NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding] substringFromIndex:1];
        
        NSString *realKey = [[self propertyValueForKey] valueForKeyPath:key];
        
        NSString *value = [self valueForKeyPath:key];
        
        [dict setValue:value forKey:realKey];
        
    }
    
    return dict;
}

- (void)objectChangeToModel:(id)object{
    
    BOOL isIimplementation = class_respondsToSelector([self class],@selector(propertyValueForKey));
    
    NSAssert(isIimplementation, @"please implementation Method <propertyValueForKey> in you Class!");

    unsigned int outCount = 0;
    
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    
    for (int i = 0; i<outCount; i++) {
        
        Ivar ivar = *(ivars + i);
        
        
        NSString *key = [[NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding] substringFromIndex:1];
        
        key = [[self propertyValueForKey] valueForKeyPath:key];
        
        object_setIvar(self, ivar, object[key]);
    }
}


+ (NSDictionary *)source:(NSString *)fileName Type:(NSString *)type{
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfFile:sourcePath(fileName, type)];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    return dict;
}

@end
