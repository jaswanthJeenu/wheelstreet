//
//  WSTextField.m
//  Wheelstreet
//
//  Created by Jaswanth Jeenu on 04/06/16.
//  Copyright © 2016 Bashar Technologies Pvt Ltd. All rights reserved.
//

#import "WSTextField.h"

@implementation WSTextField

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        self.layer.borderWidth = 1.0f;
    }
    
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, TXT_FIELD_INSET, TXT_FIELD_INSET);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, TXT_FIELD_INSET, TXT_FIELD_INSET);
}


@end
