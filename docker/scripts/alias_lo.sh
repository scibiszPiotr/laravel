#!/bin/bash

set -eo pipefail

IP="${1:-172.16.123.1}"

LO_RC_FILE="/Library/LaunchDaemons/com.runlevel1.lo0.${IP}.plist"

cat >"${LO_RC_FILE}" <<END
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
      <key>Label</key>
      <string>com.runlevel1.lo0.${IP}</string>
      <key>RunAtLoad</key>
      <true/>
      <key>ProgramArguments</key>
      <array>
          <string>/sbin/ifconfig</string>
          <string>lo0</string>
          <string>alias</string>
          <string>${IP}</string>
      </array>
      <key>StandardErrorPath</key>
      <string>/var/log/loopback-alias.log</string>
      <key>StandardOutPath</key>
      <string>/var/log/loopback-alias.log</string>
  </dict>
</plist>
END

chmod 0644 "${LO_RC_FILE}"
chown root:wheel "${LO_RC_FILE}"
launchctl load "${LO_RC_FILE}"

echo "[INFO] IP: ${IP} added to loopback network device successfully"