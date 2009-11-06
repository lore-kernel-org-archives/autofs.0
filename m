From: "Breitman, Jason" <Jason.Breitman@blackrock.com>
Subject: Re: automount restart required
Date: Thu, 5 Nov 2009 19:55:54 -0500
Message-ID: <5FAC3462B446C244A45ED5303B61491111920A41@NYCPEXV005.na.blkint.com>
References: <5FAC3462B446C244A45ED5303B614911119209EC@NYCPEXV005.na.blkint.com>
	<4AF23160.2000600@themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
In-Reply-To: <4AF23160.2000600@themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

The map with the issues is prod-autofs.clients.common.
I have included the contents below.
There are about 20 stanzas, but I figured you get the point from the
snippet I included.

One mistake I believe I made is that the map should be a direct map,
(/-), and I made it a indirect map.
I did not realize that there was such a difference until I looked at the
source code for automount.
I am no expert, but there is a mentionable difference between indirect
and direct maps.
Do you think that could be my issue?

$ cat /etc/auto.master 
#
# : auto.master,v 1.3 2003/09/29 08:22:35 raven Exp $
#
# Sample auto.master file
# This is an automounter map and it has the following format
# key [ -mount-options-separated-by-comma ] location
# For details of the format look at autofs(5).
#/misc  /etc/auto.misc --timeout=60
#/misc  /etc/auto.misc
#/net   /etc/auto.net
/u1             prod-autofs.u1                  -hard,intr
/proj           prod-autofs.proj                -hard,intr
/usr/local      prod-autofs-linux.local         -hard,intr
/reports        prod-autofs.reports             -hard,intr
/clients        prod-autofs.clients.common      -hard,intr

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
Client2 /proj/space
Client2-nfs.Client2.blackrock.com:/clients/Client20101/proj/space \
        /proj/pkg_test
Client2-nfs.Client2.blackrock.com:/clients/Client20101/proj/pkg_test \
        /proj/GPA/historical-data
Client2-nfs.Client2.blackrock.com:/clients/Client20101/proj/GPA/historic
al-data \
        /d0/prod1/reports
Client2-nfs.Client2.blackrock.com:/clients/Client20102/d0/prod1/reports
\
        /u1/d0/prod1/reports
Client2-nfs.Client2.blackrock.com:/clients/Client20102/d0/prod1/reports
\
        /u1/prod/reports
Client2-nfs.Client2.blackrock.com:/clients/Client20102/d0/prod1/reports
\
        /usr/local/bfm/std
Client2-nfs.Client2.blackrock.com:/clients/Client20101/local/bfm/std \
        /tmpint
Client2-nfs.Client2.blackrock.com:/clients/Client20101/homes1/tmpint \
        /apps
Client2-nfs.Client2.blackrock.com:/clients/Client20101/local/bfm/apps \
        /web/htdocs
Client2-nfs.Client2.blackrock.com:/clients/Client20101/local/bfm/web/htd
ocs
Client3 /proj/space
Client3-nfs.Client3.blackrock.com:/clients/Client30103/proj/space \
        /proj/pkg_test
Client3-nfs.Client3.blackrock.com:/clients/Client30103/proj/pkg_test \
        /proj/GPA/historical-data
Client3-nfs.Client3.blackrock.com:/clients/Client30101/proj/GPA/historic
al-data \
        /d0/prod1/reports
Client3-nfs.Client3.blackrock.com:/clients/Client30102/d0/prod1/reports
\
        /u1/d0/prod1/reports
Client3-nfs.Client3.blackrock.com:/clients/Client30102/d0/prod1/reports
\
        /u1/prod/reports
Client3-nfs.Client3.blackrock.com:/clients/Client30102/d0/prod1/reports
\
        /usr/local/bfm/std
Client3-nfs.Client3.blackrock.com:/clients/Client30101/local/bfm/std \
        /tmpint
Client3-nfs.Client3.blackrock.com:/clients/Client30101/homes1/tmpint \
        /apps
Client3-nfs.Client3.blackrock.com:/clients/Client30101/local/bfm/apps \
        /web/htdocs
Client3-nfs.Client3.blackrock.com:/clients/Client30101/local/bfm/web/htd
ocs
Client4 /proj/space
Client4-nfs.Client4.blackrock.com:/clients/Client40101/rep/proj/space \
     /proj/pkg_test
Client4-nfs.Client4.blackrock.com:/clients/Client40101/rep/proj/pkg_test
\
     /proj/GPA/historical-data
Client4-nfs.Client4.blackrock.com:/clients/Client40101/rep/proj/GPA/hist
orical-data \
     /d0/prod1/reports
Client4-nfs.Client4.blackrock.com:/clients/Client40101/rep/d0/prod1/repo
rts \
     /u1/d0/prod1/reports
Client4-nfs.Client4.blackrock.com:/clients/Client40101/rep/d0/prod1/repo
rts \
     /u1/prod/reports
Client4-nfs.Client4.blackrock.com:/clients/Client40101/rep/d0/prod1/repo
rts \
     /usr/local/bfm/std
Client4-nfs.Client4.blackrock.com:/clients/Client40101/other/local/bfm/s
td \
     /tmpint
Client4-nfs.Client4.blackrock.com:/clients/Client40101/norep/homes/tmpin
t \
     /web/htdocs
Client4-nfs.Client4.blackrock.com:/clients/Client40101/other/local/bfm/w
eb/htdocs \
     /apps
Client4-nfs.Client4.blackrock.com:/clients/Client40101/other/local/bfm/a
pps 


Jason Breitman
jason.breitman@blackrock.com

-----Original Message-----
From: Ian Kent [mailto:raven@themaw.net] 
Sent: Wednesday, November 04, 2009 8:59 PM
To: Breitman, Jason
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] automount restart required

Breitman, Jason wrote:
> Issue:
> Users and applications will not be able to get into one of the
> directories in the direct map.
> The system reports no such file or directory.
> I can get to the mount point, but not any further.

Show me your maps.

Ian

THE INFORMATION CONTAINED IN THIS MESSAGE AND ANY ATTACHMENT MAY BE PRIVILEGED, CONFIDENTIAL, PROPRIETARY OR OTHERWISE PROTECTED FROM DISCLOSURE. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, distribution, copying or use of this message and any attachment is strictly prohibited. If you have received this message in error, please notify us immediately by replying to the message and permanently delete it from your computer and destroy any printout thereof.
