//
//  Spa_ce.m
//
//  Created on <%= Time.now.strftime("%Y-%m-%d") %>
//  Copyright (c) <%= Time.now.strftime("%Y") %>. All rights reserved.
//

#import "Spa_ce.h"

// Original names
NSString * const kSpa_ce_1one = @"1one";

@interface Spa_ce ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Spa_ce

+ (Spa_ce *)modelWithDictionary:(NSDictionary *)dict
{
  Spa_ce *instance = [[Spa_ce alloc] initWithDictionary:dict];
  return instance;
}

+ (Spa_ce *)modelWithString:(NSString *)json
{
  Spa_ce *instance = [[Spa_ce alloc] initWithString:json];
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
    self._1one = [self objectOrNilForKey:kSpa_ce_1one fromDictionary:dict];
  }
  return self;
}

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];

  [mutableDict setValue:self._1one forKey:kSpa_ce_1one];

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

  self._1one = [aDecoder decodeObjectForKey:kSpa_ce_1one];

  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
  [aCoder encodeObject:__1one forKey:kSpa_ce_1one];
}

- (id)copyWithZone:(NSZone *)zone
{
  Spa_ce *copy = [[Spa_ce alloc] init];
  if (copy)
  {
    copy._1one = [self._1one copyWithZone:zone];
  }

  return copy;
}

@end
