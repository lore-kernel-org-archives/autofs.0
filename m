From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: running out of mount points
Date: Tue, 20 Jan 2004 11:15:20 -0800 (PST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.53.0401201104560.5062@xena.cft.ca.us>
References: <Pine.LNX.4.33.0401130932460.10047-100000@wombat.indigo.net.au>
	<Pine.LNX.4.58.0401142351470.1783@raven.themaw.net>
	<40059944.4060901@rhythm.com> <400BFC65.3000700@rhythm.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <400BFC65.3000700@rhythm.com>
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
To: Greg Bradner <gregb@rhythm.com>
Cc: autofs@linux.kernel.org

On Mon, 19 Jan 2004, Greg Bradner wrote:
> > I have run into a problem of running out of mount points.  I have over
> > 600 users and their home dirs are listed in auto.home and they are all
> > stored on the same nfs server.  If I list the dirs, automount will
> > create a seperate mount point for each user, and at ~256 mount points,
> > no more home dirs can be mounted.

Our "workaround" is to not use the auto.home map.  In /etc/passwd, write
the user's homedir as /net/tupelo/h1/maint/jimc (using mine as an example),
where the actual mount point is /net/tupelo/h1.  We provide the auto.home
map for convenience so users can manually type their homedir as
/home/$USER, but at any one time only two or three /home mounts will be
seen throughout our collection of clients and servers.

Also to minimize the number of mounts per machine it's helpful if the users
execute on either the fileserver or their personal workstations.  In some
cases this is impractical (e.g. the fileserver is a network appliance) and
you need a shared execution machine.  But 600 users would bring anything to
its knees.  We provide several shared execution machines and keep each
category of (lesser-funded) user on his/her assigned machine, thus cutting
down the number of mounts even if auto.home is used.

Hope this helps!

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
