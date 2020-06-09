//
//  DOHexKeyboardUtils.m
//  Sample
//
//  Created by olive on 1/8/14.
//  Copyright (c) 2014 durian. All rights reserved.
//

#import "DOHexKeyboardUtils.h"

CGSize const DOKKeyNormalSize = (CGSize){63, 53};
CGFloat const DOKKeyNormalSpace = 1;

UIImage *createImageWithColor(UIColor *color) {
    CGRect rect = CGRectMake(0.0f, 0.0f, 12.0f, 12.0f);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:5];
    [roundedRect fill];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)
                                 resizingMode:UIImageResizingModeTile];
};

UIButton *createKey(UIImage *background,
                    UIImage *highlightedBackground,
                    CGSize size,
                    UIImage *keyImage,
                    NSString *text,
                    UIColor *textColor,
                    UIFont *font) {
    UIButton *key = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = {CGPointZero, size};
    key.frame = frame;
    
    if (background) {
        [key setBackgroundImage:background forState:UIControlStateNormal];
    }
    if (highlightedBackground) {
        [key setBackgroundImage:highlightedBackground forState:UIControlStateHighlighted];
    }
    [key.layer setShadowColor:[UIColor blackColor].CGColor];
    [key.layer setShadowOffset:CGSizeMake(0, 1)];
    [key.layer setShadowOpacity:1];
    [key.layer setShadowRadius:0.5];
    
    if (keyImage) {
        [key setImage:keyImage forState:UIControlStateNormal];
    }
    if (text) {
        [key setTitle:text forState:UIControlStateNormal];
    }
    if (textColor) {
        [key setTitleColor:textColor forState:UIControlStateNormal];
        [key setTintColor:textColor];
    }
    if (font) {
        key.titleLabel.font = font;
    }
    
    return key;
};

static UIImage *background;
static UIImage *highlightedBackground;
static UIFont *fontForNumberNormal;
static UIFont *fontForNumberHex;
static UIFont *fontForText;
static UIColor *textColor;

void initializeKeyConfiguration() {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (background == nil) {
            background = createImageWithColor([UIColor colorWithWhite:0.7 alpha:0.5]);
            highlightedBackground = createImageWithColor([UIColor colorWithWhite:0.5 alpha:0.5]);
        }
        
        if (fontForNumberNormal == nil) {
            fontForNumberNormal = [UIFont fontWithName:@"HelveticaNeue-Light" size:29.5];
            fontForNumberHex = [UIFont fontWithName:@"HelveticaNeue-Light" size:28];
            fontForText = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
        }
        
        
        if (textColor == nil) {
            textColor = [UIColor colorWithWhite:1 alpha:1];
        }
    });
}

UIButton *createKeyWithHex(NSString *hexCharactor) {
    initializeKeyConfiguration();
    UIButton *key = createKey(background, highlightedBackground, CGSizeZero, nil, hexCharactor, textColor, fontForNumberHex);
    [key sizeToFit];
    return key;
}

UIButton *createKeyWithNormal(NSString *normalCharactor) {
    initializeKeyConfiguration();
    UIButton *key = createKey(background, highlightedBackground, CGSizeZero, nil, normalCharactor, textColor, fontForNumberNormal);
    [key sizeToFit];
    return key;
}

UIButton *createKeyWithText(NSString *longText) {
    initializeKeyConfiguration();
    UIButton *key = createKey(background, highlightedBackground, CGSizeZero, nil, longText, textColor, fontForText);
    [key sizeToFit];
    return key;
}

UIButton *createKeyWithImage(UIImage *image) {
    initializeKeyConfiguration();
    UIImage *templateImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *key = createKey(background, highlightedBackground, CGSizeZero, templateImage, nil, textColor, nil);
    [key sizeToFit];
    return key;
}


