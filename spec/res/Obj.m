//
//  Obj.m
//
//  Created on <%= Time.now.strftime("%Y-%m-%d") %>
//  Copyright (c) <%= Time.now.strftime("%Y") %>. All rights reserved.
//

#import "Obj.h"

// Original names
NSString * const kObjStr = @"str";
NSString * const kObjNum = @"num";
NSString * const kObjFlo = @"flo";
NSString * const kObjBoo = @"boo";

@interface Obj ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Obj

+ (Obj *)modelWithDictionary:(NSDictionary *)dict
{
  Obj *instance = [[Obj alloc] initWithDictionary:dict];
  return instance;
}

+ (Obj *)modelWithString:(NSString *)json
{
  Obj *instance = [[Obj alloc] initWithString:json];
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
    self.str = [self objectOrNilForKey:kObjStr fromDictionary:dict];
    self.num = [self objectOrNilForKey:kObjNum fromDictionary:dict];
    self.flo = [self objectOrNilForKey:kObjFlo fromDictionary:dict];
    self.boo = [self objectOrNilForKey:kObjBoo fromDictionary:dict];
  }
  return self;
}

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];

  [mutableDict setValue:self.str forKey:kObjStr];
  [mutableDict setValue:self.num forKey:kObjNum];
  [mutableDict setValue:self.flo forKey:kObjFlo];
  [mutableDict setValue:self.boo forKey:kObjBoo];

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

  self.str = [aDecoder decodeObjectForKey:kObjStr];
  self.num = [aDecoder decodeObjectForKey:kObjNum];
  self.flo = [aDecoder decodeObjectForKey:kObjFlo];
  self.boo = [aDecoder decodeObjectForKey:kObjBoo];

  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
  [aCoder encodeObject:_str forKey:kObjStr];
  [aCoder encodeObject:_num forKey:kObjNum];
  [aCoder encodeObject:_flo forKey:kObjFlo];
  [aCoder encodeObject:_boo forKey:kObjBoo];
}

- (id)copyWithZone:(NSZone *)zone
{
  Obj *copy = [[Obj alloc] init];
  if (copy)
  {
    copy.str = [self.str copyWithZone:zone];
    copy.num = [self.num copyWithZone:zone];
    copy.flo = [self.flo copyWithZone:zone];
    copy.boo = [self.boo copyWithZone:zone];
  }

  return copy;
}

@end
