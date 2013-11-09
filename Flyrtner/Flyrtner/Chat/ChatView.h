//
//  ChatView.h
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlyrtnerApi.h"
#import "Flight.h"
#import "Person.h"
#import "ChatApi.h"
#import "Message.h"
#import "ConversationCell.h"
#import "DBMessageManager.h"
#import "DateFactory.h"
#import "SRWebSocket.h"

@interface ChatView : UIViewController <UITableViewDataSource, UITableViewDelegate, SRWebSocketDelegate, UITextViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) NSDictionary *infoSegue;

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UITextView *inputView;

- (IBAction)goingUp:(id)sender;
- (IBAction)goingDown:(id)sender;
- (IBAction)editing:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *inputText;

- (IBAction)send:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *noMessagesLabel;

@end
