# Viscosity OTP

Automatically enters TOTP codes for Viscosity VPN connections on macOS.
When you connect to a VPN, the OTP is fetched and submitted automatically — no manual copy-paste.

Works with any OTP source that has a CLI — 1Password, Bitwarden, KeePassXC, oathtool, or any command that outputs a TOTP code.

## Why this exists

Viscosity supports challenge-response scripts, but OTP handling is usually implemented as one-off, provider-specific glue.

This project provides a clean, provider-agnostic way to automate OTP entry using tools you already trust.

- No secrets stored
- No GUI automation or screen scraping
- No provider lock-in

## How it works (at a glance)

Viscosity runs a *Before Connect* AppleScript during VPN connection:

```text
BeforeConnect.applescript
  reads VPN connection name
  looks up configured OTP command
  executes the command
  returns challenge OTP to Viscosity
```

Viscosity submits the response automatically as part of the connection flow.

## macOS permissions (important)

Because Viscosity runs *Before Connect* scripts via `osascript`, macOS may prompt for
permission to allow access to application data each time you connect.

This is a limitation of macOS’s Transparency, Consent, and Control (TCC) system — not of
Viscosity OTP itself. The prompt must be acknowledged for the connection to proceed.

Details, background, and available workarounds (including MDM deployment options) are
documented in the [Wiki](https://github.com/SkyCMD-Labs/viscosity-otp/wiki/Known-Limitations).

If you’ve found a workaround or improvement for any limitation, issues and pull requests are welcome.

## Quick Start

### 1. Map a connection to an OTP command

```bash
defaults write net.skycmd.viscosity-otp "<connection-name>" "<otp-command>"
```

Examples:

```bash
# 1Password
defaults write net.skycmd.viscosity-otp "Work VPN" "op item get <uuid> --otp"

# Bitwarden
defaults write net.skycmd.viscosity-otp "Work VPN" "bw get totp <item>"

# oathtool
defaults write net.skycmd.viscosity-otp "Work VPN" "oathtool --totp --base32 <secret>"
```

### 2. Point Viscosity to the script

Open Viscosity Preferences → select the connection → Advanced → set *Before Connect Script*
to `BeforeConnect.applescript`.

That’s it. Next time you connect, the OTP is handled for you.

## Who this is for

This tool is useful if you:

- use Viscosity on macOS with TOTP-protected VPNs
- already manage OTPs via a password manager or CLI tool
- want automation without storing secrets or weakening your security model

## Documentation

Full instructions, provider-specific guides, troubleshooting, and known limitations are available in the Wiki:
https://github.com/SkyCMD-Labs/viscosity-otp/wiki

## License

MIT (see LICENSE)
