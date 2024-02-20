#import "uYouPlusPatches.h"

# pragma mark - YouTube patches

// Fix Google Sign in by @PoomSmart and @level3tjg (qnblackcat/uYouPlus#684)
%hook NSBundle
- (NSDictionary *)infoDictionary {
    NSMutableDictionary *info = %orig.mutableCopy;
    NSString *altBundleIdentifier = info[@"ALTBundleIdentifier"];
    if (altBundleIdentifier) info[@"CFBundleIdentifier"] = altBundleIdentifier;
    return info;
}
%end

// Workaround for MiRO92/uYou-for-YouTube#12, qnblackcat/uYouPlus#263
%hook YTDataUtils
+ (NSMutableDictionary *)spamSignalsDictionary {
    return nil;
}
+ (NSMutableDictionary *)spamSignalsDictionaryWithoutIDFA {
    return nil;
}
%end

%hook YTHotConfig
- (BOOL)disableAfmaIdfaCollection { return NO; }
%end

// Reposition "Create" Tab to the Center in the Pivot Bar - qnblackcat/uYouPlus#107
/*
static void repositionCreateTab(YTIGuideResponse *response) {
    NSMutableArray<YTIGuideResponseSupportedRenderers *> *renderers = [response itemsArray];
    for (YTIGuideResponseSupportedRenderers *guideRenderers in renderers) {
        YTIPivotBarRenderer *pivotBarRenderer = [guideRenderers pivotBarRenderer];
        NSMutableArray<YTIPivotBarSupportedRenderers *> *items = [pivotBarRenderer itemsArray];
        NSUInteger createIndex = [items indexOfObjectPassingTest:^BOOL(YTIPivotBarSupportedRenderers *renderers, NSUInteger idx, BOOL *stop) {
            return [[[renderers pivotBarItemRenderer] pivotIdentifier] isEqualToString:@"FEuploads"];
        }];
        if (createIndex != NSNotFound) {
            YTIPivotBarSupportedRenderers *createTab = [items objectAtIndex:createIndex];
            [items removeObjectAtIndex:createIndex];
            NSUInteger centerIndex = items.count / 2;
            [items insertObject:createTab atIndex:centerIndex]; // Reposition the "Create" tab at the center
        }
    }
}
%hook YTGuideServiceCoordinator
- (void)handleResponse:(YTIGuideResponse *)response withCompletion:(id)completion {
    repositionCreateTab(response);
    %orig(response, completion);
}
- (void)handleResponse:(YTIGuideResponse *)response error:(id)error completion:(id)completion {
    repositionCreateTab(response);
    %orig(response, error, completion);
}
%end
*/

// https://github.com/PoomSmart/YouTube-X/blob/1e62b68e9027fcb849a75f54a402a530385f2a51/Tweak.x#L27
// %hook YTAdsInnerTubeContextDecorator
// - (void)decorateContext:(id)context {}
// %end

# pragma mark - uYou patches

// Workaround for qnblackcat/uYouPlus#10
%hook UIViewController
- (UITraitCollection *)traitCollection {
    @try {
        return %orig;
    } @catch(NSException *e) {
        return [UITraitCollection currentTraitCollection];
    }
}
%end

// Prevent uYou player bar from showing when not playing downloaded media
%hook PlayerManager
- (void)pause {
    if (isnan([self progress]))
        return;
    %orig;
}
%end

// Workaround for issue #54
%hook YTMainAppVideoPlayerOverlayViewController
- (void)updateRelatedVideos {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"relatedVideosAtTheEndOfYTVideos"] == NO) {}
    else { return %orig; }
}
%end

// iOS 16 uYou crash fix - @level3tjg: https://github.com/qnblackcat/uYouPlus/pull/224
%group iOS16
%hook OBPrivacyLinkButton
%new
- (instancetype)initWithCaption:(NSString *)caption
                     buttonText:(NSString *)buttonText
                          image:(UIImage *)image
                      imageSize:(CGSize)imageSize
                   useLargeIcon:(BOOL)useLargeIcon {
  return [self initWithCaption:caption
                    buttonText:buttonText
                         image:image
                     imageSize:imageSize
                  useLargeIcon:useLargeIcon
               displayLanguage:[NSLocale currentLocale].languageCode];
}
%end
%end

// Fix uYou playback speed crashes YT v18.49.3+, see https://github.com/iCrazeiOS/uYouCrashFix
%hook YTPlayerViewController
%new
-(float)currentPlaybackRateForVarispeedSwitchController:(id)arg1 {
	return [[self activeVideo] playbackRate];
}

%new
-(void)varispeedSwitchController:(id)arg1 didSelectRate:(float)arg2 {
	[[self activeVideo] setPlaybackRate:arg2];
}
%end

// Fix streched artwork in uYou's player view - https://github.com/MiRO92/uYou-for-YouTube/issues/287
%hook ArtworkImageView
- (id)imageView {
    UIImageView * imageView = %orig;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    // Make artwork a bit bigger
    UIView *artworkImageView = imageView.superview;
    if (artworkImageView != nil && !artworkImageView.translatesAutoresizingMaskIntoConstraints) {
        [artworkImageView.leftAnchor constraintEqualToAnchor:artworkImageView.superview.leftAnchor constant:16].active = YES;
        [artworkImageView.rightAnchor constraintEqualToAnchor:artworkImageView.superview.rightAnchor constant:-16].active = YES;
    }
    return imageView;
}
%end

// Fix navigation bar showing a lighter grey with default dark mode - https://github.com/therealFoxster/uYouPlus/commit/8db8197
%hook YTCommonColorPalette
- (UIColor *)brandBackgroundSolid {
    return self.pageStyle == 1 ? [UIColor colorWithRed:0.05882352941176471 green:0.05882352941176471 blue:0.05882352941176471 alpha:1.0] : %orig;
}
%end

// Fix uYou's appearance not updating if the app is backgrounded
DownloadsPagerVC *downloadsPagerVC;
NSUInteger selectedTabIndex;
static void refreshUYouAppearance() {
    if (!downloadsPagerVC) return;
    // View pager
    [downloadsPagerVC updatePageStyles];
    // Views
    for (UIViewController *vc in [downloadsPagerVC viewControllers]) {
        if ([vc isKindOfClass:%c(DownloadingVC)]) {
            // `Downloading` view
            [(DownloadingVC *)vc updatePageStyles];
            for (UITableViewCell *cell in [(DownloadingVC *)vc tableView].visibleCells)
                if ([cell isKindOfClass:%c(DownloadingCell)])
                    [(DownloadingCell *)cell updatePageStyles];
        }
        else if ([vc isKindOfClass:%c(DownloadedVC)]) {
            // `All`, `Audios`, `Videos`, `Shorts` views
            [(DownloadedVC *)vc updatePageStyles];
            for (UITableViewCell *cell in [(DownloadedVC *)vc tableView].visibleCells)
                if ([cell isKindOfClass:%c(DownloadedCell)])
                    [(DownloadedCell *)cell updatePageStyles];
        }
    }
    // View pager tabs
    for (UIView *subview in [downloadsPagerVC view].subviews) {
        if ([subview isKindOfClass:[UIScrollView class]]) {
            UIScrollView *tabs = (UIScrollView *)subview;
            NSUInteger i = 0;
            for (UIView *item in tabs.subviews) {
                if ([item isKindOfClass:[UILabel class]]) {
                    // Tab label
                    UILabel *tabLabel = (UILabel *)item;
                    if (i == selectedTabIndex) {} // Selected tab should be excluded
                    else [tabLabel setTextColor:[UILabel _defaultColor]];
                    i++;
                }
            }
        }
    }
}
%hook DownloadsPagerVC
- (instancetype)init {
    downloadsPagerVC = %orig;
    return downloadsPagerVC;
}
- (void)viewPager:(id)viewPager didChangeTabToIndex:(NSUInteger)arg1 fromTabIndex:(NSUInteger)arg2 {
    %orig; selectedTabIndex = arg1;
}
%end
%hook UIViewController
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    %orig;
    refreshUYouAppearance();
}
%end

// Prevent uYou's playback from colliding with YouTube's
BOOL isYTPlaybackActive = NO;
%hook HAMPlayerInternal
- (void)play { %orig; isYTPlaybackActive = YES; }
- (void)terminate { %orig; isYTPlaybackActive = NO; }
%end
%hook PlayerManager
- (void)play {
    if (isYTPlaybackActive) return;
    %orig;
}
%end

// Temporarily disable uYou's bouncy animation cause it's buggy
%hook SSBouncyButton
- (void)beginShrinkAnimation {}
- (void)beginEnlargeAnimation {}
%end

%ctor {
    %init;
    if (@available(iOS 16, *)) {
        %init(iOS16);
    }

    // Disable broken options
    
    // Disable uYou's auto updates
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"automaticallyCheckForUpdates"];

    // Disable uYou's welcome screen (fix #1147)
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"showedWelcomeVC"];
 
    // Disable uYou's disable age restriction
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"disableAgeRestriction"];

    // Disable uYou's playback speed controls (prevent crash on video playback https://github.com/therealFoxster/uYouPlus/issues/2#issuecomment-1894912963)
    // [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"showPlaybackRate"];
}
