//
//  LxxPlaySound.h
//  Masonry_demo
//
//  Created by denglong on 5/6/16.
//  Copyright © 2016 邓龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface LxxPlaySound : NSObject
{
    SystemSoundID soundID;
}

/**
 * 为播放震动效果初始化
 * @param none
 * @return none
 */
-(id)initForPlayingVibrate;
-(id)initForPlayingSound;

/**
 * 为播放系统音效初始化(无需提供音频文件)
 * @param 系统音效名称
 * @return 系统音效类型
 */
-(id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type;

/**
 * 为播放特定的音频文件初始化（需提供音频文件）
 * @param 音频文件名（加在工程中）
 * @return none
 */
-(id)initForPlayingSoundEffectWith:(NSString *)filename;

/**
 * 播放音效
 * @param none
 * @return none
 */
-(void)play;

/**
 * 关闭音效
 * @param none
 * @return none
 */
-(void)closed;

@end
