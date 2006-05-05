From: Ian Kent <raven@themaw.net>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta1
Date: Fri, 5 May 2006 09:32:45 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0605050924040.2898@raven.themaw.net>
References: <Pine.LNX.4.64.0605022329020.10568@raven.themaw.net>
	<20060503131637.GA30523@kaminsky>
	<Pine.LNX.4.64.0605032232220.31300@raven.themaw.net>
	<20060503165542.GB1982@kaminsky>
	<Pine.LNX.4.64.0605040124240.31510@raven.themaw.net>
	<20060504173352.GB12272@kaminsky>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20060504173352.GB12272@kaminsky>
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

On Thu, 4 May 2006, Moshe Kaminsky wrote:

> * Ian Kent <raven@themaw.net> [03/05/06 20:45]:
> > On Wed, 3 May 2006, Moshe Kaminsky wrote:
> > 
> > > * Ian Kent <raven@themaw.net> [03/05/06 18:00]:
> > > > On Wed, 3 May 2006, Moshe Kaminsky wrote:
> > > > > Another question I have: I once asked if it's possible to run the 
> > > > > actual mount command as the user trying to read the directory, 
> > > > > instead of root. I was told that this is impossible in version 4. 
> > > > > Will it be possible now?
> > > > 
> > > > Do you have a mount that will work for a user?
> > > > 
> > > > You can use the $USER substitution variable now to mount with a 
> > > > "user=${USER}" option or $UID and $GID with "uid=${UID}" and "gid=${GID}" 
> > > > in your map. Will that help?
> > > > 
> > > 
> > > I don't think so. What I have in mind is that a user will be able to 
> > > automount his home directory on a remote machine using sshfs. For this, 
> > > that user has to actually run the mount command, so that his ~/.ssh is 
> > > used.
> > 
> > The problem here is that mount(8) will only allow the "user" option if 
> > an entry is present in the fstab which defeats the purpose of using 
> > autofs.
> 
> Funny. It appears that you're right. I'm sure it used to work, though 
> (maybe something changed in the kernel?)

All this checking is done in mount(8). I've investigated this before when 
checking this type of question. Maybe yours.

Anyway, after thinking about this and checking out sshfs this is not a 
problem. Getting the sshfs mount done as the user (now we know the 
username) would be possible by writting a simple mount_sshfs.c module but 
it looks like the resulting mount can't be un-mounted by umount. Is that 
right?

Ian
