//
//  TUIMergeMessageCellData_Minimalist.m
//  Pods
//
//  Created by harvy on 2020/12/9.
//  Copyright © 2023 Tencent. All rights reserved.
//

#import "TUIMergeMessageCellData_Minimalist.h"
#import <TIMCommon/TIMDefine.h>
#import "TUITextMessageCellData_Minimalist.h"

#ifndef CGFLOAT_CEIL
#ifdef CGFLOAT_IS_DOUBLE
#define CGFLOAT_CEIL(value) ceil(value)
#else
#define CGFLOAT_CEIL(value) ceilf(value)
#endif
#endif

@implementation TUIMergeMessageCellData_Minimalist

+ (TUIMessageCellData *)getCellData:(V2TIMMessage *)message {
    V2TIMMergerElem *elem = message.mergerElem;
    if (elem.layersOverLimit) {
        TUITextMessageCellData_Minimalist *limitCell =
            [[TUITextMessageCellData_Minimalist alloc] initWithDirection:(message.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming)];
        limitCell.content = TIMCommonLocalizableString(TUIKitRelayLayerLimitTips);
        return limitCell;
    }

    TUIMergeMessageCellData_Minimalist *relayData =
        [[TUIMergeMessageCellData_Minimalist alloc] initWithDirection:(message.isSelf ? MsgDirectionOutgoing : MsgDirectionIncoming)];
    relayData.title = elem.title;
    relayData.abstractList = [NSArray arrayWithArray:elem.abstractList];
    relayData.mergerElem = elem;
    relayData.reuseId = TRelayMessageCell_ReuserId;
    return relayData;
}

+ (NSString *)getDisplayString:(V2TIMMessage *)message {
    return [NSString stringWithFormat:@"[%@]", TIMCommonLocalizableString(TUIKitRelayChatHistory)];
}

- (Class)getReplyQuoteViewDataClass {
    return NSClassFromString(@"TUIMergeReplyQuoteViewData_Minimalist");
}

- (Class)getReplyQuoteViewClass {
    return NSClassFromString(@"TUIMergeReplyQuoteView_Minimalist");
}

- (CGSize)contentSize {
    CGRect rect = [[self abstractAttributedString] boundingRectWithSize:CGSizeMake(200 - 20, MAXFLOAT)
                                                                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                                context:nil];
    CGSize size = CGSizeMake(CGFLOAT_CEIL(rect.size.width), CGFLOAT_CEIL(rect.size.height) - 10);
    self.abstractSize = size;
    CGFloat height = size.height;
    if (height > TRelayMessageCell_Text_Height_Max) {
        self.abstractSize = CGSizeMake(size.width, size.height - (height - TRelayMessageCell_Text_Height_Max));
        height = TRelayMessageCell_Text_Height_Max;
    }
    UIFont *titleFont = [UIFont systemFontOfSize:16];
    height = (10 + titleFont.lineHeight + 3) + height + 1 + 5 + 20 + 5;
    return CGSizeMake(kScale390(250), height + self.msgStatusSize.height);
}

- (NSAttributedString *)abstractAttributedString {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 4;
    NSDictionary *attribute = @{
        NSForegroundColorAttributeName : [UIColor colorWithRed:187 / 255.0 green:187 / 255.0 blue:187 / 255.0 alpha:1 / 1.0],
        NSFontAttributeName : [UIFont systemFontOfSize:12.0],
        NSParagraphStyleAttributeName : style
    };

    NSMutableAttributedString *abstr = [[NSMutableAttributedString alloc] initWithString:@""];
    int i = 0;
    for (NSString *ab in self.abstractList) {
        if (i >= 4) {
            break;
        }
        NSString *str = [NSString stringWithFormat:@"%@\n", ab];
        [abstr appendAttributedString:[[NSAttributedString alloc] initWithString:str attributes:attribute]];
        i++;
    }
    return abstr;
}

@end
