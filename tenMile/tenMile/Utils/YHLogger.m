//
//  YHLogger.m
//  YOHOBoard
//
//  Created by Louis Zhu on 13-1-30.
//  Copyright (c) 2013年 NewPower Co. All rights reserved.
//

#import "YHLogger.h"
#import "LoggerClient.h"


NSString * const kYHLoggerTagGeneral = @"general";
NSString * const kYHLoggerTagTesting = @"testing";
NSString * const kYHLoggerTagNetwork = @"network";
NSString * const kYHLoggerTagFileOperation = @"file operation";
NSString * const kYHLoggerTagTableView = @"table view";
NSString * const kYHLoggerTagViewController = @"view controller";


//static NSString * const kYHLoggerTagNetwork = @"network";


void YHLog(NSString *tag, YHLoggerLevel level, NSString *format, va_list args)
{
    LogMessageF_va(__FILE__, __LINE__, __FUNCTION__, tag, level, format, args);
    
#if 0
    va_list args;
    va_start(args, format);
    NSString *ppp = [@"Louis: " stringByAppendingFormat:format, args];
    if (developer == nil) {
//        message = [@"" stringByAppendingFormat:format, args];
        [ppp writeToFile:[kPathDocument stringByAppendingPathComponent:@"a.txt"] atomically:YES encoding:NSUTF8StringEncoding error:nil];
//        LogMessageToF_va(NULL, __FILE__, __LINE__, __FUNCTION__, tag, level, format, args);
    }
    else {
//        message = [[developer stringByAppendingString:@": "] stringByAppendingFormat:format, args];
//        NSString *message = [@"Lousiiii: " stringByAppendingFormat:format, args];
//        [message writeToFile:[kPathDocument stringByAppendingPathComponent:@"a.txt"] atomically:YES encoding:NSUTF8StringEncoding error:nil];
//        LogMessageToF_va(NULL, __FILE__, __LINE__, __FUNCTION__, tag, level, [@"%%@: " stringByAppendingString:format], developer, args);
//        LogMessageF(__FILE__, __LINE__, __FUNCTION__, tag, level, @"%@", message);
    }
    LogMessageF(__FILE__, __LINE__, __FUNCTION__, tag, level, @"%@", ppp);
    va_end(args);
#endif
}


void YHLogDoom(NSString *tag, NSString *format, ...)
{
    va_list args;
    va_start(args, format);
    YHLog(tag, YHLoggerLevelDoom, format, args);
    va_end(args);
}


void YHLogError(NSString *tag, NSString *format, ...)
{
    va_list args;
    va_start(args, format);
    YHLog(tag, YHLoggerLevelError, format, args);
    va_end(args);
}


void YHLogWarning(NSString *tag, NSString *format, ...)
{
    va_list args;
    va_start(args, format);
    YHLog(tag, YHLoggerLevelWarning, format, args);
    va_end(args);
}


void LZLog(NSString *tag, NSString *format, ...)
{
#if defined (DEBUG_LOUIS) || defined (ADHOC)
	va_list args;
	va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    LogMessageF(__FILE__, __LINE__, __FUNCTION__, tag, YHLoggerLevelInformation, @"Louis: %@", message);
	va_end(args);
#endif
}


void LZLogTesting(NSString *format, ...)
{
#if defined (DEBUG_LOUIS) || defined (ADHOC)
    va_list args;
    va_start(args, format);
    YHLog(kYHLoggerTagTesting, YHLoggerLevelTesting, format, args);
    va_end(args);
#endif
}


void SMLog(NSString *tag, NSString *format, ...)
{
#if defined (DEBUG_STUDY) || defined (ADHOC)
	va_list args;
	va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    LogMessageF(__FILE__, __LINE__, __FUNCTION__, tag, YHLoggerLevelInformation, @"Study: %@", message);
	va_end(args);
#endif
}


void SMLogTesting(NSString *format, ...)
{
#if defined (DEBUG_STUDY) || defined (ADHOC)
    va_list args;
    va_start(args, format);
    YHLog(kYHLoggerTagTesting, YHLoggerLevelTesting, format, args);
    va_end(args);
#endif
}


void LYLog(NSString *tag, NSString *format, ...)
{
#if defined (DEBUG_LANCE) || defined (ADHOC)
	va_list args;
	va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    LogMessageF(__FILE__, __LINE__, __FUNCTION__, tag, YHLoggerLevelInformation, @"Lance: %@", message);
	va_end(args);
#endif
}


void LYLogTesting(NSString *format, ...)
{
#if defined (DEBUG_LANCE) || defined (ADHOC)
    va_list args;
    va_start(args, format);
    YHLog(kYHLoggerTagTesting, YHLoggerLevelTesting, format, args);
    va_end(args);
#endif
}


void PLLog(NSString *tag, NSString *format, ...)
{
#if defined (DEBUG_LANCE) || defined (ADHOC)
	va_list args;
	va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    LogMessageF(__FILE__, __LINE__, __FUNCTION__, tag, YHLoggerLevelInformation, @"Lance: %@", message);
	va_end(args);
#endif
}


void PLLogTesting(NSString *format, ...)
{
#if defined (DEBUG_LANCE) || defined (ADHOC)
    va_list args;
    va_start(args, format);
    YHLog(kYHLoggerTagTesting, YHLoggerLevelTesting, format, args);
    va_end(args);
#endif
}


void SMYLog(NSString *tag, NSString *format, ...)
{
#if defined (DEBUG_JOEBO) || defined (ADHOC)
	va_list args;
	va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    LogMessageF(__FILE__, __LINE__, __FUNCTION__, tag, YHLoggerLevelInformation, @"Joebo: %@", message);
	va_end(args);
#endif
}


void SMYLogTesting(NSString *format, ...)
{
#if defined (DEBUG_JOEBO) || defined (ADHOC)
    va_list args;
    va_start(args, format);
    YHLog(kYHLoggerTagTesting, YHLoggerLevelTesting, format, args);
    va_end(args);
#endif
}


void HTLog(NSString *tag, NSString *format, ...)
{
#if defined (DEBUG_GRUBBY) || defined (ADHOC)
	va_list args;
	va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    LogMessageF(__FILE__, __LINE__, __FUNCTION__, tag, YHLoggerLevelInformation, @"Grubby: %@", message);
	va_end(args);
#endif
}


void HTLogTesting(NSString *format, ...)
{
#if defined (DEBUG_GRUBBY) || defined (ADHOC)
    va_list args;
    va_start(args, format);
    YHLog(kYHLoggerTagTesting, YHLoggerLevelTesting, format, args);
    va_end(args);
#endif
}


void HDDLog(NSString *tag, NSString *format, ...)
{
#if defined (DEBUG_TIGER) || defined (ADHOC)
	va_list args;
	va_start(args, format);
    NSString *message = [[NSString alloc] initWithFormat:format arguments:args];
    LogMessageF(__FILE__, __LINE__, __FUNCTION__, tag, YHLoggerLevelInformation, @"Tiger: %@", message);
	va_end(args);
#endif
}


void HDDLogTesting(NSString *format, ...)
{
#if defined (DEBUG_TIGER) || defined (ADHOC)
    va_list args;
    va_start(args, format);
    YHLog(kYHLoggerTagTesting, YHLoggerLevelTesting, format, args);
    va_end(args);
#endif
}


