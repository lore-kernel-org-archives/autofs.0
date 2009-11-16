From: "Breitman, Jason" <Jason.Breitman@blackrock.com>
Subject: Re: automount restart required
Date: Sun, 15 Nov 2009 22:13:11 -0500
Message-ID: <5FAC3462B446C244A45ED5303B61491111920B0C@NYCPEXV005.na.blkint.com>
References: <5FAC3462B446C244A45ED5303B614911119209EC@NYCPEXV005.na.blkint.com>
	<4AF23160.2000600@themaw.net>
	<5FAC3462B446C244A45ED5303B61491111920A41@NYCPEXV005.na.blkint.com>
	<4AF380AD.2060506@themaw.net>
	<5FAC3462B446C244A45ED5303B61491111920A8A@NYCPEXV005.na.blkint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <5FAC3462B446C244A45ED5303B61491111920A8A@NYCPEXV005.na.blkint.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

It appears that there are a few negatives to using direct maps so I have
been evaluating other options.
	You must restart autofs anytime updates are made to the direct
map.
	All entries in the direct map show up in /proc/mounts and I
believe coincide with a mount which will cause a strain on the NFS
Server. (mount storm)

I noticed a difference between /etc/mtab and /proc/mounts and hope
someone can explain the difference.
This may help me identify the issue I am seeing.

Steps to reproduce:
[jbreitma@host ~]# ls /clients/Client1/tmpint/
oas  prodops

[jbreitma@host ~]# grep Client1 /etc/mtab
Client1-nfs.Client1.blackrock.com:/clients/Client10101/homes1/tmpint
/clients/Client1/tmpint nfs rw,hard,intr,addr=1.1.1.1 0 0

[jbreitma@host ~]# grep Client1 /proc/mounts
prod-autofs.clients.common /clients/Client1/apps autofs
rw,fd=59,pgrp=4040,timeout=1800,minproto=5,maxproto=5,offset 0 0
prod-autofs.clients.common /clients/Client1/d0/prod1/reports autofs
rw,fd=59,pgrp=4040,timeout=1800,minproto=5,maxproto=5,offset 0 0
prod-autofs.clients.common /clients/Client1/proj/GPA/historical-data
autofs rw,fd=59,pgrp=4040,timeout=1800,minproto=5,maxproto=5,offset 0 0
prod-autofs.clients.common /clients/Client1/proj/pkg_test autofs
rw,fd=59,pgrp=4040,timeout=1800,minproto=5,maxproto=5,offset 0 0
prod-autofs.clients.common /clients/Client1/proj/space autofs
rw,fd=59,pgrp=4040,timeout=1800,minproto=5,maxproto=5,offset 0 0
prod-autofs.clients.common /clients/Client1/tmpint autofs
rw,fd=59,pgrp=4040,timeout=1800,minproto=5,maxproto=5,offset 0 0
prod-autofs.clients.common /clients/Client1/u1/cliops autofs
rw,fd=59,pgrp=4040,timeout=1800,minproto=5,maxproto=5,offset 0 0
prod-autofs.clients.common /clients/Client1/u1/prod/reports autofs
rw,fd=59,pgrp=4040,timeout=1800,minproto=5,maxproto=5,offset 0 0
prod-autofs.clients.common /clients/Client1/usr/local/bfm/std autofs
rw,fd=59,pgrp=4040,timeout=1800,minproto=5,maxproto=5,offset 0 0
prod-autofs.clients.common /clients/Client1/web/htdocs autofs
rw,fd=59,pgrp=4040,timeout=1800,minproto=5,maxproto=5,offset 0 0
Client1-nfs.Client1.blackrock.com:/clients/Client10101/homes1/tmpint
/clients/Client1/tmpint nfs
rw,vers=3,rsize=1048576,wsize=1048576,hard,intr,proto=tcp,timeo=600,retr
ans=2,sec=sys,addr=Client1-nfs.Client1.blackrock.com 0 0

[jbreitma@host ~]# umount /clients/Client1/tmpint

[jbreitma@host ~]# grep Client1 /etc/mtab

[jbreitma@host ~]#

[jbreitma@host ~]# grep Client1 /proc/mounts
prod-autofs.clients.common /clients/Client1/apps autofs
rw,fd=59,pgrp=4040,timeout=1800,minproto=5,maxproto=5,offset 0 0
prod-autofs.clients.common /clients/Client1/d0/prod1/reports autofs
rw,fd=59,pgrp=4040,timeout=1800,minproto=5,maxproto=5,offset 0 0
prod-autofs.clients.common /clients/Client1/proj/GPA/historical-data
autofs rw,fd=59,pgrp=4040,timeout=1800,minproto=5,maxproto=5,offset 0 0
prod-autofs.clients.common /clients/Client1/proj/pkg_test autofs
rw,fd=59,pgrp=4040,timeout=1800,minproto=5,maxproto=5,offset 0 0
prod-autofs.clients.common /clients/Client1/proj/space autofs
rw,fd=59,pgrp=4040,timeout=1800,minproto=5,maxproto=5,offset 0 0
prod-autofs.clients.common /clients/Client1/tmpint autofs
rw,fd=59,pgrp=4040,timeout=1800,minproto=5,maxproto=5,offset 0 0
prod-autofs.clients.common /clients/Client1/u1/cliops autofs
rw,fd=59,pgrp=4040,timeout=1800,minproto=5,maxproto=5,offset 0 0
prod-autofs.clients.common /clients/Client1/u1/prod/reports autofs
rw,fd=59,pgrp=4040,timeout=1800,minproto=5,maxproto=5,offset 0 0
prod-autofs.clients.common /clients/Client1/usr/local/bfm/std autofs
rw,fd=59,pgrp=4040,timeout=1800,minproto=5,maxproto=5,offset 0 0
prod-autofs.clients.common /clients/Client1/web/htdocs autofs
rw,fd=59,pgrp=4040,timeout=1800,minproto=5,maxproto=5,offset 0 0


After some time, Client1 is no longer visible in /proc/mounts.
I would be interested to know what is going on, but would settle for a
command to run that could provide a consistent answer between /etc/mtab
and /proc/mounts.

Thanks.

Jason Breitman
jason.breitman@blackrock.com

-----Original Message-----
From: Breitman, Jason 
Sent: Tuesday, November 10, 2009 10:57 AM
To: 'Ian Kent'
Cc: autofs@linux.kernel.org
Subject: RE: [autofs] automount restart required

I will give an example of 1 stanza to help provide clarity of the map.

/clients/CLIENT1 is the offset

Once logged into a host you can cd to

/clients/CLIENT1/proj/space

/clients/CLIENT1/proj/pkg_test

/clients/CLIENT1/proj/GPA/historical-data

/clients/CLIENT1/d0/prod1/reports

/clients/CLIENT1/u1/prod/reports

/clients/CLIENT1/usr/local/bfm/std

/clients/CLIENT1/tmpint

/clients/CLIENT1/apps

/clients/CLIENT1/web/htdocs

All mounts are under the offset /clients/CLIENT1.
I hope I am clear in my explanation.

/etc/auto.master has the below entry

/clients        prod-autofs.clients.common      -hard,intr

prod-autofs.clients.common has the below entry

Client1 /proj/space
Client1-nfs.Client1.blackrock.com:/clients/Client10103/proj/space \
        /proj/pkg_test
Client1-nfs.Client1.blackrock.com:/clients/Client10103/proj/pkg_test \
        /proj/GPA/historical-data
Client1-nfs.Client1.blackrock.com:/clients/Client10103/proj/GPA/historic
al-data \
        /d0/prod1/reports
Client1-nfs.Client1.blackrock.com:/clients/Client10102/d0/prod1/reports
\
        /u1/d0/prod1/reports
Client1-nfs.Client1.blackrock.com:/clients/Client10102/d0/prod1/reports
\
        /u1/prod/reports
Client1-nfs.Client1.blackrock.com:/clients/Client10102/d0/prod1/reports
\
        /usr/local/bfm/std
Client1-nfs.Client1.blackrock.com:/clients/Client10101/local/bfm/std \
        /tmpint
Client1-nfs.Client1.blackrock.com:/clients/Client10101/homes1/tmpint \
        /apps
Client1-nfs.Client1.blackrock.com:/clients/Client10101/local/bfm/apps \
        /web/htdocs
Client1-nfs.Client1.blackrock.com:/clients/Client10101/local/bfm/web/htd
ocs

I thought my mistake might have been that /etc/auto.master should look
like (indirect vs. direct map)

/-        prod-autofs.clients.common      -hard,intr

and prod-autofs.clients.common should look like

/clients/Client1 \
        /proj/space
Client1-nfs.Client1.blackrock.com:/clients/Client10103/proj/space \
        /proj/pkg_test
Client1-nfs.Client1.blackrock.com:/clients/Client10103/proj/pkg_test \
        /proj/GPA/historical-data
Client1-nfs.Client1.blackrock.com:/clients/Client10103/proj/GPA/historic
al-data \
        /d0/prod1/reports
Client1-nfs.Client1.blackrock.com:/clients/Client10102/d0/prod1/reports
\
        /u1/d0/prod1/reports
Client1-nfs.Client1.blackrock.com:/clients/Client10102/d0/prod1/reports
\
        /u1/prod/reports
Client1-nfs.Client1.blackrock.com:/clients/Client10102/d0/prod1/reports
\
        /usr/local/bfm/std
Client1-nfs.Client1.blackrock.com:/clients/Client10101/local/bfm/std \
        /tmpint
Client1-nfs.Client1.blackrock.com:/clients/Client10101/homes1/tmpint \
        /apps
Client1-nfs.Client1.blackrock.com:/clients/Client10101/local/bfm/apps \
        /web/htdocs
Client1-nfs.Client1.blackrock.com:/clients/Client10101/local/bfm/web/htd
ocs

Please say if the formatting gets garbled and I will figure out some
other way to get you the map entries.


Jason Breitman
jason.breitman@blackrock.com

-----Original Message-----
From: Ian Kent [mailto:raven@themaw.net] 
Sent: Thursday, November 05, 2009 8:50 PM
To: Breitman, Jason
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] automount restart required

Breitman, Jason wrote:
> The map with the issues is prod-autofs.clients.common.
> I have included the contents below.
> There are about 20 stanzas, but I figured you get the point from the
> snippet I included.
> 
> One mistake I believe I made is that the map should be a direct map,
> (/-), and I made it a indirect map.
> I did not realize that there was such a difference until I looked at
the
> source code for automount.
> I am no expert, but there is a mentionable difference between indirect
> and direct maps.
> Do you think that could be my issue?

Don't know, maybe.

Using an indirect mount with entries that have offsets instead of direct
maps is fine and is the only valid way to setup map entries that are
nested (ie. where there are mounts within another mount).

> 
> $ cat /etc/auto.master 
> #
> # : auto.master,v 1.3 2003/09/29 08:22:35 raven Exp $
> #
> # Sample auto.master file
> # This is an automounter map and it has the following format
> # key [ -mount-options-separated-by-comma ] location
> # For details of the format look at autofs(5).
> #/misc  /etc/auto.misc --timeout=60
> #/misc  /etc/auto.misc
> #/net   /etc/auto.net
> /u1             prod-autofs.u1                  -hard,intr
> /proj           prod-autofs.proj                -hard,intr
> /usr/local      prod-autofs-linux.local         -hard,intr
> /reports        prod-autofs.reports             -hard,intr
> /clients        prod-autofs.clients.common      -hard,intr

I presume below is your prod-autofs.clients.common?
It looks a bit broken but that may just be the way it's formatted.

> 
> Client1 /proj/space

So this is the end of the first entry?
Where is the mount location?

> Client1-nfs.Client1.blackrock.com:/clients/Client10103/proj/space \
>         /proj/pkg_test

Then where is the key for this entry and what is that path doing there
without a mount location?

Each indirect map entry (with offsets) should have a form:

key [/] location [/path location [/path location ....]]

or

key [[/] location] /path location [/path location [/path location ....]]

An un-escaped newline marks a new map entry.

If there are too many offsets in a single entry and they aren't nested
then you can turn the map entry into a direct map. If some do have
nesting then you can use a direct mount map entry up to the point of the
nesting and then use offsets in that entry for the mounts below it.

These entries don't appear to match this syntax but that could just be
the formatting imposed by the mail client.

> Client1-nfs.Client1.blackrock.com:/clients/Client10103/proj/pkg_test \
>         /proj/GPA/historical-data
>
Client1-nfs.Client1.blackrock.com:/clients/Client10103/proj/GPA/historic
> al-data \
>         /d0/prod1/reports
>
Client1-nfs.Client1.blackrock.com:/clients/Client10102/d0/prod1/reports
> \
>         /u1/d0/prod1/reports
>
Client1-nfs.Client1.blackrock.com:/clients/Client10102/d0/prod1/reports
> \
>         /u1/prod/reports
>
Client1-nfs.Client1.blackrock.com:/clients/Client10102/d0/prod1/reports
> \
>         /usr/local/bfm/std
> Client1-nfs.Client1.blackrock.com:/clients/Client10101/local/bfm/std \
>         /tmpint
> Client1-nfs.Client1.blackrock.com:/clients/Client10101/homes1/tmpint \
>         /apps
> Client1-nfs.Client1.blackrock.com:/clients/Client10101/local/bfm/apps
\
>         /web/htdocs
>
Client1-nfs.Client1.blackrock.com:/clients/Client10101/local/bfm/web/htd
> ocs
> Client2 /proj/space
> Client2-nfs.Client2.blackrock.com:/clients/Client20101/proj/space \
>         /proj/pkg_test
> Client2-nfs.Client2.blackrock.com:/clients/Client20101/proj/pkg_test \
>         /proj/GPA/historical-data
>
Client2-nfs.Client2.blackrock.com:/clients/Client20101/proj/GPA/historic
> al-data \
>         /d0/prod1/reports
>
Client2-nfs.Client2.blackrock.com:/clients/Client20102/d0/prod1/reports
> \
>         /u1/d0/prod1/reports
>
Client2-nfs.Client2.blackrock.com:/clients/Client20102/d0/prod1/reports
> \
>         /u1/prod/reports
>
Client2-nfs.Client2.blackrock.com:/clients/Client20102/d0/prod1/reports
> \
>         /usr/local/bfm/std
> Client2-nfs.Client2.blackrock.com:/clients/Client20101/local/bfm/std \
>         /tmpint
> Client2-nfs.Client2.blackrock.com:/clients/Client20101/homes1/tmpint \
>         /apps
> Client2-nfs.Client2.blackrock.com:/clients/Client20101/local/bfm/apps
\
>         /web/htdocs
>
Client2-nfs.Client2.blackrock.com:/clients/Client20101/local/bfm/web/htd
> ocs
> Client3 /proj/space
> Client3-nfs.Client3.blackrock.com:/clients/Client30103/proj/space \
>         /proj/pkg_test
> Client3-nfs.Client3.blackrock.com:/clients/Client30103/proj/pkg_test \
>         /proj/GPA/historical-data
>
Client3-nfs.Client3.blackrock.com:/clients/Client30101/proj/GPA/historic
> al-data \
>         /d0/prod1/reports
>
Client3-nfs.Client3.blackrock.com:/clients/Client30102/d0/prod1/reports
> \
>         /u1/d0/prod1/reports
>
Client3-nfs.Client3.blackrock.com:/clients/Client30102/d0/prod1/reports
> \
>         /u1/prod/reports
>
Client3-nfs.Client3.blackrock.com:/clients/Client30102/d0/prod1/reports
> \
>         /usr/local/bfm/std
> Client3-nfs.Client3.blackrock.com:/clients/Client30101/local/bfm/std \
>         /tmpint
> Client3-nfs.Client3.blackrock.com:/clients/Client30101/homes1/tmpint \
>         /apps
> Client3-nfs.Client3.blackrock.com:/clients/Client30101/local/bfm/apps
\
>         /web/htdocs
>
Client3-nfs.Client3.blackrock.com:/clients/Client30101/local/bfm/web/htd
> ocs
> Client4 /proj/space
> Client4-nfs.Client4.blackrock.com:/clients/Client40101/rep/proj/space
\
>      /proj/pkg_test
>
Client4-nfs.Client4.blackrock.com:/clients/Client40101/rep/proj/pkg_test
> \
>      /proj/GPA/historical-data
>
Client4-nfs.Client4.blackrock.com:/clients/Client40101/rep/proj/GPA/hist
> orical-data \
>      /d0/prod1/reports
>
Client4-nfs.Client4.blackrock.com:/clients/Client40101/rep/d0/prod1/repo
> rts \
>      /u1/d0/prod1/reports
>
Client4-nfs.Client4.blackrock.com:/clients/Client40101/rep/d0/prod1/repo
> rts \
>      /u1/prod/reports
>
Client4-nfs.Client4.blackrock.com:/clients/Client40101/rep/d0/prod1/repo
> rts \
>      /usr/local/bfm/std
>
Client4-nfs.Client4.blackrock.com:/clients/Client40101/other/local/bfm/s
> td \
>      /tmpint
>
Client4-nfs.Client4.blackrock.com:/clients/Client40101/norep/homes/tmpin
> t \
>      /web/htdocs
>
Client4-nfs.Client4.blackrock.com:/clients/Client40101/other/local/bfm/w
> eb/htdocs \
>      /apps
>
Client4-nfs.Client4.blackrock.com:/clients/Client40101/other/local/bfm/a
> pps 
> 
> 
> Jason Breitman
> jason.breitman@blackrock.com
> 
> -----Original Message-----
> From: Ian Kent [mailto:raven@themaw.net] 
> Sent: Wednesday, November 04, 2009 8:59 PM
> To: Breitman, Jason
> Cc: autofs@linux.kernel.org
> Subject: Re: [autofs] automount restart required
> 
> Breitman, Jason wrote:
>> Issue:
>> Users and applications will not be able to get into one of the
>> directories in the direct map.
>> The system reports no such file or directory.
>> I can get to the mount point, but not any further.
> 
> Show me your maps.
> 
> Ian
> 
> THE INFORMATION CONTAINED IN THIS MESSAGE AND ANY ATTACHMENT MAY BE
PRIVILEGED, CONFIDENTIAL, PROPRIETARY OR OTHERWISE PROTECTED FROM
DISCLOSURE. If the reader of this message is not the intended recipient,
you are hereby notified that any dissemination, distribution, copying or
use of this message and any attachment is strictly prohibited. If you
have received this message in error, please notify us immediately by
replying to the message and permanently delete it from your computer and
destroy any printout thereof.


THE INFORMATION CONTAINED IN THIS MESSAGE AND ANY ATTACHMENT MAY BE PRIVILEGED, CONFIDENTIAL, PROPRIETARY OR OTHERWISE PROTECTED FROM DISCLOSURE. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, distribution, copying or use of this message and any attachment is strictly prohibited. If you have received this message in error, please notify us immediately by replying to the message and permanently delete it from your computer and destroy any printout thereof.
