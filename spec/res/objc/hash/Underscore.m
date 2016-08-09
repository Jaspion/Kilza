//
//  Underscore.m
//
//  Created on <%= Time.now.strftime("%Y-%m-%d") %>
//  Copyright (c) <%= Time.now.strftime("%Y") %>. All rights reserved.
//  Generated by Kilza https://github.com/Jaspion/Kilza
//

#import "Underscore.h"

// Original names
NSString *const kUnderscore_ = @"_";

@interface Underscore ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Underscore

+ (Underscore *)modelWithDictionary:(NSDictionary *)dict {
    Underscore *instance = [[Underscore alloc] initWithDictionary:dict];
    return instance;
}

+ (Underscore *)modelWithString:(NSString *)json {
    Underscore *instance = [[Underscore alloc] initWithString:json];
    return instance;
}

- (instancetype)initWithString:(NSString *)json {
    self = [super init];

    if (![[json stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] hasPrefix:@"{"])
        json = [NSString stringWithFormat:@"{ \"%@\" : %@ }", kUnderscore_, json];

    NSError *jsonError = nil;
    NSData *objectData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:objectData
                                                         options:NSJSONReadingMutableContainers
                                                           error:&jsonError];
    if (!jsonError)
        self = [self initWithDictionary:dict];

    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];

    if (self && [dict isKindOfClass:[NSDictionary class]]) {
        self._ = [self objectOrNilForKey:kUnderscore_ fromDictionary:dict];
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];

    [mutableDict setValue:self._ forKey:kUnderscore_];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];

    self._ = [aDecoder decodeObjectForKey:kUnderscore_];

    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:__ forKey:kUnderscore_];
}

- (id)copyWithZone:(NSZone *)zone {
    Underscore *copy = [[Underscore alloc] init];
    if (copy) {
        copy._ = [self._ copyWithZone:zone];
    }

    return copy;
}

@end