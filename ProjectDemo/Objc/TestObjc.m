//
//  TestObjc.m
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 15/11/2022.
//

#import <Foundation/Foundation.h>
#import "TestObjc.h"

@implementation TestObjc

-(instancetype) init {
    self = [super init];
    return self;
}

-(void) changeValue {
    _value = @"123";
}

-(void) changeValue:(NSString*) newValue {
    _value = newValue;
}

@end
