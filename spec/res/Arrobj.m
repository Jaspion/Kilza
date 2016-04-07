//
//  Arrobj.m
//
//  Created on <%= Time.now.strftime("%Y-%m-%d") %>
//  Copyright (c) <%= Time.now.strftime("%Y") %>. All rights reserved.
//

#import "Arrobj.h"

// Original names
NSString * const kArrobjStr = @"str";
NSString * const kArrobjNum = @"num";
NSString * const kArrobjFlo = @"flo";
NSString * const kArrobjBoo = @"boo";
NSString * const kArrobjNull = @"null";

@interface Arrobj ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Arrobj

+ (Arrobj *)modelWithDictionary:(NSDictionary *)dict
{
  Arrobj *instance = [[Arrobj alloc] initWithDictionary:dict];
  return instance;
}

+ (Arrobj *)modelWithString:(NSString *)json
{
  Arrobj *instance = [[Arrobj alloc] initWithString:json];
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
    self.str = [self objectOrNilForKey:kArrobjStr fromDictionary:dict];
    self.num = [self objectOrNilForKey:kArrobjNum fromDictionary:dict];
    self.flo = [self objectOrNilForKey:kArrobjFlo fromDictionary:dict];
    self.boo = [self objectOrNilForKey:kArrobjBoo fromDictionary:dict];
    self.null = [self objectOrNilForKey:kArrobjNull fromDictionary:dict];
  }
  return self;
}

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];

  [mutableDict setValue:self.str forKey:kArrobjStr];
  [mutableDict setValue:self.num forKey:kArrobjNum];
  [mutableDict setValue:self.flo forKey:kArrobjFlo];
  [mutableDict setValue:self.boo forKey:kArrobjBoo];
  [mutableDict setValue:self.null forKey:kArrobjNull];

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

  self.str = [aDecoder decodeObjectForKey:kArrobjStr];
  self.num = [aDecoder decodeObjectForKey:kArrobjNum];
  self.flo = [aDecoder decodeObjectForKey:kArrobjFlo];
  self.boo = [aDecoder decodeObjectForKey:kArrobjBoo];
  self.null = [aDecoder decodeObjectForKey:kArrobjNull];

  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
  [aCoder encodeObject:_str forKey:kArrobjStr];
  [aCoder encodeObject:_num forKey:kArrobjNum];
  [aCoder encodeObject:_flo forKey:kArrobjFlo];
  [aCoder encodeObject:_boo forKey:kArrobjBoo];
  [aCoder encodeObject:_null forKey:kArrobjNull];
}

- (id)copyWithZone:(NSZone *)zone
{
  Arrobj *copy = [[Arrobj alloc] init];
  if (copy)
  {
    copy.str = [self.str copyWithZone:zone];
    copy.num = [self.num copyWithZone:zone];
    copy.flo = [self.flo copyWithZone:zone];
    copy.boo = [self.boo copyWithZone:zone];
    copy.null = [self.null copyWithZone:zone];
  }

  return copy;
}

@end
