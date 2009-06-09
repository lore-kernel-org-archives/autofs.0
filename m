From: Matthew Jurgens <autofs@edcint.co.nz>
Subject: Re: unable to automount windows C$
Date: Tue, 09 Jun 2009 19:35:19 +1000
Message-ID: <4A2E2CD7.20905@edcint.co.nz>
References: <9728fb580812101149s300c524dn5f6785c16bac969c@mail.gmail.com>
	<1230012791.3043.6.camel@zeus.themaw.net>
	<4A07749D.4000406@edcint.co.nz> <4A08FEE6.7000604@themaw.net>
	<4A0A533A.3060203@edcint.co.nz> <4A0A5527.2060207@themaw.net>
	<4A0A59F5.1090308@edcint.co.nz> <4A0A5B80.4040303@themaw.net>
	<4A0A5EE7.3020806@edcint.co.nz> <4A0A7ECB.2060604@themaw.net>
	<4A0B5DED.1090900@edcint.co.nz> <4A0B808C.2030705@themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1511106405449679451=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A0B808C.2030705@themaw.net>
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

This is a multi-part message in MIME format.
--===============1511106405449679451==
Content-Type: multipart/alternative;
 boundary="------------020407060202050104060407"

This is a multi-part message in MIME format.
--------------020407060202050104060407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


>> Good bet.
>> It certainly does fail. The output of mount for that is now:
>>
>> //xp0/C/$ on /mnt/C$ type cifs (rw,mand)
>>
>> Reading ahead in the thread Jeff says "'\' is a valid character in posix
>> path components" which does explain this behaviour
>>
>> Do you really need the \ in front of the $ when it is already quoted?
>>
>> Reading ahead again I comment out the gsub in /etc/auto.smb which
>> changes the output from
>> -fstype=cifs,username=USER,password=PASS \
>>         /C "://xp0/C" \
>>         /ADMIN\$ "://xp0/ADMIN\$" \
>>         /C\$ "://xp0/C\$"
>>
>> to
>>
>> -fstype=cifs,username=USER,password=PASS \
>>         /C "://xp0/C" \
>>         /ADMIN$ "://xp0/ADMIN$" \
>>         /C$ "://xp0/C$"
>>     
>
> Of course, it then doesn't escape $ in the offsets.
> But, it looks like your script isn't up to date.
> I'm fairly sure the current script should output:
>  -fstype=cifs,username=USER,password=PASS \
>          "/C" "://xp0/C" \
>          "/ADMIN$" "://xp0/ADMIN$" \
>          "/C$" "://xp0/C$"
>
> which is why I thought we shouldn't need the "\" escapes.
> Can you check your auto.smb against the one attached please, in
> particular the last line at the bottom of the "/Disk/" block should be:
>
> print " \\\n\t \"/" dir "\"", "\"://" key "/" loc "\""
>
> Ian
>
>   
Ian you are brilliant. You know your product very well. Thank you very 
much for your help

I now submit my modified version of the auto.smb script. This auto.smb 
script optionally supports authentication of smb/cifs shares. Only 
tested under Fedora 10. Based on the original script as distributed, the 
work in this thread and my own script.

#!/bin/sh
# This file must be executable to work! chmod 755!
# autofs samba script by Matthew Jurgens June 2009
# based on the original script distributed with autofs
# optionally uses authentication for smb/cifs shares
# mounts shares ending in $ successfully (Thanks to Ian Kent)

# optional authentication information
# either set it here or pass it in via the environment
# SMB_USER=
# SMB_PASSWORD

key="$1" # key comes is as something like a hostname eg matthew

if [ "$SMB_USER" ]; then
   opts="-fstype=cifs,username=$SMB_USER,password=$SMB_PASSWORD"

   # setup up the authentication file for smbmount
   # Sept 2008
   # Going to Fedora 9 smbmount no longer worked properly with the 
username%password syntax
   # Had to implement the auth file using the -A parameter
   smbauthfile=/tmp/smbauth.tmp
   echo "username=$SMB_USER" > $smbauthfile
   echo "password=$SMB_PASSWORD" >> $smbauthfile

   # set up the optional parameter for smbmount for using authentication
   auth_part="-A $smbauthfile"

else
   # set up default options - no authentication
   opts="-fstype=cifs"
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

$SMBCLIENT $auth_part -gL $key 2>/dev/null| awk -v key="$key" -v 
opts="$opts" -F'|' -- '
    BEGIN    { ORS=""; first=1 }
    /Disk/    {
          if (first)
            print opts; first=0
          dir = $2
          loc = $2
          # Enclose mount dir and location in quotes
          # Double quote "$" in location as it is special
          # gsub(/\$$/, "\\$", loc);
          print " \\\n\t \"/" dir "\"", "\"://" key "/" loc "\""
        }
    END     { if (!first) print "\n"; else exit 1 }
    '
   
rm -f $smbauthfile


-- 
Smartmon System Monitoring <http://www.smartmon.com.au>
www.smartmon.com.au

--------------020407060202050104060407
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
<blockquote cite="mid:4A0B808C.2030705@themaw.net" type="cite">
  <blockquote type="cite">
    <pre wrap="">Good bet.
It certainly does fail. The output of mount for that is now:

//xp0/C/$ on /mnt/C$ type cifs (rw,mand)

Reading ahead in the thread Jeff says "'\' is a valid character in posix
path components" which does explain this behaviour

Do you really need the \ in front of the $ when it is already quoted?

Reading ahead again I comment out the gsub in /etc/auto.smb which
changes the output from
-fstype=cifs,username=USER,password=PASS \
        /C "://xp0/C" \
        /ADMIN\$ "://xp0/ADMIN\$" \
        /C\$ "://xp0/C\$"

to

-fstype=cifs,username=USER,password=PASS \
        /C "://xp0/C" \
        /ADMIN$ "://xp0/ADMIN$" \
        /C$ "://xp0/C$"
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Of course, it then doesn't escape $ in the offsets.
But, it looks like your script isn't up to date.
I'm fairly sure the current script should output:
 -fstype=cifs,username=USER,password=PASS \
         "/C" "://xp0/C" \
         "/ADMIN$" "://xp0/ADMIN$" \
         "/C$" "://xp0/C$"

which is why I thought we shouldn't need the "\" escapes.
Can you check your auto.smb against the one attached please, in
particular the last line at the bottom of the "/Disk/" block should be:

print " \\\n\t \"/" dir "\"", "\"://" key "/" loc "\""

Ian

  </pre>
</blockquote>
Ian you are brilliant. You know your product very well. Thank you very
much for your help<br>
<br>
I now submit my modified version of the auto.smb script. This auto.smb
script optionally supports authentication of smb/cifs shares. Only
tested under Fedora 10. Based on the original script as distributed,
the work in this thread and my own script.<br>
<br>
#!/bin/sh<br>
# This file must be executable to work! chmod 755!<br>
# autofs samba script by Matthew Jurgens June 2009<br>
# based on the original script distributed with autofs<br>
# optionally uses authentication for smb/cifs shares<br>
# mounts shares ending in $ successfully (Thanks to Ian Kent)<br>
<br>
# optional authentication information<br>
# either set it here or pass it in via the environment<br>
# SMB_USER=<br>
# SMB_PASSWORD<br>
<br>
key="$1" # key comes is as something like a hostname eg matthew<br>
<br>
if [ "$SMB_USER" ]; then<br>
&nbsp;&nbsp; opts="-fstype=cifs,username=$SMB_USER,password=$SMB_PASSWORD"<br>
<br>
&nbsp;&nbsp; # setup up the authentication file for smbmount<br>
&nbsp;&nbsp; # Sept 2008<br>
&nbsp;&nbsp; # Going to Fedora 9 smbmount no longer worked properly with the
username%password syntax<br>
&nbsp;&nbsp; # Had to implement the auth file using the -A parameter <br>
&nbsp;&nbsp; smbauthfile=/tmp/smbauth.tmp<br>
&nbsp;&nbsp; echo "username=$SMB_USER" &gt; $smbauthfile<br>
&nbsp;&nbsp; echo "password=$SMB_PASSWORD" &gt;&gt; $smbauthfile<br>
<br>
&nbsp;&nbsp; # set up the optional parameter for smbmount for using authentication<br>
&nbsp;&nbsp; auth_part="-A $smbauthfile"<br>
<br>
else<br>
&nbsp;&nbsp; # set up default options - no authentication<br>
&nbsp;&nbsp; opts="-fstype=cifs"<br>
fi<br>
<br>
for P in /bin /sbin /usr/bin /usr/sbin<br>
do<br>
&nbsp;&nbsp;&nbsp; if [ -x $P/smbclient ]<br>
&nbsp;&nbsp;&nbsp; then<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; SMBCLIENT=$P/smbclient<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; break<br>
&nbsp;&nbsp;&nbsp; fi<br>
done<br>
<br>
[ -x $SMBCLIENT ] || exit 1<br>
<br>
$SMBCLIENT $auth_part -gL $key 2&gt;/dev/null| awk -v key="$key" -v
opts="$opts" -F'|' -- '<br>
&nbsp;&nbsp;&nbsp; BEGIN&nbsp;&nbsp;&nbsp; { ORS=""; first=1 }<br>
&nbsp;&nbsp;&nbsp; /Disk/&nbsp;&nbsp;&nbsp; {<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; if (first)<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; print opts; first=0<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; dir = $2<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; loc = $2<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; # Enclose mount dir and location in quotes<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; # Double quote "$" in location as it is special<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; # gsub(/\$$/, "\\$", loc);<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; print " \\\n\t \"/" dir "\"", "\"://" key "/" loc "\""<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp; END &nbsp;&nbsp;&nbsp; { if (!first) print "\n"; else exit 1 }<br>
&nbsp;&nbsp;&nbsp; '<br>
&nbsp;&nbsp;&nbsp; <br>
rm -f $smbauthfile<br>
<br>
<br>
<div class="moz-signature">-- <br>
<font size="2"><font face="Verdana">
<a href="http://www.smartmon.com.au">Smartmon System Monitoring</a><br>
<a class="moz-txt-link-abbreviated" href="http://www.smartmon.com.au">www.smartmon.com.au</a>
</font></font></div>
</body>
</html>

--------------020407060202050104060407--


--===============1511106405449679451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1511106405449679451==--

