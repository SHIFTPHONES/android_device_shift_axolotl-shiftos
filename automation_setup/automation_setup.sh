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

# Move supplied adb public key to correct directory
mv -v /data/userdata_automation/adb_keys /data/misc/adb/adb_keys
chown -v 1000:2000 /data/misc/adb/adb_keys

# Enable adb
setprop persist.sys.usb.config adb
settings_put global development_settings_enabled 1
settings_put global verifier_verify_adb_installs 0
settings_put global adb_enabled 1

# Skip setupwizard
settings_put global device_provisioned 1
settings_put secure user_setup_complete 1

# Remove trigger so we don't run again
rm -v /data/userdata_automation/trigger

echo >&2 "+++ AUTOMATION: Waiting for late boot trigger. +++"
while [ "$(getprop sys.boot_completed)" != "1" ]; do
    # Full boot can take a while, especially after factory reset.
    sleep 2
done

# Enable mobile data. Requires service `phone` to be running.
svc data enable

echo >&2 "+++ TRIGGERING AUTOMATION SETUP FOR ATS DONE +++"
