//
//  GGUtil.m
//  DailyMovieReview
//
//  Created by gump on 11-5-13.
//  Copyright 2011年 f4 . All rights reserved.
//

#import "GGUtil.h"
#import <objc/runtime.h>
@import SystemConfiguration;
@import MessageUI;
#import "GGMacros.h"

static NSDateFormatter *g_dayDateFormatter;

@implementation GGUtil

+ (void)load
{
    g_dayDateFormatter = [[NSDateFormatter alloc] init];
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    NSError *error = nil;
    BOOL success = [URL setResourceValue:@YES
                                  forKey:NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        DLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

#pragma mark -
#pragma mark Image
+(UIImage *)imageMono:(UIImage *)originalImage{    
    
    CGColorSpaceRef colorSapce = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, originalImage.size.width, originalImage.size.height, 8, originalImage.size.width, colorSapce, kCGBitmapAlphaInfoMask);

    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextSetShouldAntialias(context, NO);
    CGContextDrawImage(context, CGRectMake(0, 0, originalImage.size.width, originalImage.size.height), [originalImage CGImage]);
    
    CGImageRef bwImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSapce);
    
    UIImage *returnImage = [UIImage imageWithCGImage:bwImage]; // This is result B/W image.
    CGImageRelease(bwImage);
    

    return returnImage;
}

+ (UIImage*)cropImage:(UIImage*)img withRect:(CGRect)rect{
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // translated rectangle for drawing sub image
    CGRect drawRect = CGRectMake(-rect.origin.x, -rect.origin.y, img.size.width, img.size.height);
    
    // clip to the bounds of the image context
    // not strictly necessary as it will get clipped anyway?
    CGContextClipToRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
    
    // draw image
    [img drawInRect:drawRect];
    
    // grab image
    UIImage* subImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return subImage;
}


+ (UIImage *)makeAShotWithView:(UIView*)aView
{
    UIGraphicsBeginImageContextWithOptions(aView.bounds.size, YES, [UIScreen mainScreen].scale);
    [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *rtImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return rtImage;
}


+(CGSize)getScaleRect:(CGSize)originSize targetSize:(CGSize)maxSize{
    CGFloat width=originSize.width;
    CGFloat height=originSize.height;
    
    CGFloat wSize=width/maxSize.width;
    CGFloat hSize=height/maxSize.height;
    
    CGFloat currSize= wSize > hSize ? wSize : hSize;
    
    CGFloat finelWidth=width/currSize;
    CGFloat finelHeight=height/currSize;
    
    return CGSizeMake(finelWidth, finelHeight);
}

static const char *getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T') {
            //fprintf(stdout, "%s \n",attribute);
            if (attribute[1] == '@'){
                    return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
            }
        }
    }
    return "";
}

+ (NSMutableDictionary *)getClassPropertys:(id)fromClass {
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([fromClass class], &outCount);
    for(i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *propName = property_getName(property);
        const char *propType = getPropertyType(property);
        if(propName) {
            
            NSString *propertyName = [NSString stringWithUTF8String:propName];
            NSString *propertyType = [NSString stringWithUTF8String:propType];
            if (propertyType) {
                [props setObject:propertyType forKey:propertyName];
            } 
        }
    }
    free(properties);
    return props;
}

#pragma mark -
#pragma mark Color
+ (UIColor *)randomColor
{
    static BOOL seeded = NO;
    if (!seeded) {
        seeded = YES;
        srandom((unsigned int)time(NULL));
    }
    CGFloat red = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

#pragma mark -
#pragma mark Dictionary
+ (NSMutableDictionary *)stringToDictionary:(NSString *)sourceString withSeparator:(NSString *)separator{
    NSArray *chunks = [sourceString componentsSeparatedByString: separator];
    NSMutableDictionary *stringDict=[NSMutableDictionary dictionary];
    
    for(NSString *chunk in chunks){        
        NSArray *keyValue=[chunk componentsSeparatedByString: @"="];      
        DLog(@"key:%@", [keyValue objectAtIndex:0]);
        DLog(@"value:%@", [keyValue objectAtIndex:1]);        
        [stringDict setValue:[keyValue objectAtIndex:1] forKey:[keyValue objectAtIndex:0]];
    }
    return stringDict;
}

#pragma mark -
#pragma mark System Check
+ (BOOL)canSendSMS{
    BOOL canSMS=NO;
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));    
    if (messageClass != nil) {
        if ([messageClass canSendText]) {
            canSMS=YES;
        } else {
            [GGUtil showAlert:NSLocalizedString(@"Device can not use SMS.",@"") 
                      title:NSLocalizedString(@"Warning",@"")];
        }
    }
    return canSMS;

}


#pragma mark -
#pragma mark Alert
+ (void) showAlert: (NSString *) theMessage title:(NSString *) theTitle{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:theTitle message:theMessage delegate:nil cancelButtonTitle:NSLocalizedString(@"我知道了", @"") otherButtonTitles: nil];
    [av show]; 
}

#pragma mark -
#pragma mark URL
+ (NSString *)urlAppendRetina:(NSMutableString *)urlString{
    if ( isRetina) {
        NSRange range = [urlString rangeOfString:@"?"];
        if (range.length == 0) {
            [urlString appendString:@"?hd=1"];
        } else {
            [urlString appendString:@"&hd=1"];
        }
    }
    return  urlString;
}


#pragma mark -
#pragma mark Badge
+ (void)storeBadge{
    NSString *path = [APP_DOCUMENT stringByAppendingString:@"/badge"];
    NSString *badge = [NSString stringWithFormat:@"%ld", (long)[[UIApplication sharedApplication] applicationIconBadgeNumber]];
    [badge writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

+ (int)getStoredBadge{
    NSString *path = [APP_DOCUMENT stringByAppendingString:@"/badge"];
    int badge = [[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] intValue];
    return badge;
}

#pragma mark -
#pragma mark String
+ (BOOL)stringIsEmpty:(NSString *) aString {
    
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    
    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    } else {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    
    return NO; 
}

+ (BOOL)stringIsEmpty:(NSString *) aString shouldCleanWhiteSpace:(BOOL)cleanWhileSpace {
    
    if ((NSNull *) aString == [NSNull null]) {
        return YES;
    }
    
    if (aString == nil) {
        return YES;
    } else if ([aString length] == 0) {
        return YES;
    } 
    
    if (cleanWhileSpace) {
        aString = [aString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    
    return NO; 
}

+ (NSString*)UUID {
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(nil, uuidObj));
    CFRelease(uuidObj);
    return [uuidString lowercaseString];
}

#pragma mark -
#pragma mark Text
+ (NSString *)limitString:(NSString *)string withLength:(unsigned short)length{
    NSString* returnString=string;
    if([string length]>length) {
        returnString=[NSString stringWithFormat:@"%@...",[string substringToIndex:length-3]];
    }
    return returnString;
}



+ (NSString *)getDistanceText:(double)distance{
    NSString* distanceText=@"";
    if (distance<1000) {
        distanceText=[NSString stringWithFormat:@"%d00米", ((int)distance/100)+1];
    }else{
        distanceText=[NSString stringWithFormat:@"%dkm", ((int)distance/1000)];
    }
    return distanceText;    
}

+ (NSString *)getShowName:(NSString *)username withFirstName:(NSString *)firstName withLastName:(NSString *)lastName{
    if ((firstName && [firstName length]>0) ||  (lastName && [lastName length]>0 )) {
        return [NSString stringWithFormat:@"%@ %@",firstName,lastName];
    }else{
        return username;
    }
}

+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL)isValidateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)isValidZipcode:(NSString*)value
{
    const char *cvalue = [value UTF8String];
    int len = (int)strlen(cvalue);
    if (len != 6) {
        return NO;
    }
    for (int i = 0; i < len; i++)
    {
        if (!(cvalue[i] >= '0' && cvalue[i] <= '9'))
        {
            return NO;
        }
    }
    return YES;
}

#pragma mark -
#pragma mark Date
+ (NSString *)timeToText:(NSDate *)time{
    NSString *timeText=@"";
    
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [calender components:(NSYearCalendarUnit | 
                                                         NSMonthCalendarUnit |
                                                         NSDayCalendarUnit | 
                                                         NSHourCalendarUnit | 
                                                         NSMinuteCalendarUnit | 
                                                         NSSecondCalendarUnit) 
                                               fromDate:time
                                                 toDate:[NSDate date] options:0];
    
    [g_dayDateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [g_dayDateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    if ([components year]) {
        timeText = [[g_dayDateFormatter stringFromDate:time] substringToIndex:10];
    } else if ([components month]) {
        timeText = [[g_dayDateFormatter stringFromDate:time] substringToIndex:10];
    } else if ([components day]) {
        if ([components day] > 7) {
            timeText = [[g_dayDateFormatter stringFromDate:time] substringToIndex:10];
        } else {
            timeText = [NSString stringWithFormat:@"%d天前", (int)[components day]];
        }
    } else if ([components hour]) {
        timeText = [NSString stringWithFormat:@"%d小时前", (int)[components hour]];
    } else if ([components minute]) {
        if ([components minute] < 0) {
            timeText = @"刚刚";
        } else {
            timeText = [NSString stringWithFormat:@"%d分钟前", (int)[components minute]];
        }
    } else if ([components second]) {
        if ([components second] < 0) {
            timeText = @"刚刚";
        } else {
            timeText = [NSString stringWithFormat:@"%d秒前", (int)[components second]];
        }
    } else {
        timeText = @"刚刚";
    }
    return timeText;
}

+ (NSString*)stringFromDate:(NSDate*)aDate format:(NSString*)dateFormat
{
    return [GGUtil stringFromDate:aDate format:dateFormat timeZone:[NSTimeZone localTimeZone] dateLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
}

+ (NSString*)stringFromDate:(NSDate*)aDate format:(NSString*)dateFormat timeZone:(NSTimeZone*)timeZone dateLocale:(NSLocale*)locale
{
    g_dayDateFormatter.dateFormat = dateFormat;
    [g_dayDateFormatter setTimeZone:timeZone];
    [g_dayDateFormatter setLocale:locale];
    NSString *localDateString = [g_dayDateFormatter stringFromDate:aDate];
    return localDateString;
}

+ (NSDate*)dateFromString:(NSString*) dateStr Format:(NSString*)dateFormat
{
    return [GGUtil dateFromString:dateStr format:dateFormat timeZone:[NSTimeZone localTimeZone] dateLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
}

+ (NSDate*)dateFromString:(NSString*) dateStr format:(NSString*)dateFormat timeZone:(NSTimeZone*)timeZone dateLocale:(NSLocale*)locale
{
    [g_dayDateFormatter setDateFormat:dateFormat];
    [g_dayDateFormatter setTimeZone:timeZone];
    [g_dayDateFormatter setLocale:locale];
    NSDate *date = [g_dayDateFormatter dateFromString:dateStr];
    return date;
}

#pragma mark -
#pragma mark Memory
+ (void)simulateMemoryWarning
{
#if TARGET_IPHONE_SIMULATOR
#ifdef DEBUG
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), 
                                         (CFStringRef)@"UISimulatedMemoryWarningNotification", NULL, NULL, true);
#endif
#endif
}


#pragma mark -
#pragma mark URL
+ (NSString *)getLargeSinaAvatar:(NSString *)shortUrl{
    NSString *largeUrl=shortUrl;
    NSRange textRange = [shortUrl rangeOfString:@"sinaimg"];
    if(textRange.location != NSNotFound) {
        largeUrl = [shortUrl stringByReplacingOccurrencesOfString:@"/50/" withString:@"/180/"];   
        DLog(@"short url:%@",shortUrl);
        DLog(@"large url:%@",largeUrl);
    }
    return largeUrl;
}

+ (BOOL)hasLaunchBeforeAtThisVersion
{
    static BOOL isFirstLaunch = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *str = [NSString stringWithFormat:@"hasLaunchBeforeAt%@",CurrentAppVersion];
        if ([USER_DEFAULT boolForKey:str]) {
            isFirstLaunch = YES;
        }
        else {
            [USER_DEFAULT setBool:YES forKey:str];
            [USER_DEFAULT synchronize];
            isFirstLaunch = NO;
        }
    });
    return isFirstLaunch;
}

#pragma mark - 甘豆影评,对评分进行四舍五入和保留两位小数
+ (NSString *)stringByRating:(NSString *)rating
{
    if(rating){
        
        NSString *ratingString = [NSString stringWithFormat:@"%.2f",[rating floatValue]];
        if ([[ratingString substringFromIndex:ratingString.length - 1] isEqualToString:@"0"]) {
            ratingString = [ratingString substringToIndex:ratingString.length - 1];
            
            if ([ratingString rangeOfString:@".0"].location != NSNotFound) {
                ratingString = [ratingString substringToIndex:ratingString.length - 2];
            }
            
        }
        
        return ratingString;
    }
    return nil;
}

+ (NSString *)filterHTML:(NSString *)html {
    return [GGUtil flattenHTML:html trimWhiteSpace:YES];
}

+ (NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim
{
    if (html == nil) {
        return nil;
    }
    
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    
    if (trim) {
        html = [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        html = [html stringByReplacingOccurrencesOfString:@"\r\n\r\n" withString:@""];
        html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    }
    return html;
}

@end
