From: Ian Kent <raven@themaw.net>
Subject: Re: smbfs credentias
Date: Tue, 5 Apr 2005 11:00:50 +0800 (WST)
Message-ID: <Pine.LNX.4.58.0504051037040.25453@wombat.indigo.net.au>
References: <20065-08925@sneakemail.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <20065-08925@sneakemail.com>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Craig Schreiner <nzzjw8q02@sneakemail.com>
Cc: autofs@linux.kernel.org

On Tue, 4 Apr 2005, Craig Schreiner wrote:

> > From: Jeff Moyer jmoyer at redhat.com
> > Date: Wed Jan 5 10:34:18 PST 2005
> >
> > ==> Regarding [autofs] smbfs credentias; abo <abo at brujulatelecom.com> adds:
> >
> > abo> hi!  im trying to mount smbfs resources from an ldap
> >
> > abo> if i put in nisMapEntry this
> >
> > abo> -fstype=smbfs,credentials=/home/abo/smb.creds
> >
> > abo> everything is working right. then i want to do it per user but
> > abo> variable substitution doesn't work, i tried:
> >
> > abo> -fstype=smbfs,credentials=/home/$USER/smb.creds
> >
> > abo> -fstype=smbfs,credentials=/home/${USER}/smb.creds
> >
> > abo> -fstype=smbfs,credentials=~/smb.creds
> >
> > abo> but no succes.
> >
> > abo> how can i get per user credentiasl? im on the wrong direction?
> >
> > The automounter runs as user root.  It has no way of knowing which user
> > requested a given mount.
> >
> > -Jeff
> 
> Wow, I'm really surprised that there isn't some mechanism to support multiple users?  While this credential mechanism might be okay for a test lab or a single user LAN, but what do people do in a business/enterprise environment?

Sticks and stones!

> 
> Is there anyway to force the automounter to prompt for username and password?

Since the daemon runs without a controling tty where would it prompt?

> 
> Maybe I should ask, why is there no way of the automounter knowing which user is requesting a given mount?  I mean no disrespect, but does anyone else think this is a design limiting security risk implementation when automounting smbfs types?

The information that comes from the kernel does not include any process 
info.

One very difficult task is backward compatibilty.
If we change the size of the communication structure we send from the 
kernel to userspace every single previous version of autofs will not work 
any more. So we can't add the information.

We can change what autofs uses as a key for map entry lookups.
To do this the kernel module needs to have a way of knowing what version 
the daemon can work with to ensure it sends the correct structure.

I've been thinking about how I can do this and may have a relatively 
simple solution.

Much of the work to support additional info in the structure has been 
done and will likely start to show up in 4.2.

These are just the first steps to fix this. It has been a problem for a 
long time.

Ian
