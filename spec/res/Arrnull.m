//
//  Arrnull.m
//
//  Created on 2016-01-07
//  Copyright (c) 2016. All rights reserved.
//

#import "Arrnull.h"

// Original names

@interface Arrnull ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Arrnull

+ (Arrnull *)modelWithDictionary:(NSDictionary *)dict
{
  Arrnull *instance = [[Arrnull alloc] initWithDictionary:dict];
  return instance;
}

+ (Arrnull *)modelWithString:(NSString *)json
{
  Arrnull *instance = [[Arrnull alloc] initWithString:json];
  return instance;
}

- (instancetype)initWithString:(NSString *)json
{
  self = [super init];

  NSError *jsonError = nil;
  NSData *objectData = [json dataUsingEncoding:NSUTF8StringEncoding];
  NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:objectData
                                      options:NSJSONReadingMutableContainers
                                        error:&jsonError];
  if (!jsonError)
    self = [self initWithDictionary:dict];

  return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
  self = [super init];

  if (self && [dict isKindOfClass:[NSDictionary class]])
  {
  }
  return self;
}

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];


  return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description
{
  return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
  id object = [dict objectForKey:aKey];
  return [object isEqual:[NSNull null]] ? nil : object;
}

#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
  self = [super init];


  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
}

- (id)copyWithZone:(NSZone *)zone
{
  Arrnull *copy = [[Arrnull alloc] init];
  if (copy)
  {
  }

  return copy;
}

@end
