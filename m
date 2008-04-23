From: Robert Kuropkat <robert.a.kuropkat@saic.com>
Subject: Re: autofs-5.0.1-0.rc2.55.el5.3 core dump
Date: Wed, 23 Apr 2008 15:26:28 -0400
Message-ID: <480F8D64.2070204@saic.com>
References: <47FF8D07.7080208@schrodinger.com>	
	<x49iqyo9x8i.fsf@segfault.boston.devel.redhat.com>	
	<47FF9443.4020305@schrodinger.com>	
	<1207970551.3138.9.camel@raven.themaw.net>
	<480E5E0A.2050702@saic.com>
	<1208946658.3207.26.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1208946658.3207.26.camel@raven.themaw.net>
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


Ian,

Ian Kent wrote:
> On Tue, 2008-04-22 at 17:52 -0400, Robert Kuropkat wrote:
>> Ian,
>>
>> Here is the output based on our latest core file from gdb as you asked.
>>  autofs-debuginfo was installed after the core file was created.  I
>> happen to have several other, older core files also.
>>
>> Hope this all means something to you.  If not, please tell me what I can
>> do to provide something more useful.
>>
>> Robert Kuropkat
>>
>> P.S.  I cut in on somebody else's thread here.  The version I am running is:
>>
>> autofs.i386                              1:5.0.1-0.rc3.33
>> autofs-debuginfo.i386                    1:5.0.1-0.rc3.33
>>
>> On Fedora Core 6.
>>
>>
>>
>>
>> gdb -c /core.26360 /usr/sbin/automount
>> GNU gdb Red Hat Linux (6.5-15.fc6rh)
>> Copyright (C) 2006 Free Software Foundation, Inc.
>> GDB is free software, covered by the GNU General Public License, and you are
>> welcome to change it and/or distribute copies of it under certain
>> conditions.
>> Type "show copying" to see the conditions.
>> There is absolutely no warranty for GDB.  Type "show warranty" for details.
>> This GDB was configured as "i386-redhat-linux-gnu"...Using host
>> libthread_db library "/lib/libthread_db.so.1".
>>
> 
> snip ...
> 

<snip>

> 
> I've seen something like this before but it shouldn't be showing up in
> this revision.
> 
> Can you provide a debug log which corresponds to this happening.
> 

Unfortunately no.  Apparently I feel the need to act the dimwitted fool
on this whole issue.  I just now added the -d and -v options to
automount, although /etc/sysconfig/autofs does have:

DEFAULT_LOGGING="debug"

The only thing I have in the /var/log/messages log at the failure time is:

Apr 22 00:17:58 orbit automount[26360]: attempting to mount entry
/home/dalewis
Apr 22 00:17:58 orbit automount[26360]: mounted /home/dalewis
Apr 22 00:18:16 orbit automount[26360]: attempting to mount entry
/home/asavage
Apr 22 00:18:16 orbit automount[26360]: failed to mount /home/asavage
Apr 22 00:18:16 orbit automount[26360]: attempting to mount entry
/home/asavage
Apr 22 00:18:16 orbit automount[26360]: failed to mount /home/asavage
Apr 22 00:18:16 orbit automount[26360]: attempting to mount entry
/home/asavage
Apr 22 00:18:16 orbit automount[26360]: failed to mount /home/asavage
Apr 22 00:18:16 orbit automount[26360]: attempting to mount entry
/home/asavage
Apr 22 00:18:16 orbit automount[26360]: attempting to mount entry
/home/ataylor
Apr 22 00:18:16 orbit automount[26360]: failed to mount /home/asavage
Apr 22 00:18:16 orbit automount[26360]: failed to mount /home/ataylor
Apr 22 00:18:16 orbit automount[26360]: attempting to mount entry
/home/asavage
Apr 22 00:18:16 orbit automount[26360]: attempting to mount entry
/home/ataylor

and then of course, all entries end.  This does not seem very verbose.
Is there another log file somewhere I am missing?

<snip>

Robert Kuropkat
