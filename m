From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: automount never umount
Date: Tue, 22 Nov 2005 19:24:31 -0500
Message-ID: <17283.46783.748916.772469@segfault.boston.redhat.com>
References: <4381E865.4070908@bppiac.hu>
	<Pine.LNX.4.58.0511220822410.16196@wombat.indigo.net.au>
	<4382E835.3020904@bppiac.hu>
	<Pine.LNX.4.63.0511222054060.2600@donald.themaw.net>
	<438344F7.8020503@bppiac.hu>
	<17283.19512.49399.338448@segfault.boston.redhat.com>
	<43838CA9.40105@bppiac.hu>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <43838CA9.40105@bppiac.hu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Farkas Levente <lfarkas@bppiac.hu>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

==> Regarding Re: [autofs] automount never umount; Farkas Levente <lfarkas@bppiac.hu> adds:

lfarkas> Jeff Moyer wrote:
>> ==> Regarding Re: [autofs] automount never umount; Farkas Levente
>> <lfarkas@bppiac.hu> adds:
>> 
lfarkas> Ian Kent wrote:
>>
>>>> That wasn't what I had in mind.
>>>> 
>>>> I was thinking more along the lines of the definition of what
>>>> constitues "use". For example any access, such as a directory listing,
>>>> will update the "last used" value whereas if I change the definition
>>>> of "last used" to "currently in use" then to be busy there would have
>>>> to be an open file or a process working directory set. This may solve
>>>> the GUI scanning problem we see but wouldn't solve immediate
>>>> remounting that occurs due to the scanning as well.
>>
lfarkas> that would be useful and may be solve our problem. without it the
lfarkas> current implementation is not usable to umount. think about just
lfarkas> the daily process like slocate database update, tripwire and may
lfarkas> be others.
>> Things that run infrequently are not at fault, here.  I'd really like to
>> know precisely what is going on, in your case.
>> 
>> Ian, I think it would be easy enough to instrument the autofs4 module.
>> Simple things, like figuring out which process is triggerring the
>> lookup.

lfarkas> ps axu can help you?

>> We can either log it, or just keep a ring buffer.

lfarkas> i run gnome and nothing special, even if only one terminal and
lfarkas> netscape is running the autofs never umount.


>> I don't think I'll have time to put together any code this week, but may
>> next week.

lfarkas> i'll happy to test it.

Try the kernel rpm located here:

	http://people.redhat.com/jmoyer/farkas/kernel-2.6.14-1.1641_FC4.jmoyertest.1.i686.rpm

It has the potential to generate a good bit of output.  I've attached the
patch that is incorporated there.  You'll want to post the output of dmesg
to this list when you get it.

You'll notice that the second bit of this patch is not related to this
problem.  Ian, you should take that into account if you keep around the
expiry of negative dentries.

Thanks,

Jeff

--- linux-2.6.14/fs/autofs4/root.c.orig	2005-11-22 16:50:30.000000000 -0500
+++ linux-2.6.14/fs/autofs4/root.c	2005-11-22 16:52:51.000000000 -0500
@@ -388,6 +388,9 @@ static int autofs4_revalidate(struct den
 	int flags = nd ? nd->flags : 0;
 	int status = 1;
 
+	printk("%s: revalidate called on behalf of application \"%s\"\n",
+	       __FUNCTION__, current->comm);
+
 	/* Pending dentry */
 	if (autofs4_ispending(dentry)) {
 		if (!oz_mode)
@@ -397,7 +400,7 @@ static int autofs4_revalidate(struct den
 
 	/* Negative dentry.. invalidate if "old" */
 	if (dentry->d_inode == NULL)
-		return (dentry->d_time - jiffies <= 0);
+		return time_after_eq(jiffies, dentry->d_time);
 
 	/* Check for a non-mountpoint directory with no contents */
 	spin_lock(&dcache_lock);
