From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: Newbie needs help with automounter.
Date: Mon, 11 Oct 2004 14:32:58 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <416AD1DA.7040700@sun.com>
References: <8FDC0F9BE1F91D44BE964AA54AAA67B60E65E8B5@wilmexm3.ad.analog.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <autofs-bounces@linux.kernel.org>
In-reply-to: <8FDC0F9BE1F91D44BE964AA54AAA67B60E65E8B5@wilmexm3.ad.analog.com>
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
To: "Burke, Alan" <Alan.Burke@analog.com>
Cc: autofs@linux.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Burke, Alan wrote:
> Hi 
> 
> I'm replying for Bill,
> 
> netstat -a --inet yields
> 
> Active Internet connections (servers and established)
> Proto Recv-Q Send-Q Local Address           Foreign Address
> State      

*snip*

> udp        0      0 *:251                   *:*
> 
> udp        0      0 *:379                   *:*
> 
> udp        0      0 *:507                   *:*
> 
> udp        0      0 *:635                   *:*
> 
> udp        0      0 *:763                   *:*
> 
> udp        0      0 *:124                   *:*
> 
> udp        0      0 *:252                   *:*
> 
> udp        0      0 *:380                   *:*
> 
> udp        0      0 *:508                   *:*
> 
> udp        0      0 *:636                   *:*
> 

Great, as the ports that aren't available are udp, this rules out any
pending sockets in tcp state TIME_WAIT.

> 
> 
> /proc/mounts too big to post all.
> 

*snip*

> rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
> dsdesign 0 0
> ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
> nfs
> rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
> dsdesign 0 0
> ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
> nfs
> rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
> dsdesign 0 0
> ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
> nfs
> rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
> dsdesign 0 0
> ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
> nfs
> rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
> dsdesign 0 0
> ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
> nfs
> rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
> dsdesign 0 0
> ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
> nfs
> rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
> dsdesign 0 0
> ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
> nfs
> rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
> ds
> 
> Snip few hundred lines
> 
> nfs
> rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
> dsdesign 0 0
> ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
> nfs
> rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
> dsdesign 0 0
> ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
> nfs
> rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
> dsdesign 0 0
> ntap1.adsdesign:/vol/vol0/comms01 /net/ntap1.adsdesign/vol/vol0/comms01
> nfs
> rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
> dsdesign 0 0
> ntap1.adsdesign:/vol/vol0/comms02 /net/ntap1.adsdesign/vol/vol0/comms02
> nfs
> rw,nosuid,nodev,v3,rsize=4096,wsize=4096,hard,intr,udp,lock,addr=ntap1.a
> dsdesign 0 0
> novus:/novus/whc /home/whc nfs
> rw,v3,rsize=4096,wsize=4096,hard,udp,lock,addr=novus 0 0
> dmv3:/disk1/rs /home/rsadmin nfs
> rw,v3,rsize=4096,wsize=4096,hard,udp,lock,addr=dmv3 0 0
> automount(pid13414) /dcad autofs rw 0 0
> automount(pid13293) /proj autofs rw 0 0
> 831ntap:/vol/vol0/proj/asic /proj/asic nfs
> rw,v3,rsize=4096,wsize=4096,hard,udp,lock,addr=831ntap 0 0
> cadntap:/vol/vol0/disk0/apps /dcad/apps nfs
> rw,v3,rsize=4096,wsize=4096,hard,udp,lock,addr=cadntap 0 0
> automount(pid31682) /misc autofs rw 0 0
> automount(pid31710) /net autofs rw 0 0
> automount(pid31743) /ajbhome autofs rw 0 0
> automount(pid31775) /local autofs rw 0 0
> automount(pid31836) /admin autofs rw 0 0
> automount(pid31912) /proj autofs rw 0 0
> automount(pid31832) /homes autofs rw 0 0
> automount(pid31865) /site autofs rw 0 0
> automount(pid31962) /home autofs rw 0 0
> automount(pid31933) /ntap autofs rw 0 0
> automount(pid32021) /dcad autofs rw 0 0
> automount(pid32064) /cad autofs rw 0 0
> 

Looks like automount / the kernel are really confused about whether or
not /net/ntap1.adsdesign is actually mounted, and the entire tree is
mounted each time it is accessed.

(It also appears that you restarted automount from the posting above)

Can you post version specific for the kernel, any patches applied, and
which automounter you are using?


Also, do you see anything related in your logs?

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBatHadQs4kOxk3/MRAr7+AKCKN6Dran5jnbAbqvXZUKSC9GRZnQCfcM8Y
SSklHYYBo+FygfgDi16smak=
=40Lk
-----END PGP SIGNATURE-----
