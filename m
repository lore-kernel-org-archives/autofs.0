From: Ian Kent <raven@themaw.net>
Subject: Re: autofs or nfs umount hang (again)
Date: Thu, 16 Sep 2004 08:57:40 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0409160853180.19750@wombat.indigo.net.au>
References: <E1C7d33-000ItD-00.ia6432-inbox-ru@f29.mail.ru>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E1C7d33-000ItD-00.ia6432-inbox-ru@f29.mail.ru>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Lojkin <ia6432@inbox.ru>
Cc: autofs@linux.kernel.org

On Wed, 15 Sep 2004, Peter Lojkin wrote:

> Hello,
> 
> we've just upgraded our servers to 2.4.27 + autofs4-20040508 and autofs-4.1.3
> (with fixes) and started getting hangs on umounting of nfs shares every 2-3 days. it looks exactly like the problem we had a few months ago that was caused by wait_queue race (or something like this). it might not be autofs related since there were changes in nfs between .24 and .27 and at least sillydelete fix might cause a wait for something.
> here is the trace of automount and umount processes:
>

I must admit I've not taken much notice of the NFS problem reports against 
2.4.27.

I find it a little hard to blame the waitq race as the fix in the pernel 
patch you have applied seemed to reliably fix such problems. The other 
thing is that you would expect to see either 2 mount requests or an expire 
and a mount request in the trace. Looks like there's just one expire 
below and it looks like it's doing what it should. So I'm stumped.

It's probably a good idea to post to the NFS list as well.

> Proc;  automount
> 
> >>EIP; c9be0a60 <_end+9813d04/38a0e2a4>   <=====
> 
> Trace; f8e10c39 <[autofs4]autofs4_wait+2b9/35c>
> Trace; f8e115aa <[autofs4]autofs4_expire_multi+56/6c>
> Trace; f8e105c7 <[autofs4]autofs4_root_ioctl+2fb/310>
> Trace; c01497e9 <sys_ioctl+2ad/2ea>
> Trace; c0108913 <system_call+33/38>
> Proc;  automount
> 
> >>EIP; e1772000 <_end+213a52a4/38a0e2a4>   <=====
> 
> Trace; c01440dd <pipe_wait+7d/a4>
> Trace; c01441b4 <pipe_read+b0/1fc>
> Trace; c013ae47 <sys_read+8f/100>
> Trace; c0108913 <system_call+33/38>
> Proc;  umount
> 
> >>EIP; dd2bfef8 <_end+1cef319c/38a0e2a4>   <=====
> 
> Trace; c011694a <schedule_timeout+7a/9c>
> Trace; c0116870 <process_timeout+0/60>
> Trace; c011732a <interruptible_sleep_on_timeout+4e/80>
> Trace; c016c52e <nfs_reqlist_exit+72/ac>
> Trace; c016c8e2 <nfs_put_super+12/58>
> Trace; c0140ad2 <kill_super+d6/138>
> Trace; c0152232 <__mntput+1e/24>
> Trace; c0144f68 <path_release+28/30>
> Trace; c01529af <sys_umount+6f/7c>
> Trace; c01529c8 <sys_oldumount+c/10>
> Trace; c0108913 <system_call+33/38>
> 
> if the full trace is needed i'll try to collect it next time...
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
> 
