From: Ian Kent <raven@themaw.net>
Subject: RE: [ANNOUNCE] autofs 5.0.0 beta1
Date: Tue, 9 May 2006 18:51:36 +0800 (WST)
Message-ID: <Pine.LNX.4.64.0605091850320.12829@raven.themaw.net>
References: <C3CDA0E3AC8B4E438E94F37D0A20FE71026B10D8@HOUEXC210.mgroupnet.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <C3CDA0E3AC8B4E438E94F37D0A20FE71026B10D8@HOUEXC210.mgroupnet.com>
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

On Mon, 8 May 2006, Rigler, Stephen C. wrote:

> 
> > -----Original Message-----
> > From: Ian Kent [mailto:raven@themaw.net] 
> > Sent: Thursday, May 04, 2006 8:38 PM
> > To: Rigler, Stephen C.
> > Cc: Jeff Moyer; autofs mailing list
> > Subject: RE: [autofs] [ANNOUNCE] autofs 5.0.0 beta1
> > 
> > > Another nice thing to see would be the "-null" option in 
> > auto.master.
> > > We have machines running clustered filesystems that are also
> > > exported via NFS from one or two meta-data servers.  The machines
> > > that see the filesystems locally should not automount the fileystems
> > > and the "-null" would allow us to exclude them.
> > 
> > It should understand "-null" but the question is whether it works 
> > correctly and how it should work. Give a try and let me know 
> > how it goes.
> > 
> > What would you have in your map in this case?
> > 
> > Ian
> 
> "-null" seems to be working fine.
> 
> In my case, my /etc/auto.master has "+yp:auto.master" and then
> "/somepath -null" to exclude an indirect mount or "/some/path -null"
> to exclude a direct mount.  This is the inverse of the Solaris and
> Irix boxes we handle where the "+auto.master" is the last line in
> the local file.  I have not tried it with an actual filesystem 
> mounted at the mountpoint I'm excluding.
> 
> The only inconsistency I've noticed if I remove the "-null" from
> an indirect mount I need to restart automount (reload doesn't seem
> to pick it back up).  "Reload" does work when I remove the "-null"
> from a direct mount.

Cool. I'll check that out and see what's going on.

Thanks
Ian
