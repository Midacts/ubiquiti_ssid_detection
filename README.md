This script is used to use your Ubiquiti access point to check for other access points in it's area.

* Copy this script to a Linux machine
* Make this script executable
> `chmod +x ubiquiti.sh`

* Edit variables
	## SSH Variables
	  ---------------
	**user**
	* Change to the username used to login to your Unifi AP

	**password**
	* Change to the password of the user used to login to your Unifi AP

	**hostname**
	* Change to the IP or FQDN of your Unifi AP

	## Email Variables
	  ---------------
	
	**host**		
	* Change the HOST string to match the DNS name or IP of the UAP.
	* Change the PASSWORD string to match the admin password to log into the UAP.

	**subject**
	* Change to whatever you would like the subject of the email alert to be.

	**sender**		
	* Update this email address to match your needs.
	
	**recipient**	
	* Update this eamil address with the email addresses of the users/groups that you would like to receive these email alerts.
	
	## Variables to get list of scanned SSIDs form the Ubiquiti UAP-PRO
	  ----------------------------------------------------------------
	* Put your known non-route AP's in single quotes here. Do not use commas, just use spaces, like the included example.

Other than that, you should be all set. In my testing, the 'ath3' interface picked up the most SSIDs. I just wanted to be on the safe side
and have all the athx interfaces scan for SSIDs. If you just want to use ath3, remove lines (45-47) and (50-123)
