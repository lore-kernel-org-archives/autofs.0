From: abo <abo@brujulatelecom.com>
Subject: Re: Help with automounting from a LDAP server
Date: Tue, 11 Jan 2005 10:23:56 +0100
Message-ID: <20050111102356.0709bcef@localhost>
References: <87llb1oi7g.fsf@tango.dre.vanderbilt.edu>
	<Pine.LNX.4.58.0501101645100.5722@wombat.indigo.net.au>
	<87pt0czb00.fsf@tango.dre.vanderbilt.edu>
	<Pine.LNX.4.58.0501111631590.7845@wombat.indigo.net.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501111631590.7845@wombat.indigo.net.au>
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
Content-Type: text/plain; charset="us-ascii"
To: autofs@linux.kernel.org

sorry about this newbie question, but can you explain what exactly
direct mounts/maps is?

thx


On Tue, 11 Jan 2005 16:39:40 +0800 (WST)
Ian Kent <raven@themaw.net> wrote:

> On Tue, 11 Jan 2005, Krishnakumar B wrote:
> 
> > > Can't do that at present.  Direct mounts are not fully
implemented.
> > 
> > My manpage for autofs(5) claims the following:
> > 
> > UNSUPPORTED
> >        This version of the automounter supports direct maps for
FILE, NIS
> >        and LDAP maps only and handles SunOS-style replicated
filesystems
> >        only to the extent that mount(8) does.
> 
> Perhaps I need to change this to be more accurate.
> 
> > 
> > So is my manpage wrong, or does "direct maps" mean something other
than
> > "direct mounts"?  Or are you referring to the following limitation
(from
> > README.direct v1.3).
> > 
> > NOTE: Due to current design limitations, direct maps will take over
an
> > entire directory hierarchy.  What this means is, if your direct map
key is
> > /usr/share/bilbo, then /usr will become an automount mount point,
mounting
> > over the existing /usr.
> 
> I'm refering to the design limitation mentioned in this note.
> 
> This will continue to be the case in 4.1.4 (in fact 4.1.x).
> 
> I plan on creating a 4.2.0 development branch at some point fairly
soon. 
> This will be the top priority for that development.
> 
> Ian
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
