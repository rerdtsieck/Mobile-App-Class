//
//  Person.m
//  RuntimeMsgDispatching
//
//  Created by cpsc on 10/22/16.
//  Copyright © 2016 cpsc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@implementation Person

@dynamic firstName;
@dynamic lastName;

- (void) setAttribute: (NSString *) attrib Value: (NSString *) value {
    NSLog(@"Runtime the setAttributeValue method is called with attrib: %@ value: %@", attrib, value);
}

- (NSString *) getAttributeValue: (NSString *) attib {
    NSString * value = @"Returned Value";
    
    NSLog(@"Runtime the getAttributeValue method is called with input: %@ ", attib);
    
    return value;
}

- (void)testFunctionCall1:(NSString *) inputString {
    NSLog(@"The Parameter passed in: %@", inputString);
}

- (void)forwardInvocation:(NSInvocation *)anInvocation OBJC_SWIFT_UNAVAILABLE("") {
    
    NSString *sel = NSStringFromSelector(anInvocation.selector);
    NSString * input = @"FirstName";
    NSString * param;
    NSMethodSignature *aSignature;
    NSInvocation *fInvocation;
    //
    NSLog(@"The original argument count: %ld", anInvocation.methodSignature.numberOfArguments);
    [anInvocation getArgument:&param atIndex:0];
    NSLog(@"The original argument 0: %@", param);
    if (anInvocation.methodSignature.numberOfArguments >= 3) {
        [anInvocation getArgument:&param atIndex:2];
        NSLog(@"The original argument 1: %@", param);
    }
    
    if ([sel rangeOfString:@"set"].location == 0) {
        // Forward to another method via NSInvocation
        aSignature = [Person instanceMethodSignatureForSelector:@selector(setAttribute:Value:)];
        //
        NSLog(@"Getting the forwarded method signature for: %@", NSStringFromSelector(@selector(setAttribute:Value:)));
        NSLog(@"Return type of the forwarded method: %s", aSignature.methodReturnType);
        NSLog(@"Number of Arguments of the forwarded method: %ld", aSignature.numberOfArguments);
        //
        fInvocation = [NSInvocation invocationWithMethodSignature:aSignature];
        [fInvocation setSelector:@selector(setAttribute:Value:)];
        [fInvocation setTarget:anInvocation.target];
        [fInvocation setArgument:&input atIndex:2];
        [anInvocation getArgument:&param atIndex:2];
        NSLog(@"The original argument: %@", param);
        [fInvocation setArgument:&param atIndex:3];
        [fInvocation invoke];
    } else if (![sel isEqualToString:@"testFunctionCall:"]) {
        //
        aSignature = [Person instanceMethodSignatureForSelector:@selector(getAttributeValue:)];
        //
        NSLog(@"Getting the forwarded method signature for: %@", NSStringFromSelector(@selector(getAttributeValue:)));
        NSLog(@"Return type of the forwarded method: %s", aSignature.methodReturnType);
        NSLog(@"Number of Arguments of the forwarded method: %ld", aSignature.numberOfArguments);
        //
        fInvocation = [NSInvocation invocationWithMethodSignature:aSignature];
        [fInvocation setSelector:@selector(getAttributeValue:)];
        [fInvocation setTarget:anInvocation.target];
        [fInvocation setArgument:&input atIndex:2];
        [fInvocation invoke];
        //
        void * retVal;
        [fInvocation getReturnValue:&retVal];
        NSLog(@"The value returned from the runtime method invocation: %@", retVal);
        //
        [anInvocation setReturnValue:&retVal];
    } else {
        //
        aSignature = [Person instanceMethodSignatureForSelector:@selector(testFunctionCall1:)];        //
        NSLog(@"Getting the forwarded method signature for: %@", NSStringFromSelector(@selector(testFunctionCall1:)));
        NSLog(@"Return type of the forwarded method: %s", aSignature.methodReturnType);
        NSLog(@"Number of Arguments of the forwarded method: %ld", aSignature.numberOfArguments);
        //
        fInvocation = [NSInvocation invocationWithMethodSignature:aSignature];
        [fInvocation setSelector:@selector(testFunctionCall1:)];
        [fInvocation setTarget:anInvocation.target];
        [anInvocation getArgument:&param atIndex:2];
        NSLog(@"The original argument: %@", param);
        [fInvocation setArgument:&param atIndex:2];
        [fInvocation invoke];
    }
    
    //void * retVal;
    //[anInvocation getReturnValue:&retVal];
    //NSLog(@"The value returned from the runtime method invocation: %@", retVal);
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    NSMethodSignature * m;
    NSString *sel = NSStringFromSelector(aSelector);
    
    if ([sel rangeOfString:@"set"].location == 0) {
        m = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    } else if (![sel isEqualToString:@"testFunctionCall:"]) {
        m = [NSMethodSignature signatureWithObjCTypes:"@@:"];
    } else m = [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    
    //
    NSLog(@"Getting the method signature for: %@", sel);
    NSLog(@"Class of the method: %@", m.className);
    NSLog(@"Return type of the method: %s", m.methodReturnType);
    NSLog(@"Number of Arguments of the method: %ld", m.numberOfArguments);
    
    //NSLog(@"Method Signature: %@", m);
    
    return m;
}

- (id)performSelector:(SEL)aSelector withObject:(id)object {
    NSLog(@"performSelector: %@ %@", NSStringFromSelector(aSelector), object);
    return [super performSelector:aSelector withObject:object];
}


@end
