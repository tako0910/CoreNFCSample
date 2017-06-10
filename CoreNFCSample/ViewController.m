//
//  ViewController.m
//  CoreNFCSample
//
//  Created by tako on 2017/06/10.
//  Copyright © 2017年 tako. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - IB Actions
- (IBAction)btnRead:(id)sender
{
    if(!_ndefSession)
        _ndefSession = [[NFCNDEFReaderSession alloc] initWithDelegate:self queue:nil invalidateAfterFirstRead:NO];
    
    [_ndefSession beginSession];
}

#pragma mark - NFCNDEFReaderSessionDelegate
- (void)readerSession:(NFCNDEFReaderSession *)session didDetectNDEFs:(NSArray<NFCNDEFMessage *> *)messages
{
    NSLog(@"Called: %s", __func__);
    
    for(NFCNDEFMessage *message in messages)
    {
        for(NFCNDEFPayload *payload in message.records)
        {
            NSLog(@"TNF:%d", payload.typeNameFormat);
            NSLog(@"Type: %@", payload.type.description);
            NSLog(@"payload: %@", payload.payload.description);
            
            dispatch_async(dispatch_get_main_queue(),^{
                NSString *str =[NSString stringWithFormat:@"TNF: %d\nType: %@\nPayload: %@", payload.typeNameFormat, payload.type.description, payload.payload.description];
                [_labelResult setText:str];
            });
        }
    }
}

- (void)readerSession:(NFCNDEFReaderSession *)session didInvalidateWithError:(NSError *)error
{
    NSLog(@"Called: %s", __func__);
    NSLog(@"error: %@", error.localizedDescription);
    
    dispatch_async(dispatch_get_main_queue(),^{
        [_labelResult setText:error.localizedDescription];
    });
    
    _ndefSession = nil;
}

@end
