//
//  TestObjc.h
//  ProjectDemo
//
//  Created by Nguyễn Đạt on 15/11/2022.
//

#import <Foundation/Foundation.h>

@interface TestObjc : NSObject

@property int counter;
@property (nonatomic, strong) NSString *value;
-(void) changeValue;
-(void) changeValue:(NSString*) newValue;
@end
