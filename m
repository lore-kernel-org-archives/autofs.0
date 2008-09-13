From: Matthew Jurgens <autofs@edcint.co.nz>
Subject: Re: Not correctly mount SMB shares ending in $
Date: Sat, 13 Sep 2008 12:03:29 +1000
Message-ID: <48CB1F71.50407@edcint.co.nz>
References: <48C5F518.9010800@edcint.co.nz>	
	<1221018586.3030.63.camel@raven.themaw.net>
	<48C8D7FE.9000501@edcint.co.nz>
	<1221142584.28271.15.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6951816543634546730=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1221142584.28271.15.camel@raven.themaw.net>
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
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

This is a multi-part message in MIME format.
--===============6951816543634546730==
Content-Type: multipart/alternative;
 boundary="------------020108060700040501000703"

This is a multi-part message in MIME format.
--------------020108060700040501000703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ok, so I updated the script to the RPM version and added the 
authentication parts:

#!/bin/bash

# This file must be executable to work! chmod 755!
key="$1" # key comes is as something like a hostname eg matthew
opts="-fstype=cifs,username=$SMB_USER,password=$SMB_PASSWORD"

smbauthfile=/tmp/smbauth.tmp
cat << EOT > $smbauthfile
username=$SMB_USER
password=$SMB_PASSWORD
EOT

for P in /bin /sbin /usr/bin /usr/sbin
do
        if [ -x $P/smbclient ]
        then
                SMBCLIENT=$P/smbclient
                break
        fi
done

[ -x $SMBCLIENT ] || exit 1

$SMBCLIENT -A $smbauthfile -gL $key 2>/dev/null| awk -v key="$key" -v 
opts="$opts" -F'|' -- '
        BEGIN   { ORS=""; first=1 }
        /Disk/  {
                  if (first)
                        print opts; first=0
                  dir = $2
                  loc = $2
                  # Enclose mount dir and location in quotes
                  # Double quote "$" in location as it is special
                  gsub(/\$$/, "\\$", loc);
                  print " \\\n\t \"/" dir "\"", "\"://" key "/" loc "\""
                }
        END     { if (!first) print "\n"; else exit 1 }
        '



Now its output is slightly different but the result is still the same
-fstype=cifs,username=USER,password=PASSWORD \
         "/C" "://xp0/C" \
         "/ADMIN$" "://xp0/ADMIN\$" \
         "/C$" "://xp0/C\$"

vs the older output

-fstype=cifs,username=USER,password=PASSWORD \
         /C "://xp0/C" \
         /ADMIN\$ "://xp0/ADMIN\$" \
         /C\$ "://xp0/C\$"

mount:
//xp0/C/$ on /smb/xp0/C$ type cifs (rw,mand)


>
> That doesn't look quite right.
> It might be an out of date script, how about posting the script as well
>   
>

--------------020108060700040501000703
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Ok, so I updated the script to the RPM version and added the
authentication parts:<br>
<br>
#!/bin/bash<br>
<br>
# This file must be executable to work! chmod 755!<br>
key="$1" # key comes is as something like a hostname eg matthew<br>
opts="-fstype=cifs,username=$SMB_USER,password=$SMB_PASSWORD"<br>
<br>
smbauthfile=/tmp/smbauth.tmp<br>
cat &lt;&lt; EOT &gt; $smbauthfile<br>
username=$SMB_USER<br>
password=$SMB_PASSWORD<br>
EOT<br>
<br>
for P in /bin /sbin /usr/bin /usr/sbin<br>
do<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if [ -x $P/smbclient ]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; then<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SMBCLIENT=$P/smbclient<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fi<br>
done<br>
<br>
[ -x $SMBCLIENT ] || exit 1<br>
<br>
$SMBCLIENT -A $smbauthfile -gL $key 2&gt;/dev/null| awk -v key="$key"
-v opts="$opts" -F'|' -- '<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BEGIN&nbsp;&nbsp; { ORS=""; first=1 }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /Disk/&nbsp; {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (first)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; print opts; first=0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dir = $2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; loc = $2<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Enclose mount dir and location in quotes<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Double quote "$" in location as it is special<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gsub(/\$$/, "\\$", loc);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; print " \\\n\t \"/" dir "\"", "\"://" key "/" loc "\""<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; END&nbsp;&nbsp;&nbsp;&nbsp; { if (!first) print "\n"; else exit 1 }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; '<br>
<br>
<br>
<br>
Now its output is slightly different but the result is still the same<br>
-fstype=cifs,username=USER,password=PASSWORD \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "/C" "://xp0/C" \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "/ADMIN$" "://xp0/ADMIN\$" \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "/C$" "://xp0/C\$"<br>
<br>
vs the older output<br>
<pre wrap="">-fstype=cifs,username=USER,password=PASSWORD \
         /C "://xp0/C" \
         /ADMIN\$ "://xp0/ADMIN\$" \
         /C\$ "://xp0/C\$"</pre>
mount:<br>
//xp0/C/$ on /smb/xp0/C$ type cifs (rw,mand)<br>
<br>
<br>
<blockquote cite="mid:1221142584.28271.15.camel@raven.themaw.net"
 type="cite">
  <pre wrap=""><!---->
That doesn't look quite right.
It might be an out of date script, how about posting the script as well
  </pre>
  <br>
</blockquote>
</body>
</html>

--------------020108060700040501000703--


--===============6951816543634546730==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============6951816543634546730==--

