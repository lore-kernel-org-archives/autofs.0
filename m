From: Ian Kent <raven@themaw.net>
Subject: RE: making the mountpoints visible all the time
Date: Tue, 18 Nov 2003 22:05:39 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.44.0311182203190.3008-100000@raven.themaw.net>
References: <C3CDA0E3AC8B4E438E94F37D0A20FE712618F8@HOUEXC210.mgroupnet.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <C3CDA0E3AC8B4E438E94F37D0A20FE712618F8@HOUEXC210.mgroupnet.com>
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
To: autofs mailing list <autofs@linux.kernel.org>

On Fri, 14 Nov 2003, Rigler, Steve wrote:

> > 
> > Ian Kent wrote:
> > 
> > >The autofs4-2.4 module build kit or the patches contained in 
> > it or the
> > >patches contained in autofs-4.1.0-beta3 can give you this 
> > for some of the
> > >maps. NIS, LDAP and file maps work at the moment.
> > >
> > >I's in the expected place on kernel.org.
> > >  
> > >
> > 
> > not sure what you mean by file maps, but I'm trying to mount 
> > samba and 
> > nfs shares so i guess I'm out of luck...
> > 
> 
> In order to view the mountpoints before they are mounted you need
> to have the newer version of the kernel module which is available
> at kernel.org.
> 
> The maps aren't really specific to the type of filesystem you are
> trying to mount.  You can get your maps from a local file, NIS, LDAP,
> etc.  They can contain information to mount smb, nfs, or even local
> filesystems.
> 
> If you install the newer kernel module, you can make your mountpoints
> visisible with the ghosting option.  One way to enable this is to 
> set it in your /etc/auto.master like:
> 
> /somedir	file:/etc/auto.somedir	-g

I've had some trouble lately with using the -g.
If this is a problem use the long option --ghost, that seemed to work OK.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/
