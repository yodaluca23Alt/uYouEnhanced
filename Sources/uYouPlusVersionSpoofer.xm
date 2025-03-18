#import "uYouPlus.h"

typedef struct {
    int version;
    NSString *appVersion;
} VersionMapping;

static VersionMapping versionMappings[] = {
    {0, @"20.10.3"},
    {1, @"20.09.3"},
    {2, @"20.08.3"},
    {3, @"20.07.6"},
    {4, @"20.06.03"},
    {5, @"20.05.4"},
    {6, @"20.03.1"},
    {7, @"20.03.02"},
    {8, @"20.02.3"},
    {9, @"19.49.7"},
    {10, @"19.49.5"},
    {11, @"19.49.3"},
    {12, @"19.47.7"},
    {13, @"19.46.3"},
    {14, @"19.45.4"},
    {15, @"19.44.4"},
    {16, @"19.43.2"},
    {17, @"19.42.1"},
    {18, @"19.41.3"},
    {19, @"19.40.4"},
    {20, @"19.39.1"},
    {21, @"19.38.2"},
    {22, @"19.37.2"},
    {23, @"19.36.1"},
    {24, @"19.35.3"},
    {25, @"19.34.2"},
    {26, @"19.33.2"},
    {27, @"19.32.8"},
    {28, @"19.32.6"},
    {29, @"19.31.4"},
    {30, @"19.30.2"},
    {31, @"19.29.1"},
    {32, @"19.28.1"},
    {33, @"19.26.5"},
    {34, @"19.25.4"},
    {35, @"19.25.3"},
    {36, @"19.24.3"},
    {37, @"19.24.2"},
    {38, @"19.23.3"},
    {39, @"19.22.6"},
    {40, @"19.22.3"},
    {41, @"19.21.3"},
    {42, @"19.21.2"},
    {43, @"19.20.2"},
    {44, @"19.19.7"},
    {45, @"19.19.5"},
    {46, @"19.18.2"},
    {47, @"19.17.2"},
    {48, @"19.16.3"},
    {49, @"19.15.1"},
    {50, @"19.14.3"},
    {51, @"19.14.2"},
    {52, @"19.13.1"},
    {53, @"19.12.3"},
    {54, @"19.10.7"},
    {55, @"19.10.6"},
    {56, @"19.10.5"},
    {57, @"19.09.4"},
    {58, @"19.09.3"},
    {59, @"19.08.2"},
    {60, @"19.07.5"},
    {61, @"19.07.4"},
    {62, @"19.06.2"},
    {63, @"19.05.5"},
    {64, @"19.05.3"},
    {65, @"19.04.3"},
    {66, @"19.03.2"},
    {67, @"19.02.1"},
    {68, @"19.01.1"}
};

static int appVersionSpoofer() {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"versionSpoofer"];
}

static BOOL isVersionSpooferEnabled() {
    return IS_ENABLED(@"enableVersionSpoofer_enabled");
}

static NSString* getAppVersionForSpoofedVersion(int spoofedVersion) {
    for (int i = 0; i < sizeof(versionMappings) / sizeof(versionMappings[0]); i++) {
        if (versionMappings[i].version == spoofedVersion) {
            return versionMappings[i].appVersion;
        }
    }
    return nil;
}

%hook YTVersionUtils
+ (NSString *)appVersion {
    if (!isVersionSpooferEnabled()) {
        return %orig;
    }
    int spoofedVersion = appVersionSpoofer();
    NSString *appVersion = getAppVersionForSpoofedVersion(spoofedVersion);
    return appVersion ? appVersion : %orig;
}
%end
