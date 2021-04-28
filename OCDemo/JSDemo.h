//
//  JSDemo.h
//  OCDemo
//
//  Created by Jimmy King on 2021/4/25.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>



NS_ASSUME_NONNULL_BEGIN

@protocol JSDelegate <JSExport>

-(void)scan:(NSString *)message;

@end

@interface JSDemo : NSObject

@property(nonatomic, weak) id<JSDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
