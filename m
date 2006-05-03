From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta1
Date: Wed, 3 May 2006 23:15:09 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0605032311080.31306@raven.themaw.net>
References: <Pine.LNX.4.64.0605022329020.10568@raven.themaw.net>
	<20060503131637.GA30523@kaminsky>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060503131637.GA30523@kaminsky>
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
To: Moshe Kaminsky <kaminsky@math.huji.ac.il>
Cc: autofs@linux.kernel.org

On Wed, 3 May 2006, Moshe Kaminsky wrote:

> * Ian Kent <raven@themaw.net> [02/05/06 20:30]:
> > 
> > Hi all,
> > 
> > I've finally got to a point where I can release a beta of
> > autofs 5.0.0.
> > 
> > I would really appreciate some real world testing of this
> > so I hope some of you are able to help.
> > 
> > Feedback is welcome.
> > 
> > autofs
> > ======
> > 
> > For the moment the package can be found at:
> > 
> > ftp://ftp.kernel.org/pub/linux/daemons/autofs/v4
> > 
> > It is autofs-5.0.0_beta1.tar.[gz|bz2]
> > 
> > No source rpm is there as it can be produced by using:
> > 
> > rpmbuild -ts autofs-5.0.0_beta1.tar.gz
> > 
> > and the binary rpm by using:
> > 
> > rpmbuild -tb autofs-5.0.0_beta1.tar.gz
> > 
> > See the INSTALL file for information about configure options and
> > kernel requirements.
> > 
> > I have no way to test the Gentoo portage build and the build
> > files will need to be modified for beta1. It would be great
> > if someone could get this working and forward a patch before
> > the final release.
> > 
> 
> I modified the ebuild for autofs4 and tried to compile. I get:
> 
> gcc -g -Os -march=athlon-tbird -pipe -fomit-frame-pointer
 -D_REENTRANT -D_REENTRANT -rdynamic -fPIE -D_GNU_SOURCE
 -I../include -DAUTOFS_LIB_DIR=\"/usr/lib/autofs\" 
 -DAUTOFS_MAP_DIR=\"/etc/autofs\" -DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -DVERSION_STRING=\"5.0.0_beta1\" -c direct.c

There's something else wrong with the build.
Shouldn't AUTOFS_CONF_DIR be /etc/conf.d instead of /etc/sysconfig?
configure should look for the directory?
What did I get wrong there?
Does /etc/sysconfig exist on you system?
Maybe it should be set explicitly at configure time.

Ian
