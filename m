From: Stef Bon <stef@bononline.nl>
Subject: Re: Script to mount the whole SMB network.
Date: Thu, 31 Jul 2008 13:50:56 +0200
Message-ID: <200807311350.56636.stef@bononline.nl>
References: <200807301059.51228.stef@bononline.nl>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gcakISbQFgduY3G"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200807301059.51228.stef@bononline.nl>
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

--Boundary-00=_gcakISbQFgduY3G
Content-Type: multipart/alternative;
  boundary="Boundary-00=_gcakI+AmVVmi+VP"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-00=_gcakI+AmVVmi+VP
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

On Wednesday 30 July 2008 10:59:51 Stef Bon wrote:
> Hello,
>

> copy the auto.network script to /etc/autofs
> make it executable if not already
>
Oops, it had a small bug.
Attached is the corrected version.

Stef Bon


--Boundary-00=_gcakI+AmVVmi+VP
Content-Type: text/html;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'Sans Serif'; font-size:10pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">On Wednesday 30 July 2008 10:59:51 Stef Bon wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; Hello,</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt;</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; copy the auto.network script to /etc/autofs</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; make it executable if not already</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Oops, it had a small bug.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Attached is the corrected version.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Stef Bon</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"></p></body></html>
--Boundary-00=_gcakI+AmVVmi+VP--

--Boundary-00=_gcakISbQFgduY3G
Content-Type: application/x-shellscript;
  name="auto.network"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="auto.network"

#!/bin/bash

autofs_key=$1

if [ -z "$autofs_key" ]; then

    exit
    
fi

FILESYSTEM="cifs"
CREDENTIAL_FILE=/etc/mount.smb.cred

if [ -n "$CREDENTIAL_FILE" ]; then

    if [ ! -f "$CREDENTIAL_FILE" ]; then

	unset CREDENTIAL_FILE
    
    fi
    
fi

tmpvar=$(cat /proc/filesystems | grep "^nodev.*$FILESYSTEM")

if [ -z "$tmpvar" ]; then


    echo "Filesystem $FILESYSTEM not supported on this machine."
    exit
    
fi

unset tmpvar


if [ -z "$TMPDIR" ]; then

    if [ ! -d /tmp ]; then
    
	exit
	
    else
    
	TMPDIR=/tmp/auto.network
	
    fi
    
    if [ ! -d "$TMPDIR " ]; then
    
	install --directory $TMPDIR
	
    fi
    
fi


if [ "$autofs_key" = "Windows Network" ]; then


    NMBLOOKUP=$(which nmblookup 2>>/dev/null)

    if [ -z "$NMBLOOKUP" ]; then

	echo "Cannot continue: nmblookup not found."
	exit

    fi

    SMBCLIENT=$(which smbclient 2>>/dev/null)

    if [ -z "$SMBCLIENT" ]; then

	echo "Cannot continue: smbclient not found."
	exit
    
    fi

    # lookup every host in subnet
    
    $NMBLOOKUP --debuglevel= 0 '*' | grep '<00>' | awk '{ print $1 }' > $TMPDIR/SMBhosts
    
    # start of multi mount map
    # when a credentialsfile is found use this
    
    if [ -n "$CREDENTIAL_FILE" ]; then
    
	echo -n "-fstype=$FILESYSTEM,credentials=\"$CREDENTIAL_FILE\" "
    
    else

	echo -n "-fstype=$FILESYSTEM,guest "
	
    fi


    for smbhost in $(cat $TMPDIR/SMBhosts); do
    
	# determine the resources available on this host

	if [ -n "$CREDENTIAL_FILE" ]; then
	
	    $SMBCLIENT -g -L $smbhost -A "$CREDENTIAL_FILE" 2>>/dev/null > $TMPDIR/$smbhost.sharesinfo

	else
		
	    $SMBCLIENT -g -N -L $smbhost 2>>/dev/null > $TMPDIR/$smbhost.sharesinfo
	    
	fi
	
	# find more info (netbiosname for example) of this host
	# only take the 00 records
    
	$NMBLOOKUP --debuglevel=0 -A $smbhost 2>>/dev/null | grep ' <00> ' > $TMPDIR/$smbhost.serverinfo
    
    
	if [ -f $TMPDIR/$smbhost.sharesinfo -a -f $TMPDIR/$smbhost.serverinfo ]; then
    
	    
	    SMB_workgroup=$(cat $TMPDIR/$smbhost.serverinfo | grep '<GROUP>' | awk '{ print $1 }')
	    SMB_netbiosname=$(cat $TMPDIR/$smbhost.serverinfo | grep --invert-match '<GROUP>' | awk '{ print $1 }')
	    
	    # create the mappings: path linked to the unc address
	    # note the ip= option, required by CIFS (at least on my machine)
	
    	    for SMB_share in $(cat $TMPDIR/$smbhost.sharesinfo | grep "^Disk" | cut -d "|" -f 2); do
	
		echo "\\"

		echo -n "/$SMB_workgroup/$SMB_netbiosname/$SMB_share -rw,ip=$smbhost ://$SMB_netbiosname/$SMB_share "
	    
	    done
	
	fi

    
    done
    
fi
--Boundary-00=_gcakISbQFgduY3G
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Boundary-00=_gcakISbQFgduY3G--

