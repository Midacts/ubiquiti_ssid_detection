This script is used to use your Ubiquiti access point to check for other access points in it's area.

* Copy this script to a Linux machine
* Make this script executable
`chmod +x ubiquiti.sh`

* Edit some settings- mainly the variables at the top of the script
	# Email Variables
	  ---------------
	
	**host**		
	* Change the HOST string to match the DNS name or IP of the UAP.
	* Change the PASSWORD string to match the admin password to log into the UAP.

	**sender**		
	* Update this email address to match your needs.
	
	**recipient**	
	* Update this eamil address with the email addresses of the users/groups that you would like to receive these email alerts.
	
	# Variables to get list of scanned SSIDs form the Ubiquiti UAP-PRO
	  ----------------------------------------------------------------
	
	**PASSWORD**	
	* Change the PASSWORD string to match the admin password to log into the UAP
	
	**HOST**		
	* Change the HOST string to match the DNS name or IP of the UAP.

Other than that, you should be all set. In my testing, the 'ath3' interface picked up the most SSIDs. I just wanted to be on the safe side
and have all the athx interfaces scan for SSIDs. If you just want to use ath3, remove lines (29-31) and (34-107)
