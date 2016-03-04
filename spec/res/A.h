//
//  A.h
//
//  Created on <%= Time.now.strftime("%Y-%m-%d") %>
//  Copyright (c) <%= Time.now.strftime("%Y") %>. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface A : NSObject <NSCoding, NSCopying>


+ (A *)modelWithDictionary:(NSDictionary *)dict;
+ (A *)modelWithString:(NSString *)json;

- (instancetype)initWithString:(NSString *)json;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
