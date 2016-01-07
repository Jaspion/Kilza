//
//  Base.m
//
//  Created on 2016-01-07
//  Copyright (c) 2016. All rights reserved.
//

#import "Base.h"
#import "Spa_ce.h"
#import "Special.h"
#import "Arrnull.h"
#import "Obj.h"
#import "Arrobj.h"

// Original names
NSString * const kBase_id = @"_id";
NSString * const kBaseStr = @"str";
NSString * const kBaseNum = @"num";
NSString * const kBaseFlo = @"flo";
NSString * const kBaseBoo = @"boo";
NSString * const kBaseSpa_ce = @"spa ce";
NSString * const kBaseSpecial = @"special";
NSString * const kBaseArrdouble = @"arrdouble";
NSString * const kBaseArrnum = @"arrnum";
NSString * const kBaseArrstr = @"arrstr";
NSString * const kBaseArrboo = @"arrboo";
NSString * const kBaseArrnull = @"arrnull";
NSString * const kBaseObj = @"obj";
NSString * const kBaseArrobj = @"arrobj";

@interface Base ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Base

+ (Base *)modelWithDictionary:(NSDictionary *)dict
{
  Base *instance = [[Base alloc] initWithDictionary:dict];
  return instance;
}

+ (Base *)modelWithString:(NSString *)json
{
  Base *instance = [[Base alloc] initWithString:json];
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
    self._id = [self objectOrNilForKey:kBase_id fromDictionary:dict];
    self.str = [self objectOrNilForKey:kBaseStr fromDictionary:dict];
    self.num = [self objectOrNilForKey:kBaseNum fromDictionary:dict];
    self.flo = [self objectOrNilForKey:kBaseFlo fromDictionary:dict];
    self.boo = [self objectOrNilForKey:kBaseBoo fromDictionary:dict];
    self.spa_ce = [self objectOrNilForKey:kBaseSpa_ce fromDictionary:dict];
    self.special = [self objectOrNilForKey:kBaseSpecial fromDictionary:dict];
    self.arrdouble = [self objectOrNilForKey:kBaseArrdouble fromDictionary:dict];
    self.arrnum = [self objectOrNilForKey:kBaseArrnum fromDictionary:dict];
    self.arrstr = [self objectOrNilForKey:kBaseArrstr fromDictionary:dict];
    self.arrboo = [self objectOrNilForKey:kBaseArrboo fromDictionary:dict];
    self.arrnull = [self objectOrNilForKey:kBaseArrnull fromDictionary:dict];
    self.obj = [self objectOrNilForKey:kBaseObj fromDictionary:dict];
    self.arrobj = [self objectOrNilForKey:kBaseArrobj fromDictionary:dict];
  }
  return self;
}

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];

  [mutableDict setValue:self._id forKey:kBase_id];
  [mutableDict setValue:self.str forKey:kBaseStr];
  [mutableDict setValue:self.num forKey:kBaseNum];
  [mutableDict setValue:self.flo forKey:kBaseFlo];
  [mutableDict setValue:self.boo forKey:kBaseBoo];
  [mutableDict setValue:self.spa_ce forKey:kBaseSpa_ce];
  [mutableDict setValue:self.special forKey:kBaseSpecial];
  [mutableDict setValue:self.arrdouble forKey:kBaseArrdouble];
  [mutableDict setValue:self.arrnum forKey:kBaseArrnum];
  [mutableDict setValue:self.arrstr forKey:kBaseArrstr];
  [mutableDict setValue:self.arrboo forKey:kBaseArrboo];
  [mutableDict setValue:self.arrnull forKey:kBaseArrnull];
  [mutableDict setValue:self.obj forKey:kBaseObj];
  [mutableDict setValue:self.arrobj forKey:kBaseArrobj];

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

  self._id = [aDecoder decodeObjectForKey:kBase_id];
  self.str = [aDecoder decodeObjectForKey:kBaseStr];
  self.num = [aDecoder decodeObjectForKey:kBaseNum];
  self.flo = [aDecoder decodeObjectForKey:kBaseFlo];
  self.boo = [aDecoder decodeObjectForKey:kBaseBoo];
  self.spa_ce = [aDecoder decodeObjectForKey:kBaseSpa_ce];
  self.special = [aDecoder decodeObjectForKey:kBaseSpecial];
  self.arrdouble = [aDecoder decodeObjectForKey:kBaseArrdouble];
  self.arrnum = [aDecoder decodeObjectForKey:kBaseArrnum];
  self.arrstr = [aDecoder decodeObjectForKey:kBaseArrstr];
  self.arrboo = [aDecoder decodeObjectForKey:kBaseArrboo];
  self.arrnull = [aDecoder decodeObjectForKey:kBaseArrnull];
  self.obj = [aDecoder decodeObjectForKey:kBaseObj];
  self.arrobj = [aDecoder decodeObjectForKey:kBaseArrobj];

  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
  [aCoder encodeObject:__id forKey:kBase_id];
  [aCoder encodeObject:_str forKey:kBaseStr];
  [aCoder encodeObject:_num forKey:kBaseNum];
  [aCoder encodeObject:_flo forKey:kBaseFlo];
  [aCoder encodeObject:_boo forKey:kBaseBoo];
  [aCoder encodeObject:_spa_ce forKey:kBaseSpa_ce];
  [aCoder encodeObject:_special forKey:kBaseSpecial];
  [aCoder encodeObject:_arrdouble forKey:kBaseArrdouble];
  [aCoder encodeObject:_arrnum forKey:kBaseArrnum];
  [aCoder encodeObject:_arrstr forKey:kBaseArrstr];
  [aCoder encodeObject:_arrboo forKey:kBaseArrboo];
  [aCoder encodeObject:_arrnull forKey:kBaseArrnull];
  [aCoder encodeObject:_obj forKey:kBaseObj];
  [aCoder encodeObject:_arrobj forKey:kBaseArrobj];
}

- (id)copyWithZone:(NSZone *)zone
{
  Base *copy = [[Base alloc] init];
  if (copy)
  {
    copy._id = [self._id copyWithZone:zone];
    copy.str = [self.str copyWithZone:zone];
    copy.num = [self.num copyWithZone:zone];
    copy.flo = [self.flo copyWithZone:zone];
    copy.boo = [self.boo copyWithZone:zone];
    copy.spa_ce = [self.spa_ce copyWithZone:zone];
    copy.special = [self.special copyWithZone:zone];
    copy.arrdouble = [self.arrdouble copyWithZone:zone];
    copy.arrnum = [self.arrnum copyWithZone:zone];
    copy.arrstr = [self.arrstr copyWithZone:zone];
    copy.arrboo = [self.arrboo copyWithZone:zone];
    copy.arrnull = [self.arrnull copyWithZone:zone];
    copy.obj = [self.obj copyWithZone:zone];
    copy.arrobj = [self.arrobj copyWithZone:zone];
  }

  return copy;
}

@end
