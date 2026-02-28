# Viscosity OTP

Automates OTP entry for [Viscosity](https://www.sparklabs.com/viscosity/) VPN connections on macOS. When you connect to a VPN, the OTP is fetched and submitted automatically — no manual copy-paste.

Works with any OTP source that has a CLI — 1Password, Bitwarden, KeePassXC, `oathtool`, or any command that outputs a TOTP code.

## Quick Start

**1. Map a connection to an OTP command:**

```bash
defaults write net.skycmd.viscosity-otp "<connection-name>" "<otp-command>"
```

**2. Point Viscosity to the script:**

Open Viscosity Preferences → select the connection → **Advanced** → set **Before Connect Script** to `BeforeConnect.applescript`.

That's it. Next time you connect, the OTP is handled for you.

## Documentation

Full instructions, provider guides, troubleshooting, and known limitations are available in the **[Wiki](https://github.com/SkyCMD-Labs/viscosity-otp/wiki)**.

## License

[MIT](LICENSE)

