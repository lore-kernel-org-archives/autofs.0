From: "Rigler, Steve" <SRigler@MarathonOil.com>
Subject: RE: making the mountpoints visible all the time
Date: Fri, 14 Nov 2003 08:48:05 -0600
Sender: autofs-bounces@linux.kernel.org
Message-ID: <C3CDA0E3AC8B4E438E94F37D0A20FE712618F8@HOUEXC210.mgroupnet.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Alexander Macdonald <alexandermacdonald@yahoo.com>, autofs@linux.kernel.org



> -----Original Message-----
> From: autofs-bounces@linux.kernel.org
> [mailto:autofs-bounces@linux.kernel.org]On Behalf Of 
> Alexander Macdonald
> Sent: Friday, November 14, 2003 6:13 AM
> To: autofs@linux.kernel.org
> Subject: Re: [autofs] making the mountpoints visible all the time
> 
> 
> Ian Kent wrote:
> 
> >The autofs4-2.4 module build kit or the patches contained in 
> it or the
> >patches contained in autofs-4.1.0-beta3 can give you this 
> for some of the
> >maps. NIS, LDAP and file maps work at the moment.
> >
> >I's in the expected place on kernel.org.
> >  
> >
> 
> not sure what you mean by file maps, but I'm trying to mount 
> samba and 
> nfs shares so i guess I'm out of luck...
> 

In order to view the mountpoints before they are mounted you need
to have the newer version of the kernel module which is available
at kernel.org.

The maps aren't really specific to the type of filesystem you are
trying to mount.  You can get your maps from a local file, NIS, LDAP,
etc.  They can contain information to mount smb, nfs, or even local
filesystems.

If you install the newer kernel module, you can make your mountpoints
visisible with the ghosting option.  One way to enable this is to 
set it in your /etc/auto.master like:

/somedir	file:/etc/auto.somedir	-g

Or you can add the "-g" to the "daemonoptions" variable line in 
/etc/init.d/autofs.

-Steve
