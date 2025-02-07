//
//  TUIMergeMessageListController.h
//  Pods
//
//  Created by harvy on 2020/12/9.
//  Copyright © 2023 Tencent. All rights reserved.
//

#import <TIMCommon/TIMDefine.h>
#import <UIKit/UIKit.h>
#import "TUIBaseMessageControllerDelegate_Minimalist.h"
#import "TUIChatConversationModel.h"
#import "TUIMessageDataProvider_Minimalist.h"

NS_ASSUME_NONNULL_BEGIN

@interface TUIMergeMessageListController_Minimalist : UITableViewController

@property(nonatomic, weak) id<TUIBaseMessageControllerDelegate_Minimalist> delegate;
@property(nonatomic, strong) V2TIMMergerElem *mergerElem;
@property(nonatomic, copy) dispatch_block_t willCloseCallback;
@property(nonatomic, strong) TUIChatConversationModel *conversationData;
@property(nonatomic, strong) TUIMessageDataProvider_Minimalist *parentPageDataProvider;

@end

NS_ASSUME_NONNULL_END
