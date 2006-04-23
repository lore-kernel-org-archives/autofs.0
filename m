From: Ian Kent <raven@themaw.net>
Subject: Re: Problem between autofs 3 and autofs4
Date: Sun, 23 Apr 2006 14:48:29 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0604231448020.2914@raven.themaw.net>
References: <002701c6608c$7d49bbf0$9700a8c0@mambo>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <002701c6608c$7d49bbf0$9700a8c0@mambo>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs mailing list <autofs@linux.kernel.org>

On Sat, 15 Apr 2006, ergatz wrote:

> I have a Solaris 2.6 NIS server and have recently added some Redhat Linux hosts to it.
> 
> I have:
> 
>      1 RH 7.3 machine
>      2 RH 3.0 update 0
>      1 RH 3.0 update 3
>      2 RH 4.0 machines
> 
> I have looked at this problem a lot, and the difference I see is that 7.3 and 3.0U0 use autofs 3.
> The 4.0 and 3.0U3 machines use autofs 4
> 
> My problem is:  When I moved some users' home directories to a different partition, the RH machines using autofs 4 had to be rebooted to pick up the changes.  The solaris hosts and the 7.3 and 3.0U0 (running autofs 3) picked up the changed locations magically like they are supposed to.  The machines using autofs 4 had to be rebooted in order to pick up the changes.  I tried everything I could think of to avoid reboot, because multiple users are on the the system at all times.
> 
> I stopped and restarted autofs and ypbind--SEVERAL times.  Nothing worked.

Did you try "service autofs reload".

or 

/etc/init.d/autofs reload

?

> 
> So, who know the differences between autofs 3 and 4, and what can I do to hosts running autofs 4 to get them to pick up the NIS changes without having to reboot?
> 
> dorothy
