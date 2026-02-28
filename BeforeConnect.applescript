-- BeforeConnect.applescript
-- Viscosity Before Connect script — fetches OTP via a configured shell command
-- and returns it as a challenge response.
--
-- Config: defaults write net.skycmd.viscosity-otp "<connection>" "<otp-command>"
-- Setup: point Viscosity Before Connect to this file.

property prefsId : "net.skycmd.viscosity-otp"

on run
	try
		set connName to do shell script "echo $displayName"
		if connName is "" then error "Connection name not set — this script must be called by Viscosity"
		
		set otpCommand to do shell script "defaults read " & prefsId & " " & quoted form of connName & " 2>/dev/null || true"
		if otpCommand is "" then error "No OTP command configured for '" & connName & "'. Run:" & return & return & "defaults write " & prefsId & " " & quoted form of connName & " \"<otp-command>\""
		
		try
			set OTP to do shell script otpCommand
		on error cmdErr
			error "OTP command failed: " & cmdErr
		end try
		if OTP is not "" then return "challenge " & OTP
	on error errMsg
		display dialog errMsg with title "Viscosity OTP Error" buttons {"OK"} default button "OK" with icon stop
	end try
end run
