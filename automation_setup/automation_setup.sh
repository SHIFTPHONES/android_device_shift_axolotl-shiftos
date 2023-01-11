#!/system/bin/sh

# Check if this script should trigger, exit quietly otherwise.
if [ ! -f /data/userdata_automation/trigger ]; then
    echo >&2 "+++ SKIPPING automation setup for ATS. Trigger not set. +++"
    exit 0
fi

settings_put() {
    echo >&2 "[automation_setup] settings put $*"
    # -w: Wait for the service to be ready, as we're running in early boot
    cmd -w settings put "$@"
}

# Output on stderr, to be picked up via stdio_to_kmsg on kmsg.
echo >&2 "+++ TRIGGERING AUTOMATION SETUP FOR ATS +++"

# Following `settings put` calls must run as root from Android 11 on. The
# `system` user doesn't have enough permissions.

# Enable adb, system settings part
settings_put global development_settings_enabled 1
settings_put global verifier_verify_adb_installs 0
settings_put global adb_enabled 1

# Set time to 12 hour format
settings_put system time_12_24 12
# Set system locale to English (United States)
settings_put system system_locales en-US

# Add GPS to location providers
settings_put secure location_providers_allowed +gps

# Disable automatic OTA updates
settings_put global ota_disable_automatic_update 1

# Enable BT and WiFi background scanning
settings_put global ble_scan_always_enabled 1
settings_put global wifi_scan_always_enabled 1

# Skip setupwizard
settings_put global device_provisioned 1
settings_put secure user_setup_complete 1

# Reduce display brightness
settings_put system screen_brightness 0

# Remove trigger so we don't run again
rm -v /data/userdata_automation/trigger

echo >&2 "+++ AUTOMATION: Waiting for late boot trigger. +++"
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    # Full boot can take a while, especially after factory reset.
    sleep 2
done

# Disable lockscreen
locksettings clear --old 1234
locksettings clear --old 12345
locksettings set-disabled true

# Enable mobile data. Requires service `phone` to be running.
svc data enable

# Keep device screen on
svc power stayon true

# Skip Chrome setup
echo 'chrome --disable-fre' > /data/local/tmp/chrome-command-line

# Decrease media volume
media volume --stream 0 --set 2
media volume --stream 2 --set 1
media volume --stream 3 --set 1
media volume --stream 4 --set 2

echo >&2 "+++ TRIGGERING AUTOMATION SETUP FOR ATS DONE +++"
