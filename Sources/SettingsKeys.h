#import "uYouPlus.h"
#import "uYouPlusSettings.h"

// Keys for "Copy settings" button (for: uYouEnhanced)
// In alphabetical order for tweaks after uYouEnhanced
NSArray *NSUserDefaultsCopyKeys = @[
    // uYouEnhanced - gathered using get_keys.py
    kReplaceCopyandPasteButtons, kAppTheme, kOLEDKeyboard, kPortraitFullscreen, kFullscreenToTheRight, kSlideToSeek, kYTTapToSeek, kDoubleTapToSeek, kSnapToChapter, kPinchToZoom, kYTMiniPlayer, kStockVolumeHUD, kReplaceYTDownloadWithuYou, kDisablePullToFull, kDisableChapterSkip, kAlwaysShowRemainingTime, kDisableRemainingTime, kEnableShareButton, kEnableSaveToButton, kHideYTMusicButton, kHideAutoplaySwitch, kHideCC, kHideVideoTitle, kDisableCollapseButton, kDisableFullscreenButton, kHideHUD, kHidePaidPromotionCard, kHideChannelWatermark, kHideVideoPlayerShadowOverlayButtons, kHidePreviousAndNextButton, kRedProgressBar, kHideHoverCards, kHideRightPanel, kHideFullscreenActions, kHideSuggestedVideo, kHideHeatwaves, kHideDoubleTapToSeekOverlay, kHideOverlayDarkBackground, kDisableAmbientMode, kHideVideosInFullscreen, kHideRelatedWatchNexts, kHideBuySuperThanks, kHideSubscriptions, kShortsQualityPicker, kRedSubscribeButton, kHideButtonContainers, kHideConnectButton, kHideShareButton, kHideRemixButton, kHideThanksButton, kHideDownloadButton, kHideClipButton, kHideSaveToPlaylistButton, kHideReportButton, kHidePreviewCommentSection, kHideCommentSection, kDisableAccountSection, kDisableAutoplaySection, kDisableTryNewFeaturesSection, kDisableVideoQualityPreferencesSection, kDisableNotificationsSection, kDisableManageAllHistorySection, kDisableYourDataInYouTubeSection, kDisablePrivacySection, kDisableLiveChatSection, kHidePremiumPromos, kHideHomeTab, kLowContrastMode, kClassicVideoPlayer, kDisableModernButtons, kDisableRoundedHints, kDisableModernFlags, kYTNoModernUI, kEnableVersionSpoofer, kGoogleSignInPatch, kAdBlockWorkaroundLite, kAdBlockWorkaround, kYouTabFakePremium, kDisableAnimatedYouTubeLogo, kCenterYouTubeLogo, kHideYouTubeLogo, kYTStartupAnimation, kDisableHints, kStickNavigationBar, kHideiSponsorBlockButton, kHideChipBar, kShowNotificationsTab, kHidePlayNextInQueue, kHideCommunityPosts, kHideChannelHeaderLinks, kiPhoneLayout, kBigYTMiniPlayer, kReExplore, kAutoHideHomeBar, kHideSubscriptionsNotificationBadge, kFixCasting, kNewSettingsUI, kFlex, kGoogleSigninFix,
    // uYou - https://github.com/MiRO92/uYou-for-YouTube
    @"showedWelcomeVC", @"hideShortsTab", @"hideCreateTab", @"hideCastButton", @"relatedVideosAtTheEndOfYTVideos", @"removeYouTubeAds", @"backgroundPlayback", @"disableAgeRestriction", @"iPadLayout", @"noSuggestedVideoAtEnd", @"shortsProgressBar", @"hideShortsCells", @"removeShortsCell", @"startupPage",
    // DEMC - https://github.com/therealFoxster/DontEatMyContent/blob/master/Tweak.h
    @"DEMC_enabled", @"DEMC_colorViewsEnabled", @"DEMC_safeAreaConstant", @"DEMC_disableAmbientMode", 
    @"DEMC_limitZoomToFill", @"DEMC_enableForAllVideos",
    // iSponsorBlock cannot be exported using this method - it is also being removed in v5
    // Return-YouTube-Dislike - https://github.com/PoomSmart/Return-YouTube-Dislikes/blob/main/TweakSettings.h
    @"RYD-ENABLED", @"RYD-VOTE-SUBMISSION", @"RYD-EXACT-LIKE-NUMBER", @"RYD-EXACT-NUMBER",
    // All YTVideoOverlay Tweaks - https://github.com/PoomSmart/YTVideoOverlay/blob/0fc6d29d1aa9e75f8c13d675daec9365f753d45e/Tweak.x#L28C1-L41C84
    @"YTVideoOverlay-YouLoop-Enabled", @"YTVideoOverlay-YouTimeStamp-Enabled", @"YTVideoOverlay-YouMute-Enabled", 
    @"YTVideoOverlay-YouQuality-Enabled", @"YTVideoOverlay-YouLoop-Position", @"YTVideoOverlay-YouTimeStamp-Position", 
    @"YTVideoOverlay-YouMute-Position", @"YTVideoOverlay-YouQuality-Position",
    // YouPiP - https://github.com/PoomSmart/YouPiP/blob/main/Header.h
    @"YouPiPPosition", @"CompatibilityModeKey", @"PiPActivationMethodKey", @"PiPActivationMethod2Key", 
    @"NoMiniPlayerPiPKey", @"NonBackgroundableKey",
    // YTABConfig cannot be reasonably exported using this method
    // YTHoldForSpeed will be removed in v5
    // YouTube Plus / YTLite cannot be exported using this method
    // YTUHD - https://github.com/PoomSmart/YTUHD/blob/master/Header.h
    @"EnableVP9", @"AllVP9",
    // Useful YouTube Keys
    @"inline_muted_playback_enabled",
];


// Some default values to ignore when exporting settings
NSDictionary *NSUserDefaultsCopyKeysDefaults = @{
    @"fixCasting_enabled": @1,
    @"inline_muted_playback_enabled": @5,
    @"newSettingsUI_enabled": @1,
    @"DEMC_safeAreaConstant": @21.5,
    @"RYD-ENABLED": @1,
    @"RYD-VOTE-SUBMISSION": @1,
    // Duplicate keys are not allowed in NSDictionary. If present, only the last one will be kept.
};
