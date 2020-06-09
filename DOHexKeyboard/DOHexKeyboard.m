//
//  DOHexKeyboard.m
//
//  Created by durian on 9/3/13.
//  Copyright (c) 2013 durian. All rights reserved.
//

#import "DOHexKeyboard.h"
#import "DOHexKeyboardConfiguration.h"

DOKeyboardKeyTapAction const DOKeyboardKeyTapAdd = ^(DOHexKeyboard *keyboard, UIButton *key) {
    id<UITextInput> input = keyboard.input;
    [keyboard textInput:input replaceTextAtTextRange:input.selectedTextRange withString:key.currentTitle];
};

DOKeyboardKeyTapAction const DOKeyboardKeyTapDelete = ^(DOHexKeyboard *keyboard, UIButton *key) {
    id<UITextInput> input = keyboard.input;
    
    UITextRange *selectedTextRange = input.selectedTextRange;
    // Calculate the selected text to delete
    UITextPosition  *startPosition = [input positionFromPosition:selectedTextRange.start offset:-1];
    if (!startPosition) {
        return;
    }
    UITextPosition *endPosition = selectedTextRange.end;
    if (!endPosition) {
        return;
    }
    UITextRange *rangeToDelete = [input textRangeFromPosition:startPosition toPosition:endPosition];
    [keyboard textInput:input replaceTextAtTextRange:rangeToDelete withString:@""];
};

DOKeyboardKeyTapAction const DOKeyboardKeyTapClear = ^(DOHexKeyboard *keyboard, UIButton *key) {
    id<UITextInput> input = keyboard.input;
    UITextRange *allTextRange = [input textRangeFromPosition:input.beginningOfDocument
                                                   toPosition:input.endOfDocument];
    [keyboard textInput:input replaceTextAtTextRange:allTextRange withString:@""];
};

DOKeyboardKeyTapAction const DOKeyboardKeyTapReturn = ^(DOHexKeyboard *keyboard, UIButton *key) {
    id<UITextInput> input = keyboard.input;
    
    if ([input isKindOfClass:[UITextField class]]) {
        id<UITextFieldDelegate> delegate = [(UITextField *)input delegate];
        if ([delegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
            [delegate textFieldShouldReturn:(UITextField *)input];
        }
    } else if ([input isKindOfClass:[UITextView class]]) {
        [keyboard textInput:input replaceTextAtTextRange:input.selectedTextRange withString:@"\n"];
    }
};

DOKeyboardLayoutBlock const DOKeyboardLayoutDefault = ^(DOHexKeyboard *keyboard, NSArray *keys) {
    id <DOKeyboardConfiguration> config = keyboard.configuration;
    
    CGSize keyboardSize = config.keyboardSize;
    keyboard.frame = CGRectMake(0, 0, keyboardSize.width, keyboardSize.height);
    
    UIEdgeInsets insets = config.insets;
    CGSize spacing = config.keySpacing;
    
    CGFloat horizontalInset = insets.left + insets.right;
    CGFloat horizontalSpacing = (config.columnCount - 1) * spacing.width;
    CGFloat keyWidth = floor((keyboardSize.width - (horizontalInset + horizontalSpacing)) / config.columnCount);
    
    CGFloat verticalInset = insets.top + insets.bottom;
    CGFloat verticalSpacing = (config.rowCount - 1) * spacing.height;
    CGFloat keyHeight = floor((keyboardSize.height - (verticalInset + verticalSpacing)) / config.rowCount);
    
    NSUInteger keyCount = config.keyCount;
    for (int i = 0; i < keyCount; i++) {
        UIButton *key = config.keyAtIndex(keyboard, i);
        
        DOKKeyFrame frame = config.frameOfKeyAtIndex(keyboard, i);
        DOKKeyOrigin origin = frame.origin;
        DOKKeySpan span = frame.span;
        
        CGFloat x = insets.left + origin.column * (keyWidth + spacing.width);
        CGFloat y = insets.top + origin.row * (keyHeight + spacing.height);
        
        CGFloat width;
        if (origin.column + span.column < config.columnCount) {
            width = span.row * (keyWidth + spacing.width) - spacing.width;
        } else {
            width = keyboardSize.width - (x + insets.right);
        }
        
        CGFloat height;
        if (origin.row + span.row < config.rowCount) {
            height = span.column * (keyHeight + spacing.height) - spacing.height;
        } else {
            height = keyboardSize.height - (y + insets.bottom);
        }
        
        key.frame = CGRectMake(x, y, width, height);
    }
};

@implementation DOHexKeyboard

- (instancetype)init {
    self = [super initWithFrame:CGRectZero inputViewStyle:UIInputViewStyleKeyboard];
    if (self) {
        _configuration = [[DOHexKeyboardConfiguration alloc] init];
        NSMutableArray *keys = [NSMutableArray array];
        for (int i = 0; i < _configuration.keyCount; i++) {
            UIButton *key = _configuration.keyAtIndex(self, i);
            [keys addObject:key];
        }
        _keys = [NSArray arrayWithArray:keys];
        [keys enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
            [self addSubview:obj];
            [obj addTarget:self action:@selector(keyTapped:) forControlEvents:UIControlEventTouchUpInside];
        }];
        _configuration.layout(self, keys);
    }
    
    return self;
}

- (void)setInput:(id<UITextInput>)input {
    _input = input;
    [_input performSelector:@selector(setInputView:) withObject:self];
}

- (NSUInteger)indexOfKey:(UIButton *)key {
    return [_keys indexOfObject:key];
}

- (void)keyTapped:(UIButton *)key {
    DOKeyboardKeyTapAction action = _configuration.keyTapped(self, key);
    action(self, key);
}


// Check delegate methods to see if we should change the characters in range
- (BOOL)textInput:(id <UITextInput>)textInput shouldChangeCharactersInRange:(NSRange)range withString:(NSString *)string
{
    if ([textInput isKindOfClass:[UITextField class]]) {
        UITextField *textField = (UITextField *)textInput;
        if ([textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            if (![textField.delegate textField:textField
                 shouldChangeCharactersInRange:range
                             replacementString:string]) {
                return NO;
            }
        }
    } else if ([textInput isKindOfClass:[UITextView class]]) {
        UITextView *textView = (UITextView *)textInput;
        if ([textView.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
            if (![textView.delegate textView:textView
                     shouldChangeTextInRange:range
                             replacementText:string]) {
                return NO;
            }
        }
    }
    return YES;
}

// Replace the text of the textInput in textRange with string if the delegate approves
- (void)textInput:(id <UITextInput>)textInput replaceTextAtTextRange:(UITextRange *)textRange withString:(NSString *)string {
    // Calculate the NSRange for the textInput text in the UITextRange textRange:
    NSInteger startPos = [textInput offsetFromPosition:textInput.beginningOfDocument
                                                         toPosition:textRange.start];
    NSInteger length = [textInput offsetFromPosition:textRange.start
                                                         toPosition:textRange.end];
    NSRange selectedRange = NSMakeRange(startPos, length);
    
    if ([self textInput:textInput shouldChangeCharactersInRange:selectedRange withString:string]) {
        // Make the replacement:
        [textInput replaceRange:textRange withText:string];
    }
}

@end
