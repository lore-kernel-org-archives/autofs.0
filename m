From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: ENOENT on first reference to an automounted file
Date: Mon, 08 Oct 2007 11:15:28 -0400
Message-ID: <x49k5pxprhr.fsf@segfault.boston.devel.redhat.com>
References: <4706A926.8090503@everyzing.com>
	<1191646125.3060.7.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1191646125.3060.7.camel@raven.themaw.net> (Ian Kent's message of
	"Sat\, 06 Oct 2007 12\:48\:45 +0800")
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

Ian Kent <raven@themaw.net> writes:

> On Fri, 2007-10-05 at 17:14 -0400, Dan Halbert wrote:
>> I have what looks like an automount race condition, and am very puzzled. 
>> Any suggestions would be appreciated.
>> 
>> The first time I reference an automounted file, it is not there 
>> (ENOENT). On the second and later try, the file is there. For instance:
>> 
>>      $ cat /net/fileserver/fs/somefile
>>      cat: /net/fileserver/fs/somefile: No such file or directory
>>      $ cat /net/fileserver/fs/somefile
>>      Contents of somefile.
>> 
>> I watched the log on fileserver, and the automount request is logged 
>> seemingly immediately after the first "cat" prints its error.
>> 
>> This causes havoc with our applications, which expect files to be there 
>> the first time they look for them.
>> 
>> I can repeat the problem after umounting the fileystem.
>> 
>> I see this problem on a CentOS 4.x system running their standard 
>> autofs-4.1.3-199.3. I do NOT see it on CentOS 5.x, using 
>> autofs-5.0.1-0.rc2.43.0.2. Instead I see a slight pause before "cat" 
>> prints the contents of the file, presumably as the automount completes. 
>> Both the CentOS4 and CentOS5 systems are completely up-to-date.
>> 
>> I also only see this problem with our Linux NFS servers (FC5 and FC6), 
>> but not with a non-Fedora NAS server we have.
>> 
>> So I am not sure this is an automount problem, per se. Perhaps it's some 
>> kind of NFS version problem?
>> 
>> The automount options include --ghost. At first I thought it might be 
>> due to --ghost, because the very first time I reference the file, say 
>> after a reboot or restarting autofs, I don't get an ENOENT. The first 
>> time, the mountpoint dir does not yet exist. But removing --ghost from 
>> the automount options does not seem to fix it.
>
> We've seen this from time to time for various reasons but to be honest I
> have trouble remembering so we'll need to check through a debug log.
>
> Jeff may recall this?

I think that the last time we looked at this, the problem was that
there was a replicated server entry, and the first picked entry failed
to mount.  Then, the second succeeded, but we returned the wrong
dentry from lookup.  This resulted in a reported failure, even though
the mount was successful.

I'm not convinced this is the same problem.  I'll try to reproduce it.

Cheers,

Jeff
