From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs design doc ?
Date: Mon, 25 Aug 2008 09:26:04 -0400
Message-ID: <x49wsi5i5ub.fsf@segfault.boston.devel.redhat.com>
References: <15446204.32971219413074178.JavaMail.www@wwinf2610>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <15446204.32971219413074178.JavaMail.www@wwinf2610> (Thierry
	BULTEL's message of "Fri, 22 Aug 2008 15:51:14 +0200 (CEST)")
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
To: Thierry BULTEL <thierry.bultel@wanadoo.fr>
Cc: autofs@linux.kernel.org

Thierry BULTEL <thierry.bultel@wanadoo.fr> writes:

>  Hi all,
>
> I am currently looking at autofs, and I would be interested to know if
> there exist such a documentation.  Namely, I am performing a kind of
> reverse-engineering on both the daemon and the kernel parts.

This will give you the general overview:

http://people.redhat.com/~jmoyer/autofs-linux_kongress-2005.pdf

A slightly newer one is available in the OLS 2006 proceedings, here:

http://www.linuxsymposium.org/2006/linuxsymposium_procv2.pdf

> What I would like to understand, above all, is the detailed interaction 
> scheme between automount and the kernel.

See above, ask questions after you've read that.

> I have understood that automount was receiving orders through a pipe,
> and replying with ioctls, but I still do not have the complete vision
> of the nature and timing of the messages. What are the respective
> responsibilities of both parts ?  Also, I am still asking myself why a
> user daemon is used, and why not everything is not done in the kernel.

The autofs file system traps lookup requests.  It then passes the
requests on to the userspace daemon to perform the actual lookup of the
key in the automount map and to then perform the mount.  This is done in
a userspace daemon because it is too complex to be handled in the
kernel.

Cheers,

Jeff
