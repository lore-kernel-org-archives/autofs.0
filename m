From: Ian Kent <raven@themaw.net>
Subject: Re: autofs {3, 4,
	5} and bind mounts which point to other	automount points
Date: Fri, 25 Aug 2006 23:55:00 +0800
Message-ID: <1156521300.31377.3.camel@raven.themaw.net>
References: <Pine.LNX.4.64.0608241525320.1854@frank.dcs.qmul.ac.uk>
	<1156517163.30971.45.camel@raven.themaw.net>
	<Pine.LNX.4.64.0608251546430.14075@frank.dcs.qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0608251546430.14075@frank.dcs.qmul.ac.uk>
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
To: Matt Bernstein <+systems.extlists.autofs@dcs.qmul.ac.uk>
Cc: autofs@linux.kernel.org

On Fri, 2006-08-25 at 15:47 +0100, Matt Bernstein wrote:
> At 22:46 +0800 Ian Kent wrote:
> 
> > On Thu, 2006-08-24 at 15:44 +0100, Matt Bernstein wrote:
> >> Hi,
> >>
> >> We like to preconfigure an number of our (1000ish) users' applications.
> >> Typically, this might necessitate hard-coding their home directories in
> >> dot-files, so we specify their home directory in the passwd map as
> >> /homes/$LOGNAME, and make this an (LDAP) automount map which might point
> >> to ":/server/{servername}/{volumename}/$LOGNAME" (via a bind mount), where
> >> /server/{servername}/{volumename} would be the "real" NFS mount.
> >
> > So you have another automount map for the server entries, right?
> 
> Yup. Actually it's even more indirect. I'm about to hit send on my other 
> mail which describes it.

I think I know why this isn't working.
It's due to the conversion to a threaded model.
And I fairly sure it can't work within v5 if we don't make changes.
It's actually quite difficult.

Basically, the daemon doesn't ever trigger a mount itself and since
there is only one daemon now you can't cause a mount to happen in
another mount point.

I'll have to think about how we can do this.

Ian
