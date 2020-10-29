//
//  DOHexKeyboardUtils.h
//  Sample
//
//  Created by olive on 1/8/14.
//  Copyright (c) 2014 durian. All rights reserved.
//

#import "DOHexKeyboard.h"

extern CGSize const DOKKeyNormalSize; // (63, 53)
extern CGFloat const DOKKeyNormalSpace; // 1

// Some helper fucntions
extern UIImage *createImageWithColor(UIColor *color);
extern UIButton *createKey(UIImage *background,
                           UIImage *highlightedBackground,
                           CGSize size,
                           UIImage *keyImage,
                           NSString *text,
                           UIColor *textColor,
                           UIFont *font);

extern UIButton *createKeyWithHex(NSString *hexCharactor, NSInteger theme);
extern UIButton *createKeyWithNormal(NSString *normalCharactor, NSInteger theme);
extern UIButton *createKeyWithText(NSString *longText, NSInteger theme);
extern UIButton *createKeyWithImage(UIImage *image, NSInteger theme);


