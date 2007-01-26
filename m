From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: Race condition in autofs 4.1.4
Date: Fri, 26 Jan 2007 19:10:47 +0100
Message-ID: <1169835048.6781.16.camel@localhost>
References: <1169828641.32447.22.camel@sangay.TechFak.Uni-Bielefeld.DE>
	<1169831520.20795.1.camel@raven>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1169831520.20795.1.camel@raven>
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
To: autofs@linux.kernel.org

On Sa, 2007-01-27 at 02:12 +0900, Ian Kent wrote:

> > In syslog I get random messages like this:
> > Jan 26 16:39:29 demon automount[16757]: mount(generic): warning: /homes/musr657 is already mounted
> > Jan 26 16:39:42 demon automount[17062]: mount(generic): warning: /nfs4homes/musr946 is already mounted
> > for exactly the mountpoints that belong to root afterwards.
> 
> Your mtab locking is broken.
> Get a mount(8) that's not broken and then re-evaluate.

Thanks for the pointer. I found a discussion you were involved in in the
util-linux-ng mailinglist at the beginning of january, is that the
locking you talk about (see
http://www.mail-archive.com/util-linux-ng@vger.kernel.org/msg00005.html)?

I'll have a look at it on monday and see if I can patch our mount and if
it makes a difference!

> Ian

Kind regards,
Lukas
