From: Joe Pruett <joey@clean.q7.com>
Subject: Re: something changed from 4 to 5
Date: Tue, 12 Aug 2008 21:11:00 -0700 (PDT)
Message-ID: <alpine.LRH.1.10.0808122106340.23639@q7.q7.com>
References: <alpine.LRH.1.10.0808120940350.4317@q7.q7.com>
	<1218596289.3148.8.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1218596289.3148.8.camel@raven.themaw.net>
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

> Install the autofs-debuginfo package and when you see this use gdb to
> get a backtrace of the running threads.
>
> gdb -p <automount pid> /usr/sbin/automount
> gdb> thr a a bt

will do.

>> 1. is there a better way to do this?  in the old sun days, it was like:
>>
>> user1	server:/disk/1:user1
>> user2	server:/disk/1:user2
>
> When was this syntax used, I don't remember it?
> And exactly how is it supposed to work?

that was the original automount in sunos.  i'm pretty sure that sun 
deprecated it as well and just treated the extra : as a slash.  but it 
worked almost exactly like i want.  a single nfs mount is made, no matter 
how many subdirectories were referenced.  i can't recall exactly how the 
mounts were laid out to make it all happen.  but it was extremely useful 
in the days when a system could only handle 32 or some really small number 
of nfs mounted file systems.  that isn't such an issue today, but i still 
worry about it for a mail or web server that may touch 1000s of home 
directories at once so that is why i use the recursive automounts.  it 
also makes df output much more readable.  like i say, it has been working 
pretty well until recently (i think when i started using autofs v5).
