From: Ian Kent <raven@themaw.net>
Subject: Re: making the mountpoints visible all the time
Date: Wed, 19 Nov 2003 08:41:46 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.33.0311190835020.17313-100000@wombat.indigo.net.au>
References: <1069201444.28347.12.camel@ugly>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1069201444.28347.12.camel@ugly>
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
To: "Taylor, ForrestX" <forrestx.taylor@intel.com>
Cc: autofs@linux.kernel.org

On Tue, 18 Nov 2003, Taylor, ForrestX wrote:

> On Thu, 2003-11-13 at 19:04, Ian Kent wrote:
> > On Thu, 13 Nov 2003, Taylor, ForrestX wrote:
> >
> > > Alexander Macdonald wrote:
> > > > Hi
> > > >
> > > > I've currently got automount setup so that i can cd into a directory
> > > > like /mnt/someplace and someplace will be automatically created and
> > > > mounted... it would be quite usefull if that directory was allways
> > > > visible so that i could browse to it in gui applications... how do i do
> > > > that?
> > >
> > > If you want it visible all the time, use /etc/fstab, not autofs.  Work
> > > is being done on leaving the directory structure before actually
> > > mounting it, but it is not finished yet.
> > >
> >
> > Umm ...
> >
> > Beg to disagree.
> >
> > The autofs4-2.4 module build kit or the patches contained in it or the
> > patches contained in autofs-4.1.0-beta3 can give you this for some of the
> > maps. NIS, LDAP and file maps work at the moment.
> >
> > I's in the expected place on kernel.org.
>
> Now it is my turn to apologize.  I saw the autofs module on the ftp
> site, but I didn't have time to investigate.  Has this module been
> included in the upstream kernel yet?
>

No.

I have mailed Marcello Tosatti asking what I need to do for my changes to
be included but he hasn't sent any reply.

On the upside, when I commplained about not getting my changes into the
kernel the other day and copied it to the LKML, Peter Anvin suggested I
submit my patches for inclusion in 2.6. He sounded quite positive and I'm
currently porting the changes. You may have seen the recent discussion.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
