//
//  Base.m
//
//  Created on <%= Time.now.strftime("%Y-%m-%d") %>
//  Copyright (c) <%= Time.now.strftime("%Y") %>. All rights reserved.
//

#import "Base.h"
#import "Spa_ce.h"
#import "Special.h"
#import "Arrnull.h"
#import "Obj.h"
#import "Arrobj.h"

// Original names
NSString * const kBase_myid = @"id";
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
    self._myid = [self objectOrNilForKey:kBase_myid fromDictionary:dict];
    self.str = [self objectOrNilForKey:kBaseStr fromDictionary:dict];
    self.num = [self objectOrNilForKey:kBaseNum fromDictionary:dict];
    self.flo = [self objectOrNilForKey:kBaseFlo fromDictionary:dict];
    self.boo = [self objectOrNilForKey:kBaseBoo fromDictionary:dict];
    NSObject *objSpa_ce = [dict objectForKey:kBaseSpa_ce];
    {
      self.spa_ce = [Spa_ce modelWithDictionary:(NSDictionary *)objSpa_ce];
    }
    NSObject *objSpecial = [dict objectForKey:kBaseSpecial];
    {
      self.special = [Special modelWithDictionary:(NSDictionary *)objSpecial];
    }
    self.arrdouble = [self objectOrNilForKey:kBaseArrdouble fromDictionary:dict];
    self.arrnum = [self objectOrNilForKey:kBaseArrnum fromDictionary:dict];
    self.arrstr = [self objectOrNilForKey:kBaseArrstr fromDictionary:dict];
    self.arrboo = [self objectOrNilForKey:kBaseArrboo fromDictionary:dict];
    NSObject *objArrnull = [dict objectForKey:kBaseArrnull];
    if ([objArrnull isKindOfClass:[NSArray class]])
    {
      NSMutableArray *listArrnull = [NSMutableArray array];
      for (NSDictionary *item in (NSArray *)objArrnull) {
        if ([item isKindOfClass:[NSDictionary class]]) {
          [listArrnull addObject:[Arrnull modelWithDictionary:(NSDictionary *)item]];
        }
      }
      self.arrnull = listArrnull;
    }
    NSObject *objObj = [dict objectForKey:kBaseObj];
    {
      self.obj = [Obj modelWithDictionary:(NSDictionary *)objObj];
    }
    NSObject *objArrobj = [dict objectForKey:kBaseArrobj];
    if ([objArrobj isKindOfClass:[NSArray class]])
    {
      NSMutableArray *listArrobj = [NSMutableArray array];
      for (NSDictionary *item in (NSArray *)objArrobj) {
        if ([item isKindOfClass:[NSDictionary class]]) {
          [listArrobj addObject:[Arrobj modelWithDictionary:(NSDictionary *)item]];
        }
      }
      self.arrobj = listArrobj;
    }
  }
  return self;
}

- (NSDictionary *)dictionaryRepresentation
{
  NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];

  [mutableDict setValue:self._myid forKey:kBase_myid];
  [mutableDict setValue:self.str forKey:kBaseStr];
  [mutableDict setValue:self.num forKey:kBaseNum];
  [mutableDict setValue:self.flo forKey:kBaseFlo];
  [mutableDict setValue:self.boo forKey:kBaseBoo];
  if ([self.spa_ce respondsToSelector:@selector(dictionaryRepresentation)]) {
    [mutableDict setValue:[self.spa_ce performSelector:@selector(dictionaryRepresentation)] forKey:kBaseSpa_ce];
  } else {
    [mutableDict setValue:self.spa_ce forKey:kBaseSpa_ce];
  }
  if ([self.special respondsToSelector:@selector(dictionaryRepresentation)]) {
    [mutableDict setValue:[self.special performSelector:@selector(dictionaryRepresentation)] forKey:kBaseSpecial];
  } else {
    [mutableDict setValue:self.special forKey:kBaseSpecial];
  }
  [mutableDict setValue:self.arrdouble forKey:kBaseArrdouble];
  [mutableDict setValue:self.arrnum forKey:kBaseArrnum];
  [mutableDict setValue:self.arrstr forKey:kBaseArrstr];
  [mutableDict setValue:self.arrboo forKey:kBaseArrboo];
  NSMutableArray *tempArrayArrnull = [NSMutableArray array];
  for (NSObject *subArray in self.arrnull) {
    if ([subArray respondsToSelector:@selector(dictionaryRepresentation)]) {
       [tempArrayArrnull addObject:[subArray performSelector:@selector(dictionaryRepresentation)]];
    } else {
       [tempArrayArrnull addObject:subArray];
    }
  }
  [mutableDict setValue:[NSArray arrayWithArray:tempArrayArrnull] forKey:kBaseArrnull];
  if ([self.obj respondsToSelector:@selector(dictionaryRepresentation)]) {
    [mutableDict setValue:[self.obj performSelector:@selector(dictionaryRepresentation)] forKey:kBaseObj];
  } else {
    [mutableDict setValue:self.obj forKey:kBaseObj];
  }
  NSMutableArray *tempArrayArrobj = [NSMutableArray array];
  for (NSObject *subArray in self.arrobj) {
    if ([subArray respondsToSelector:@selector(dictionaryRepresentation)]) {
       [tempArrayArrobj addObject:[subArray performSelector:@selector(dictionaryRepresentation)]];
    } else {
       [tempArrayArrobj addObject:subArray];
    }
  }
  [mutableDict setValue:[NSArray arrayWithArray:tempArrayArrobj] forKey:kBaseArrobj];

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

  self._myid = [aDecoder decodeObjectForKey:kBase_myid];
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
  [aCoder encodeObject:__myid forKey:kBase_myid];
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
    copy._myid = [self._myid copyWithZone:zone];
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
