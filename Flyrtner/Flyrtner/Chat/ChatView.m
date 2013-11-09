//
//  ChatView.m
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import "ChatView.h"

@interface ChatView ()

@end

@implementation ChatView{
    SRWebSocket *_webSocket;
    NSMutableArray *_messages;
    Person *person;
    Flight *flight;
    NSString *userId;
    NSString *username;
    BOOL clickOnInput;
    NSString *room;
    NSDate *lastMessageReceivedDate;
    BOOL isLoad;
}

@synthesize tableView;
@synthesize inputText;
@synthesize inputView = _inputView;
@synthesize noMessagesLabel;

@synthesize infoSegue;

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)roomCreateDidEndWithFailure:(id)response
{
    NSLog(@"roomCreateDidEndWithFailure: ERROR");
    [self performSegueWithIdentifier:@"toProgramChat" sender:self];
}

- (void)viewDidLoad;
{
    [super viewDidLoad];
    
    // Set title and subtitle
    CGRect frame = self.navigationController.navigationBar.frame;
    
    UIView *twoLineTitleView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame), 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 6, CGRectGetWidth(frame), 20)];
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleLabel setTextColor:[UIColor whiteColor]];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [titleLabel setShadowColor:[UIColor grayColor]];
    titleLabel.text = person.name;
    [twoLineTitleView addSubview:titleLabel];
    
    UILabel *subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 26, CGRectGetWidth(frame), 14)];
    subTitleLabel.backgroundColor = [UIColor clearColor];
    [subTitleLabel setTextColor:[UIColor whiteColor]];
    subTitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [subTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [subTitleLabel setFont:[UIFont boldSystemFontOfSize:12]];
    [titleLabel setShadowColor:[UIColor grayColor]];
    subTitleLabel.text = @"subtitleg";
    [twoLineTitleView addSubview:subTitleLabel];
    
    self.navigationItem.titleView = twoLineTitleView;
    
    // Start messages
    // Si no hemos inicializado los mensajes de esta conversación, inicializamos la variable
    if (_messages == nil){
        _messages = [[NSMutableArray alloc] init];
    }
    
    [self.tableView reloadData];
    
    [self _reconnect];
}

- (void)_reconnect;
{
    _webSocket.delegate = nil;
    [_webSocket close];
    
    flight = [infoSegue objectForKey:@"FLIGHT"];
    userId = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
    username = [[NSUserDefaults standardUserDefaults]objectForKey:PROFILE_NAME];
    username = [username stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    NSString *url = [NSString stringWithFormat:@"ws://%@/room/chat?username=%@&userId=%@&pid=%@&typeChat=%@",URL_API_CHAT,username,userId,flight.flightNumber,@"2"];
    
    NSLog(url);
    
    _webSocket = [[SRWebSocket alloc] initWithURLRequest:
                  [NSURLRequest requestWithURL:
                   [NSURL URLWithString:url]]];
    
    _webSocket.delegate = self;
    
    //self.title = @"Opening Connection...";
    [[self.navigationItem.titleView.subviews objectAtIndex:1] setText:@"Conectando..."];
    
    [_webSocket open];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self _reconnect];
}

- (void)reconnect:(id)sender;
{
    [self _reconnect];
}

- (void)viewDidAppear:(BOOL)animated;
{
    [super viewDidAppear:animated];
    
    NSObject *userIdExists = [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
    if (userIdExists){
        // Si estas logueado te dejamos hablar ;)
        
        // We subscribe to the notification when the app returns from background
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationWillEnterForeground:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
        
        userId = [[NSUserDefaults standardUserDefaults]objectForKey:@"username"];
        
        // For resizing tableView
        clickOnInput = FALSE;  // Control of click in inputText
        [tableView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];   // Offset for tableView cells
        self.view.autoresizesSubviews = UIViewAutoresizingFlexibleHeight;   //
        
        [inputText setDelegate:self];
        [tableView setDataSource:self];
        [tableView setDelegate:self];
        
        
        // Get information from segue
        person = [infoSegue objectForKey:@"PERSON"]; // Person to talk
        flight = [infoSegue objectForKey:@"FLIGHT"];   // Program info
    } else {
        // Si no estas logueado
        //[self performSegueWithIdentifier:@"toLogin" sender:self];
    }

    [_inputView becomeFirstResponder];
    
    [self scrollBottom];
}


-(void)backButtonTapped:(id)sender
{
	[self.navigationController popToRootViewControllerAnimated:YES];
	
}


- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
    
    _webSocket.delegate = nil;
    [_webSocket close];
    _webSocket = nil;
}

#pragma mark - UITableViewController


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return _messages.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;
{
    ConversationCell *conversartionCell = (id)cell;
    Message *message = [_messages objectAtIndex:indexPath.row];
    conversartionCell.message.text = message.message;
    conversartionCell.name.text = message.author;
    UIImage *image = [UIImage imageWithData:message.image];
    [conversartionCell.image setImage:image];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    Message *message = [_messages objectAtIndex:indexPath.row];
    
    //return [self.tableView dequeueReusableCellWithIdentifier:message.fromMe ? @"SentCell" : @"ReceivedCell"];
    return [self.tableView dequeueReusableCellWithIdentifier:message.fromMe ? @"YourCell" : @"OtherCell"];
}

#pragma mark - SRWebSocketDelegate

- (void)webSocketDidOpen:(SRWebSocket *)webSocket;
{
    NSLog(@"Websocket Connected");
    //self.title = @"Connected!";
    [[self.navigationItem.titleView.subviews objectAtIndex:1] setText:@"Conectado"];
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error;
{
    NSLog(@":( Websocket Failed With Error %@", error);
    
    self.title = @"Connection Failed! (see logs)";
    _webSocket = nil;
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message;
{
    NSLog(@"Received \"%@\"", message);
    NSError *e;
    NSDictionary *allJSON =
    [NSJSONSerialization JSONObjectWithData: [message dataUsingEncoding:NSUTF8StringEncoding]
                                    options: NSJSONReadingMutableContainers
                                      error: &e];
    
    NSString *kindJSON = [allJSON objectForKey:@"kind"];
    NSString *userJSON = [allJSON objectForKey:@"user"];
    NSString *messageJSON = [allJSON objectForKey:@"message"];
    NSArray *membersJSON = [allJSON objectForKey:@"members"];
    
    DateFactory *dateFactory = [DateFactory alloc];
    NSString *formatDate = @"dd/MM/YYYY HH:mm";
    NSString *dateString = [dateFactory dateToString:[NSDate date] withFormat:formatDate];
    
    DBMessageManager *dbMessageManager = [[DBMessageManager alloc] init];
    NSDictionary *messageInfo = nil;
    
    switch([@[@"join", @"talk", @"quit", @"type", @"error"] indexOfObject:kindJSON]){
            // join
        case 0:
            if ([membersJSON count] > 0) {
                [[self.navigationItem.titleView.subviews objectAtIndex:1] setText:@"En línea"];
            } else {
                [[self.navigationItem.titleView.subviews objectAtIndex:1] setText:@"Sin conexión"];
            }
            
            break;
            // talk
        case 1:
            if (![userJSON isEqual: userId]){
                // Al recibir el primer mensaje, ocultamos los mensajes de no hay mensajes
                if ([_messages count] == 0) {
                    [noMessagesLabel setHidden:true];
                }
                
                //NSURL* imageURL = [NSURL URLWithString:person.image];
                //NSData *authorImage = [[NSData alloc] initWithContentsOfURL:imageURL];
                [_messages addObject:[[Message alloc] initWithMessage:messageJSON fromMe:NO author:userJSON image:nil]];
                
                [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_messages.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                
                [self.tableView scrollRectToVisible:self.tableView.tableFooterView.frame animated:YES];
                
                // Go down the scroll to the last message
                [self scrollBottom];
                
                // Creamos el mensaje a guardar en la base de datos
                messageInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                               messageJSON, @"message",
                               @"0", @"messageId",
                               @"true", @"send",
                               @"0", @"size",
                               kindJSON, @"type",
                               userJSON, @"userFrom",
                               room, @"chatId",
                               @"false", @"mine",
                               nil];
            }
            break;
            // quit
        case 2:
            [[self.navigationItem.titleView.subviews objectAtIndex:1] setText:
             [NSString stringWithFormat:@"Últ. vez %@", dateString]];
            break;
            // send
        case 3:
            [[self.navigationItem.titleView.subviews objectAtIndex:1] setText:@"Escribiendo..."];
            break;
            // error
        case 4:
            break;
    }
    
    // ENRI:TEST
    // Si se recibió algún mensaje que deba ser guardado en la base de datos local,
    // lo guardamos
//    if (messageInfo){
//        [dbMessageManager saveMessage:messageInfo inChat:room];
//    }
    
    // ENRI:TEST
    // Comprobar si hay que quitar el mensaje Escribiendo
    NSDate *nowDate = [NSDate date];    // Pillamos la hora actual
    if ([lastMessageReceivedDate timeIntervalSinceDate:nowDate] > 5){
        [[self.navigationItem.titleView.subviews objectAtIndex:1] setText:[self lastConnection:lastMessageReceivedDate]];
    }
    lastMessageReceivedDate = nowDate;
    
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(NSString *)reason wasClean:(BOOL)wasClean;
{
    NSLog(@"WebSocket closed");
    //self.title = @"Connection Closed! (see logs)";
    [[self.navigationItem.titleView.subviews objectAtIndex:1] setText:@"Offline"];
    _webSocket = nil;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
    if ([text rangeOfString:@"\n"].location != NSNotFound) {
        NSString *message = [[textView.text stringByReplacingCharactersInRange:range withString:text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [_webSocket send:message];
        
        NSString *authorImage = [[NSUserDefaults standardUserDefaults] objectForKey:PROFILE_IMAGE];
        
        [_messages addObject:[[Message alloc] initWithMessage:message fromMe:YES author:userId image:authorImage]];
        
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_messages.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView endUpdates];
        
        [self.tableView scrollRectToVisible:self.tableView.tableFooterView.frame animated:YES];
        
        textView.text = @"";
        return NO;
    }
    return YES;
}

- (void) animateTextField: (UITextField*) textField up: (BOOL)up
{
    const int movementDistance = 170;
    const float movementDuration = 0.3f;
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    
    [UIView commitAnimations];
}

- (IBAction)goingUp:(id)sender {
    [self animateTextField:inputText up:TRUE];
    CGRect rect = self.tableView.frame;
    rect.size.height = rect.size.height - 170;//218
    rect.origin.y = rect.origin.y + 170;
    self.tableView.frame = rect;
    clickOnInput = TRUE;
    [self scrollBottom];
}

- (IBAction)goingDown:(id)sender {
    if (clickOnInput){
        CGRect rect = self.tableView.frame;
        rect.size.height = rect.size.height + 170; //218
        rect.origin.y = rect.origin.y - 170;
        self.tableView.frame = rect;
        [self animateTextField:inputText up:FALSE];
        clickOnInput = FALSE;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (clickOnInput){
        //[self animateTextField:inputText up:FALSE];
    }
    [self sendMessage:inputText.text];
    [inputText resignFirstResponder];
    return [inputText resignFirstResponder]; // SI FALLA COMENTAR
}

// Send message
- (IBAction)send:(id)sender {
    if (clickOnInput){
        //[self animateTextField:inputText up:FALSE];
    }
    [self sendMessage:inputText.text];
}

- (void) sendMessage:(NSString *)text {
    if (![text isEqual:@""]){
        // Comprobamos si el mensaje es el primero que envia para ocultar lo de no mensajes
        if ([_messages count] == 0) {
            [noMessagesLabel setHidden:true];
        }
        
        // Mandamos el mensaje por sockets con el typo: text
        [_webSocket send:[NSString stringWithFormat:@"{\"text\":\"%@\"}",text]];
        
        NSString *authorImage = [[NSUserDefaults standardUserDefaults] objectForKey:@"profileImage"];
        
        [_messages addObject:[[Message alloc] initWithMessage:text fromMe:YES author:userId image:authorImage]];
        
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:_messages.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
        [self.tableView scrollRectToVisible:self.tableView.tableFooterView.frame animated:YES];
        
        // Go down the scroll to the last message
        [self scrollBottom];
        
        // Clear inputText after send a message
        inputText.text = @"";
        
        DBMessageManager *dbMessageManager = [[DBMessageManager alloc] init];
        NSDictionary *messageInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                     text, @"message",
                                     @"0", @"messageId",
                                     @"true", @"send",
                                     @"0", @"size",
                                     @"talk", @"type",
                                     [[NSUserDefaults standardUserDefaults]objectForKey:@"username"], @"userFrom",
                                     room, @"chatId",
                                     @"true", @"mine",
                                     nil];
        if (messageInfo){
            [dbMessageManager saveMessage:messageInfo inChat:room];
        }
    }
}

// Set the scroll in the last element of the conversation
-(void) scrollBottom {
    if ([_messages count] != 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[_messages count]-1 inSection:0];
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
}

- (void) refreshViews {
    if (clickOnInput){
        [self animateTextField:inputText up:FALSE];
        CGRect rect = self.tableView.frame;
        rect.size.height = rect.size.height + 218;
        self.tableView.frame = rect;
        [inputText resignFirstResponder];
        clickOnInput = FALSE;
    }
}

- (void) applicationWillEnterForeground:(NSNotification*) notification
{
    // This method will be called just before entering the foreground;
    // Do your stuff here
    [self refreshViews];
}

- (IBAction)editing:(id)sender {
    //[_webSocket send:[NSString stringWithFormat:@"{\"type\":\"0\"}"]];
}

// Calcula la string que debe aparecer con la última conexión del otro usuario
-(NSString *)lastConnection:(NSDate *)lastDate{
    return @"Últ. vez hoy a las 00:00";
}

@end
