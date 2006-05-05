From: Ian Kent <raven@themaw.net>
Subject: RE: [ANNOUNCE] autofs 5.0.0 beta1
Date: Fri, 5 May 2006 09:37:43 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0605050935140.2898@raven.themaw.net>
References: <C3CDA0E3AC8B4E438E94F37D0A20FE71026B10D5@HOUEXC210.mgroupnet.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <C3CDA0E3AC8B4E438E94F37D0A20FE71026B10D5@HOUEXC210.mgroupnet.com>
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
To: "Rigler, Stephen C." <srigler@marathonoil.com>
Cc: autofs mailing list <autofs@linux.kernel.org>

On Thu, 4 May 2006, Rigler, Stephen C. wrote:

> 
> > -----Original Message-----
> > From: Jeff Moyer [mailto:jmoyer@redhat.com] 
> > Sent: Thursday, May 04, 2006 8:56 AM
> > To: Ian Kent
> > Cc: Rigler, Stephen C.; autofs mailing list
> > Subject: Re: [autofs] [ANNOUNCE] autofs 5.0.0 beta1
> > 
> > raven> and /etc/auto.master exists with a +auto.master it 
> > will probably get
> > raven> it wrong in a strange way. Maybe that's what is happening?
> > 
> > Yeah, I think this is the one exception to the nsswitch rule. 
> >  I wonder if
> > it's the same if you have /etc/auto.foo that does a +auto.foo?  May be
> > worth testing that out on another UNIX box to see what happens.
> > 
> > -Jeff
> > 
> 
> Pretty much standard configuration here on Solaris and Irix is
> to have "automount: files nis" in nsswitch.conf and "+auto.master"
> in the local auto_master file.  I'm not aware if this is what
> the standard automount behavior should be (it's documented in the
> Irix man page for autofs), but we've gotten away with it for years 
> if it's not.
> 
> Another nice thing to see would be the "-null" option in auto.master.
> We have machines running clustered filesystems that are also
> exported via NFS from one or two meta-data servers.  The machines
> that see the filesystems locally should not automount the fileystems
> and the "-null" would allow us to exclude them.

It should understand "-null" but the question is whether it works 
correctly and how it should work. Give a try and let me know how it goes.

What would you have in your map in this case?

Ian
