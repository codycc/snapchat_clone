//
//  Header.h
//  devchatClone
//
//  Created by Cody Condon on 2016-10-17.
//  Copyright © 2016 Cody Condon. All rights reserved.
//

#ifndef Header_h
#define Header_h

@protocol CameraVCDelegate <NSObject>

-(void)shouldEnableRecordUI:(BOOL)enable;
-(void)shouldEnableCameraUI:(BOOL)enable;
-(void)canStartRecording;
-(void)recordingHasStarted;
@end

#endif /* Header_h */
