//
//  DOHexKeyboardConfiguration.m
//  Sample
//
//  Created by olive on 1/7/14.
//  Copyright (c) 2014 durian. All rights reserved.
//

#import "DOHexKeyboardConfiguration.h"
#import "DOHexKeyboardUtils.h"


@interface DOHexKeyboardConfiguration () {
}


@end

@implementation DOHexKeyboardConfiguration

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _keyCount = 19;
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGSize keyboardSize = (CGSize){screenWidth, 216};
        _keyboardSize = keyboardSize;
        
        _insets = UIEdgeInsetsMake(12, 5, 5, 5);
        _keySpacing = CGSizeMake(6, 14);
        
        _columnCount = 5;
        _rowCount = 4;
        
        
        NSMutableArray *keys = [NSMutableArray array];
        NSMutableArray *keyFrames = [NSMutableArray array];
        // create and layout the top three rows
        NSArray *keyNames = @[@"7", @"8", @"9", @"A", @"B",
                              @"4", @"5", @"6", @"C", @"D",
                              @"1", @"2", @"3", @"E", @"F"];

        for (int row = 0; row < 3; row++) {
            for (int column = 0; column < 5; column++) {
                NSString *keyName = keyNames[row * 5 + column];
                BOOL isHex = [keyName compare:@"9"] == NSOrderedDescending;
                UIButton *key = isHex ? createKeyWithHex(keyName) : createKeyWithNormal(keyName);
                [keys addObject:key];
                DOKKeyFrame frame;
                frame.origin = (DOKKeyOrigin){row, column};
                frame.span = (DOKKeySpan){1, 1};
                [keyFrames addObject:[NSValue value:&frame withObjCType:@encode(DOKKeyFrame)]];
            }
        }
        
        // create "clear", "0", "delete" and "return" keys
        DOKKeyFrame frame;
        UIButton *clearKey = createKeyWithText(@"clear");
        clearKey.tag = DOKeyboardKeyTypeClear;
        frame = (DOKKeyFrame){3, 0, 1, 1};
        [keyFrames addObject:[NSValue value:&frame withObjCType:@encode(DOKKeyFrame)]];
        UIButton *zeroKey = createKeyWithNormal(@"0");
        zeroKey.tag = DOKeyboardKeyTypeAdd;
        frame = (DOKKeyFrame){3, 1, 1, 1};
        [keyFrames addObject:[NSValue value:&frame withObjCType:@encode(DOKKeyFrame)]];
        UIButton *deleteKey = createKeyWithImage([UIImage imageNamed:@"delete.png"]);
        deleteKey.tag = DOKeyboardKeytypeDelete;
        frame = (DOKKeyFrame){3, 2, 1, 1};
        [keyFrames addObject:[NSValue value:&frame withObjCType:@encode(DOKKeyFrame)]];
        UIButton *returnKey =  createKeyWithText(@"return");
        returnKey.tag = DOKeyboardKeyTypeReturn;
        frame = (DOKKeyFrame){3, 3, 1, 2};
        [keyFrames addObject:[NSValue value:&frame withObjCType:@encode(DOKKeyFrame)]];
        
        [keys addObjectsFromArray:@[clearKey, zeroKey, deleteKey, returnKey]];

        _keyAtIndex = ^(DOHexKeyboard *keyboard, NSUInteger index) {
            return keys[index];
        };
        _frameOfKeyAtIndex = ^(DOHexKeyboard *keyboard, NSUInteger index) {
            NSValue *value = keyFrames[index];
            DOKKeyFrame frame;
            [value getValue:&frame];
            return frame;
        };
        
        _layout = DOKeyboardLayoutDefault;
        
        _keyTapped = ^(DOHexKeyboard *keyboard, UIButton *key) {
            NSUInteger tag = key.tag;
            if (tag == DOKeyboardKeyTypeClear) {
                return DOKeyboardKeyTapClear;
            } else if (tag == DOKeyboardKeytypeDelete) {
                return DOKeyboardKeyTapDelete;
            } else if (tag == DOKeyboardKeyTypeReturn) {
                return DOKeyboardKeyTapReturn;
            } else {
                return DOKeyboardKeyTapAdd;
            }
        };
    }
    
    return self;
}

@end
