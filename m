From: Stef Bon <stef@bononline.nl>
Subject: Testing the UID var.
Date: Fri, 28 Mar 2008 10:20:04 +0100
Message-ID: <47ECB844.8080405@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hello,

the latest weeks I've been testing with the paramters UID, USER etc. 
provided by the automounter,
indicating the user activating the mount. I've changed the default 
auto.smb script to make use of this var:
(earlier I had another constructing which was not so comprehensive)

---------

#!/bin/bash

key="$1"
opts='-fstype=smbtest,auid=$UID'

SMBCLIENT=/usr/bin/smbclient

[ -x $SMBCLIENT ] || exit 1

# echo $key

$SMBCLIENT -gNL $key 2>/dev/null| awk -v key="$key" -v opts="$opts" 
-F'|' -- '
        BEGIN   { ORS=""; first=1 }
        /Disk/  { if (first) { print opts; first=0 }; sub(/ /, "\\ ", 
$2); print " \\\n\t /" $2, "://" key "/" $2 }
        END     { if (!first) print "\n"; else exit 1 }
        '
--------

Note:
a. I've made this script I little bit simpler by letting it not search 
the smbclient script.
b. the fstype is not smb but smbtest. I've created a wrapper 
mount.smbtest which will filter the parameter
auid out. This value can be used for permissions and authentification
c. the extra opion auid (activating user) which will be assigned when 
the automounter does the mount, not when running this script. That's why 
there are single quotes around it.

Futher I use this wrapper mount.smbtest, which is a little bit too big 
to show here. In pseudo code:

---------

#!/bin/sh

# log the parameters, important to see how this script is called
# and what the value of auid is

set | grep "^BASH_ARGV" >> /var/log/mount.smbtest.log

seperate the value auid from the rest of the paramaters
if this auid is not empty, and does exist (an existing user on the system)
check there are credentials for this user

if so then perform a mount.smb with the credentials, with all the right 
options (mountpoint, unc_address and other options)
else do a guest mount ( with the right options)


----------

When looking to the logfile, sometimes the auid is correct, but in about 
50% of the cases it's empty.

If you would like to test with this I can provide this mount.smbtest script.

Stef Bon
