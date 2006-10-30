From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: /net support
Date: Mon, 30 Oct 2006 18:29:31 -0500
Message-ID: <x497iyh8js4.fsf@segfault.boston.devel.redhat.com>
References: <200610302252.k9UMquhr025943@jetcar.spd.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <200610302252.k9UMquhr025943@jetcar.spd.analog.com> (David
	Meleedy's message of "Mon, 30 Oct 2006 17:52:55 -0500")
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
To: David Meleedy <david.meleedy@analog.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

==> Regarding Re: [autofs] /net support; David Meleedy <david.meleedy@analog.com> adds:

>> As Jeff says, autofs version 5 works in a similar way to other
>> automounters now, by mounting (and expiring) the exported shares as you
>> go.
>> 
>> There is also a built in "-hosts" map now.
>> 
>> However, I've recently discovered that I haven't covered some of the
>> export access control syntax used by Solaris servers so you may still
>> need to use the auto.net script.
>> 
>> This issue will never be fixed in version 4 because version 4 cannot
>> handle the nesting of mounts found in server export lists.

david.meleedy> One other thing I am wondering about regarding this issue.
david.meleedy> I had discovered that at our site, we had to modify the
david.meleedy> /etc/auto.net script to return different -fstype options
david.meleedy> depending on whether or not the machine was on the LAN
david.meleedy> vs. on the WAN.  It turns out we needed to turn on tcp
david.meleedy> version 3 for our WAN mounts because udp mounts would hang
david.meleedy> once you tried to access the filesystem at all with "ls" or
david.meleedy> whatever.

david.meleedy> So for example, here is what we are doing for LAN vs. WAN:

david.meleedy> (here you can see "jetcar" a LAN mount vs. "siren" a WAN mount)

david.meleedy> codered-302: cd /etc
david.meleedy> codered-303: auto.net jetcar
david.meleedy> -fstype=nfs,hard,intr,nodev,nosuid \
david.meleedy>         /export/jetcar1 jetcar:/export/jetcar1 \
david.meleedy>         /export/jetcar2 jetcar:/export/jetcar2
david.meleedy> codered-304: auto.net siren
david.meleedy> -fstype=nfs,hard,intr,nodev,nosuid,bg,tcp,vers=3 \
david.meleedy>         /vol/vol0 siren:/vol/vol0 \
david.meleedy>         /vol/vol0/backups siren:/vol/vol0/backups \
david.meleedy>         /vol/vol0/proj siren:/vol/vol0/proj \
david.meleedy>         /vol/vol1 siren:/vol/vol1 \
david.meleedy>         /vol/vol1/proj siren:/vol/vol1/proj


david.meleedy> I am wondering if we switch to using "-hosts" which I would
david.meleedy> really prefer to do given that I wouldn't want a client to
david.meleedy> mount everything provided by a server.  Is there a way to
david.meleedy> have different fstype options happen on a per machine basis? 
david.meleedy> (I am assuming you don't do that right now, but I thought I
david.meleedy> would submit this concept to see if you have any ideas on
david.meleedy> how to do this).

My system defaults to tcp nfs v3 if no options are specified.  Given that
autofs now supports lazy mounts and unmounts, Is there a compelling reason
not to use TCP and/or version 3 mounts for the LAN?

To answer your question directly, no, there isn't a way to specify mount
options per server.

-Jeff
