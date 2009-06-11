From: Ian Kent <raven@themaw.net>
Subject: Re: unable to automount windows C$
Date: Thu, 11 Jun 2009 14:23:55 +0800
Message-ID: <4A30A2FB.5050005@themaw.net>
References: <9728fb580812101149s300c524dn5f6785c16bac969c@mail.gmail.com>
	<1230012791.3043.6.camel@zeus.themaw.net>
	<4A07749D.4000406@edcint.co.nz> <4A08FEE6.7000604@themaw.net>
	<4A0A533A.3060203@edcint.co.nz> <4A0A5527.2060207@themaw.net>
	<4A0A59F5.1090308@edcint.co.nz> <4A0A5B80.4040303@themaw.net>
	<4A0A5EE7.3020806@edcint.co.nz> <4A0A7ECB.2060604@themaw.net>
	<4A0B5DED.1090900@edcint.co.nz> <4A0B808C.2030705@themaw.net>
	<4A2E2CD7.20905@edcint.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4A2E2CD7.20905@edcint.co.nz>
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
To: Matthew Jurgens <autofs@edcint.co.nz>
Cc: autofs@linux.kernel.org

Matthew Jurgens wrote:
> 
>>> Good bet.
>>> It certainly does fail. The output of mount for that is now:
>>>
>>> //xp0/C/$ on /mnt/C$ type cifs (rw,mand)
>>>
>>> Reading ahead in the thread Jeff says "'\' is a valid character in posix
>>> path components" which does explain this behaviour
>>>
>>> Do you really need the \ in front of the $ when it is already quoted?
>>>
>>> Reading ahead again I comment out the gsub in /etc/auto.smb which
>>> changes the output from
>>> -fstype=cifs,username=USER,password=PASS \
>>>         /C "://xp0/C" \
>>>         /ADMIN\$ "://xp0/ADMIN\$" \
>>>         /C\$ "://xp0/C\$"
>>>
>>> to
>>>
>>> -fstype=cifs,username=USER,password=PASS \
>>>         /C "://xp0/C" \
>>>         /ADMIN$ "://xp0/ADMIN$" \
>>>         /C$ "://xp0/C$"
>>>     
>>
>> Of course, it then doesn't escape $ in the offsets.
>> But, it looks like your script isn't up to date.
>> I'm fairly sure the current script should output:
>>  -fstype=cifs,username=USER,password=PASS \
>>          "/C" "://xp0/C" \
>>          "/ADMIN$" "://xp0/ADMIN$" \
>>          "/C$" "://xp0/C$"
>>
>> which is why I thought we shouldn't need the "\" escapes.
>> Can you check your auto.smb against the one attached please, in
>> particular the last line at the bottom of the "/Disk/" block should be:
>>
>> print " \\\n\t \"/" dir "\"", "\"://" key "/" loc "\""
>>
>> Ian
>>
>>   
> Ian you are brilliant. You know your product very well. Thank you very
> much for your help
> 
> I now submit my modified version of the auto.smb script. This auto.smb
> script optionally supports authentication of smb/cifs shares. Only
> tested under Fedora 10. Based on the original script as distributed, the
> work in this thread and my own script.

There are a couple of problems with this.

The first thing is that it isn't a patch, it's just a verbatim script.
While this isn't really an issue with this change this is the way it
needs to be done.

Patches should be used to request changes and should apply from the top
of the distribution tree when a "-p1" option is used with the patch
utility and the "-p" option should be used with the diff utility when
making them to give better context.

If you have a Fedora or rpm based distribution the gendiff utility, from
the rpm-build package is quite useful for this, although I seem to
remember needing to add the -p option for the diff to the script.

Also, patches should address one issue, where possible, and have an
accompanying description of what issue or enhancement the patch is
addressing and why you believe it works and any other pertinent information.

For some time now I've been trying to "always" include descriptions with
patches I add to autofs so I think anyone else requesting changes should
do the same.

In this example, I think, there are two distinct changes, the addition
of a couple of variables and the commenting out of the gsub() call.

But moving along ...

> 
> #!/bin/sh
> # This file must be executable to work! chmod 755!
> # autofs samba script by Matthew Jurgens June 2009
> # based on the original script distributed with autofs
> # optionally uses authentication for smb/cifs shares
> # mounts shares ending in $ successfully (Thanks to Ian Kent)
> 
> # optional authentication information
> # either set it here or pass it in via the environment
> # SMB_USER=
> # SMB_PASSWORD

I don't think that embedding password information in a distributed
example program map is the right thing to do. People need to work out
how they will access authentication information for themselves and
modify the example program map to suite.

Also, I don't understand how this can be set in the environment. If it
is set in the daemon environment, typically root, and used for every
mount then I don't think that is a good example of usage to distribute
either.

> 
> key="$1" # key comes is as something like a hostname eg matthew
> 
> if [ "$SMB_USER" ]; then
>   opts="-fstype=cifs,username=$SMB_USER,password=$SMB_PASSWORD"
> 
>   # setup up the authentication file for smbmount
>   # Sept 2008
>   # Going to Fedora 9 smbmount no longer worked properly with the
> username%password syntax
>   # Had to implement the auth file using the -A parameter
>   smbauthfile=/tmp/smbauth.tmp
>   echo "username=$SMB_USER" > $smbauthfile
>   echo "password=$SMB_PASSWORD" >> $smbauthfile
> 
>   # set up the optional parameter for smbmount for using authentication
>   auth_part="-A $smbauthfile"
> 
> else
>   # set up default options - no authentication
>   opts="-fstype=cifs"
> fi
> 
> for P in /bin /sbin /usr/bin /usr/sbin
> do
>    if [ -x $P/smbclient ]
>    then
>        SMBCLIENT=$P/smbclient
>        break
>    fi
> done
> 
> [ -x $SMBCLIENT ] || exit 1
> 
> $SMBCLIENT $auth_part -gL $key 2>/dev/null| awk -v key="$key" -v
> opts="$opts" -F'|' -- '
>    BEGIN    { ORS=""; first=1 }
>    /Disk/    {
>          if (first)
>            print opts; first=0
>          dir = $2
>          loc = $2
>          # Enclose mount dir and location in quotes
>          # Double quote "$" in location as it is special
>          # gsub(/\$$/, "\\$", loc);

OK, so this is probably the correction I need to apply, but a patch
would remove this line and add a brief description of the reasoning.

>          print " \\\n\t \"/" dir "\"", "\"://" key "/" loc "\""
>        }
>    END     { if (!first) print "\n"; else exit 1 }
>    '
>   rm -f $smbauthfile
> 
> 
