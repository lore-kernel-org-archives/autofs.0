From: Matt Bernstein <+systems.extlists.autofs@dcs.qmul.ac.uk>
Subject: Re: autofs {3, 4,
 5} and bind mounts which point to other automount points
Date: Fri, 25 Aug 2006 07:45:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0608250736190.10216@frank.dcs.qmul.ac.uk>
References: <Pine.LNX.4.64.0608241525320.1854@frank.dcs.qmul.ac.uk>
	<Pine.LNX.4.64.0608250926270.6382@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0608250926270.6382@raven.themaw.net>
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

At 09:29 +0800 Ian Kent wrote:

>On Thu, 24 Aug 2006, Matt Bernstein wrote:
>> +/* 'what' may itself be on an automounted file system so we need to access it */
>> +/* to ensure it gets mounted before calling wait_for_lock() inorder to avoid a*/
>> +/* long delay */
>> +               (void)access(what,F_OK);
>
>That can lead to corruption of /etc/mtab.
>That's why the lock was introduced.
>
>In v5 the locking can be disabled as most people have updated mount(8) 
>these days.

Thanks--is the locking disabled, or do we need to patch the source? (I 
haven't looked at it yet.)

>Someone else has reported that bind mounts aren't working with v5.
>It would be good to resolve this but I need more info.
>A debug log would be best.

I set DEFAULT_LOGGING="debug" in /etc/sysconfig/autofs (this is 
autofs-5.0.1-0.rc1.16.x86_64 in FC6test), and I got this in /var/log/messages:

Aug 25 07:31:29 laurel automount[17274]: attempting to mount entry /homes/mb
Aug 25 07:31:29 laurel automount[17274]: mount_mount: mount(nfs): no hosts available
Aug 25 07:31:29 laurel automount[17274]: failed to mount /homes/mb
Aug 25 07:31:30 laurel automount[17274]: attempting to mount entry /homes/mb
Aug 25 07:31:30 laurel automount[17274]: failed to mount /homes/mb

..with the last two lines repeated 19 times. Is that helpful?
