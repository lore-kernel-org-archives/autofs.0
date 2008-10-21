From: Stef Bon <stef@bononline.nl>
Subject: Modified auto.smb script
Date: Tue, 21 Oct 2008 14:51:30 +0200
Message-ID: <200810211451.31096.stef@bononline.nl>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TBd/InaVIBUSMOH"
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

--Boundary-00=_TBd/InaVIBUSMOH
Content-Type: multipart/alternative;
  boundary="Boundary-00=_TBd/Ir00LC+47iZ"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-00=_TBd/Ir00LC+47iZ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

Hello all,

I've modified the auto.smb script to make use of cifs in stead of smbfs.

In my network mounting a SMB share with cifs fails, unless the ipaddress is an 
option:ip=$ipaddress. 

It uses the tool nmblookup for that.

Futher I'm working on an howto which describes the various ways to mount SMB 
shares. Look at:

http://linux.bononline.nl/linux/automountsmbshares/


It's not ready yet, still working on it.

I'll report again when it's ready.

Stef Bon
the Netherlands

--Boundary-00=_TBd/Ir00LC+47iZ
Content-Type: text/html;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd"><html><head><meta name="qrichtext" content="1" /><style type="text/css">p, li { white-space: pre-wrap; }</style></head><body style=" font-family:'Sans Serif'; font-size:10pt; font-weight:400; font-style:normal;">Hello all,<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>I've modified the auto.smb script to make use of cifs in stead of smbfs.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>In my network mounting a SMB share with cifs fails, unless the ipaddress is an option:ip=$ipaddress. <br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>It uses the tool nmblookup for that.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>Futher I'm working on an howto which describes the various ways to mount SMB shares. Look at:<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>http://linux.bononline.nl/linux/automountsmbshares/<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p><p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>It's not ready yet, still working on it.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>I'll report again when it's ready.<br>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;"><br></p>Stef Bon<br>
the Netherlands</p></body></html>
--Boundary-00=_TBd/Ir00LC+47iZ--

--Boundary-00=_TBd/InaVIBUSMOH
Content-Type: application/x-shellscript;
  name="auto.smb"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="auto.smb"

#!/bin/bash

# This file must be executable to work! chmod 755!

key="$1"

FILESYSTEM="cifs"

if [ "$FILESYSTEM" = "cifs" ]; then

    for P in /bin /sbin /usr/bin /usr/sbin
    do
	if [ -x $P/nmblookup ]
	then
		NMBLOOKUP=$P/nmblookup
		break
	fi
    done

    [ -x $NMBLOOKUP ] || exit 1
    
    ipaddress=$($NMBLOOKUP $key --debug-level=0 2>>/dev/null | grep '<00>' | awk '{ print $1 }')

    if [ -z "$ipaddress" ]; then

	exit 1
    
    fi
    
    opts="-fstype=cifs,guest,ip=$ipaddress"
    
    
else

    opts="-fstype=$FILESYSTEM,guest"
    
fi

for P in /bin /sbin /usr/bin /usr/sbin
do
	if [ -x $P/smbclient ]
	then
		SMBCLIENT=$P/smbclient
		break
	fi
done

[ -x $SMBCLIENT ] || exit 1

$SMBCLIENT -gNL $key 2>/dev/null| awk -v key="$key" -v opts="$opts" -F'|' -- '
	BEGIN	{ ORS=""; first=1 }
	/Disk/	{
		  if (first)
			print opts; first=0
		  dir = $2
		  loc = $2
		  # Enclose mount dir and location in quotes
		  # Double quote "$" in location as it is special
		  gsub(/\$$/, "\\$", loc);
		  print " \\\n\t \"/" dir "\"", "\"://" key "/" loc "\""
		}
	END 	{ if (!first) print "\n"; else exit 1 }
	'


--Boundary-00=_TBd/InaVIBUSMOH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--Boundary-00=_TBd/InaVIBUSMOH--

