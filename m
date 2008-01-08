From: Lukas Kolbe <lukas@einfachkaffee.de>
Subject: Re: Linux+Solaris - NIS auto.master versus autofs5
Date: Tue, 08 Jan 2008 11:19:43 +0100
Message-ID: <1199787583.26268.12.camel@srss>
References: <753ec7300712211400g3eb45b21n1f236fe7056f87a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <753ec7300712211400g3eb45b21n1f236fe7056f87a1@mail.gmail.com>
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
To: David Mack <davidwmack@gmail.com>
Cc: autofs@linux.kernel.org

Hi!

A late reply, but a similar thing has bitten me in the past:

> I work in an environment in which Solaris and Linux machines NIS mount
> the same automount maps, including auto.master. Typically,
> /etc/auto.master just contains "+auto.master" on all of them.
> 
> With the advent of autofs5, this has started breaking. To get the
> Linux machines running autofs5 to work, we've had to replace
> /etc/auto.master with a version that looks something like this:
> 
> /volume yp:auto.vols
> /system yp:auto.home
> /local yp:auto.local
> /homes yp:auto.homes
> /home yp:auto.home
> /xfn -xfn
> /net -hosts             -nosuid

With autofs5, it does honor settings in /etc/nsswitch.conf.
A line like

automount:      nis files

in there does tell autofs5 to lookup the maps first via nis, then via
files, so there shouldn't be a need to explicitly specify yp: maps in
the /etc/auto.master anymore so principially the old auto_master should
work?

-- 
Lukas
