//
//  ComponentRendering.m
//  HybridPageKit
//
//  Created by dequanzhu.
//  Copyright © 2018 HybridPageKit. All rights reserved.
//

#import "ComponentRendering.h"
#import "HPKWebViewHandler.h"

@interface ComponentRendering ()
@property(nonatomic,copy,readwrite)NSString *componentIndex;
@property(nonatomic,strong,readwrite)GRMustacheTemplate *template;
@end

@implementation ComponentRendering

- (void)setComponentIndex:(NSString *)index{
    _componentIndex = index;
}

- (NSString *)renderForMustacheTag:(GRMustacheTag *)tag
                           context:(GRMustacheContext *)context
                          HTMLSafe:(BOOL *)HTMLSafe
                             error:(NSError **)error{

   RNSModel *RNSObj = [context valueForMustacheKey:_componentIndex];
    
    if (!RNSObj) {
        return @"";
    }
    
    if (!_template) {
        _template = [GRMustacheTemplate templateFromString:[HPKWebViewHandler componentHtmlTemplate] error:nil];
    }
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 16;
    CGFloat height = ceilf([RNSObj getComponentFrame].size.height/[RNSObj getComponentFrame].size.width * width);

    return [_template renderObject:@{@"componentIndex":[RNSObj getUniqueId],@"width":@(width),@"height":@(height)} error:nil] ;
}
@end
