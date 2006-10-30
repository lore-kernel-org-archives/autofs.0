From: David Meleedy <david.meleedy@analog.com>
Subject: Re: /net support
Date: Mon, 30 Oct 2006 17:52:55 -0500
Message-ID: <200610302252.k9UMquhr025943@jetcar.spd.analog.com>
References: <1162008305.3091.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: Your message of "Sat, 28 Oct 2006 12:05:05 +0800."
	<1162008305.3091.8.camel@localhost> 
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org


> As Jeff says, autofs version 5 works in a similar way to other
> automounters now, by mounting (and expiring) the exported shares as you
> go.
> 
> There is also a built in "-hosts" map now.
> 
> However, I've recently discovered that I haven't covered some of the
> export access control syntax used by Solaris servers so you may still
> need to use the auto.net script.
> 
> This issue will never be fixed in version 4 because version 4 cannot
> handle the nesting of mounts found in server export lists.

One other thing I am wondering about regarding this issue.  I had
discovered that at our site, we had to modify the /etc/auto.net script
to return different -fstype options depending on whether or not the
machine was on the LAN vs. on the WAN.  It turns out we needed to
turn on tcp version 3 for our WAN mounts because udp mounts would hang
once you tried to access the filesystem at all with "ls" or whatever.

So for example, here is what we are doing for LAN vs. WAN:

(here you can see "jetcar" a LAN mount vs. "siren" a WAN mount)

codered-302: cd /etc
codered-303: auto.net jetcar
-fstype=nfs,hard,intr,nodev,nosuid \
        /export/jetcar1 jetcar:/export/jetcar1 \
        /export/jetcar2 jetcar:/export/jetcar2
codered-304: auto.net siren
-fstype=nfs,hard,intr,nodev,nosuid,bg,tcp,vers=3 \
        /vol/vol0 siren:/vol/vol0 \
        /vol/vol0/backups siren:/vol/vol0/backups \
        /vol/vol0/proj siren:/vol/vol0/proj \
        /vol/vol1 siren:/vol/vol1 \
        /vol/vol1/proj siren:/vol/vol1/proj


I am wondering if we switch to using "-hosts" which I would really
prefer to do given that I wouldn't want a client to mount everything
provided by a server.  Is there a way to have different fstype options
happen on a per machine basis? (I am assuming you don't do that right now,
but I thought I would submit this concept to see if you have any ideas
on how to do this).

Thanks,

-Dave


________________________________________________________________________
David Meleedy				Analog Devices, Inc.
David.Meleedy@analog.com		Three Technology Way
Phone: 781 461 3494			Norwood, MA  02062-9106  USA
