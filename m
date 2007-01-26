From: Ian Kent <raven@themaw.net>
Subject: Re: Race condition in autofs 4.1.4
Date: Sat, 27 Jan 2007 02:12:00 +0900
Message-ID: <1169831520.20795.1.camel@raven>
References: <1169828641.32447.22.camel@sangay.TechFak.Uni-Bielefeld.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1169828641.32447.22.camel@sangay.TechFak.Uni-Bielefeld.DE>
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
To: Lukas Kolbe <lukas@einfachkaffee.de>
Cc: autofs@linux.kernel.org

On Fri, 2007-01-26 at 17:24 +0100, Lukas Kolbe wrote:
> You can clearly see that the directories that belong to root shouldn't
> be there, at least they shouldn't be kept there.
> autofs can't be restarted now - and it won't umount the remaining
> correctly mounted directories. Only manual umounts of /homes/*
> and /nfs4homes/* and a restart of the automounter afterwards fix this
> problem for a short amount of time.
> 
> In syslog I get random messages like this:
> Jan 26 16:39:29 demon automount[16757]: mount(generic): warning: /homes/musr657 is already mounted
> Jan 26 16:39:42 demon automount[17062]: mount(generic): warning: /nfs4homes/musr946 is already mounted
> for exactly the mountpoints that belong to root afterwards.

Your mtab locking is broken.
Get a mount(8) that's not broken and then re-evaluate.

Ian
