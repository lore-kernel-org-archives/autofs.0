From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta1
Date: Wed, 3 May 2006 22:48:31 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0605032232220.31300@raven.themaw.net>
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
> gcc -g -Os -march=athlon-tbird -pipe -fomit-frame-pointer -D_REENTRANT -D_REENTRANT -rdynamic -fPIE -D_GNU_SOURCE -I../include -DAUTOFS_LIB_DIR=\"/usr/lib/autofs\"  -DAUTOFS_MAP_DIR=\"/etc/autofs\" -DAUTOFS_CONF_DIR=\"/etc/sysconfig\" -DVERSION_STRING=\"5.0.0_beta1\" -c direct.c
> direct.c: In function `handle_packet_expire_direct':
> direct.c:969: error: label at end of compound statement
> direct.c: In function `handle_packet_missing_direct':
> direct.c:1260: error: label at end of compound statement
> make[1]: *** [direct.o] Error 1
> make[1]: Leaving directory `/usr/tmp/portage/autofs-5.0.0_beta1/work/autofs-5.0.0_beta1/daemon'

I've seen that error as well.
It's quite odd because it seems to be dependent of the version of glibc 
pthread headers specifically the pthread_cleanup_push and 
pthread_cleanup_pop macros.

Once I got that error when some of the files had a timestamp in the future 
and "make install" tried to re-compile some of the sources.

I'll see if I can re-arrange the pthread_cleanup_push and 
pthread_cleanup_pop calls that cause this to happen.

> 
> Note that I removed all the patches that were used for autofs4. I'm 
> using gcc 3.4.6.
> 
> Another question I have: I once asked if it's possible to run the actual 
> mount command as the user trying to read the directory, instead of root. 
> I was told that this is impossible in version 4. Will it be possible 
> now?

Do you have a mount that will work for a user?

You can use the $USER substitution variable now to mount with a 
"user=${USER}" option or $UID and $GID with "uid=${UID}" and "gid=${GID}" 
in your map. Will that help?

Ian
