//
//  UILabel+Attribute.m
//  Masonry
//
//  Created by mac on 12/9/2018.
//

#import "UILabel+Attribute.h"

@implementation UILabel (Attribute)

- (void)setLineSpace:(CGFloat)lineSpace {
    NSString *content = self.text;
    NSMutableAttributedString *mutable_string = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [mutable_string addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, content.length)];
    
    self.attributedText = mutable_string;
}


- (void)setWordSpace:(CGFloat)wordSpace {
    NSString *content = self.text;
    NSMutableAttributedString *mutable_string = [[NSMutableAttributedString alloc] initWithString:content];
    [mutable_string addAttribute:NSKernAttributeName value:@(wordSpace) range:NSMakeRange(0, content.length)];
    self.attributedText = mutable_string;
}

@end
