From: David Meleedy <david.meleedy@analog.com>
Subject: Re: BUG: autofs4 + cd /net/<Netapp>/vol/vol[0-3] = port
 usage problems
Date: Wed, 12 Jan 2005 15:55:59 -0500
Message-ID: <200501122055.j0CKtxrT011294@jetcar.spd.analog.com>
References: <41E54CC4.3090600@analog.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: Your message of "Wed, 12 Jan 2005 11:13:56 EST."
	<41E54CC4.3090600@analog.com> 
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
Content-Transfer-Encoding: 7bit
To: Dwight Marzolf <dwight.marzolf@analog.com>
Cc: autofs@linux.kernel.org


> Dave,
> 
> >Now when I tried to do something similar, I found that if you weren't
> >on node1 or node2, the filesystem was read-only, so I had to do this:
> >
> >/vol/vol1	-rw=node1:node2,root=node1,node2
> >/vol/vol1/foo1	-root=node1:node2
> >/vol/vol1/foo2  -root=node1:node2
> 
> On this one here, the top line is correct but the other two lines should be:
> 
> /vol/vol1/foo1	-rw,root=node1:node2
> /vol/vol1/foo2  -rw,root=node1:node2
> 
> This way, the vol/vol1 dir does not mount when you cd to 
> /net/machine/vol/vol1 but the other two directories do mount and are 
> accessible by all workstations that need to read and write to it.  This 
> should work under both RedHat 8 and Enterprise 3.  Now, I don't know why 
> autofs4 seems to require the exports to be this way on a netapp box when 
> Solaris didn't seem to care but this is what is working for us.
> 
> Dwight Marzolf

I tried changing the syntax, as you suggested, and I got the following
error:

aflac> exportfs -a
export: No "=<hosts>" in "rw" option
exportfs: invalid option, /vol/vol1/IssueManager not exported
export: No "=<hosts>" in "rw" option
exportfs: invalid option, /vol/vol1/admin not exported

... etc ...

Here is the actual entry from the exports file on the filer:

/vol/vol1/IssueManager  -rw,root=sloth.spd.analog.com:zeus.spd.analog.com:chimc
h
im.spd.analog.com:chimchim-ge2.spd.analog.com:thrak.spd.analog.com:mr_coffee.sp
d
.analog.com:jetcar.spd.analog.com:topgun.spd.analog.com:cyclone.spd.analog.com

But my understanding anyway is that by default the permission for an
exported filesystem on the filer should be -rw anyway, so I'm not sure why you
would have to specify it.

-Dave

________________________________________________________________________
David Meleedy				Analog Devices, Inc.
David.Meleedy@analog.com		Three Technology Way
Phone: 781 461 3494			Norwood, MA  02062-9106  USA
