From: "Rigler, Stephen C." <srigler@marathonoil.com>
Subject: RE: [ANNOUNCE] autofs 5.0.0 beta1
Date: Thu, 4 May 2006 12:29:54 -0500
Message-ID: <C3CDA0E3AC8B4E438E94F37D0A20FE71026B10D5@HOUEXC210.mgroupnet.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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
Content-Type: text/plain; charset="us-ascii"
To: Jeff Moyer <jmoyer@redhat.com>, Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>


> -----Original Message-----
> From: Jeff Moyer [mailto:jmoyer@redhat.com] 
> Sent: Thursday, May 04, 2006 8:56 AM
> To: Ian Kent
> Cc: Rigler, Stephen C.; autofs mailing list
> Subject: Re: [autofs] [ANNOUNCE] autofs 5.0.0 beta1
> 
> raven> and /etc/auto.master exists with a +auto.master it 
> will probably get
> raven> it wrong in a strange way. Maybe that's what is happening?
> 
> Yeah, I think this is the one exception to the nsswitch rule. 
>  I wonder if
> it's the same if you have /etc/auto.foo that does a +auto.foo?  May be
> worth testing that out on another UNIX box to see what happens.
> 
> -Jeff
> 

Pretty much standard configuration here on Solaris and Irix is
to have "automount: files nis" in nsswitch.conf and "+auto.master"
in the local auto_master file.  I'm not aware if this is what
the standard automount behavior should be (it's documented in the
Irix man page for autofs), but we've gotten away with it for years 
if it's not.

Another nice thing to see would be the "-null" option in auto.master.
We have machines running clustered filesystems that are also
exported via NFS from one or two meta-data servers.  The machines
that see the filesystems locally should not automount the fileystems
and the "-null" would allow us to exclude them.

-Steve
