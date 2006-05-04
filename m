From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta1
Date: Thu, 04 May 2006 14:03:47 -0400
Message-ID: <x49ac9xy8e4.fsf@redhat.com>
References: <C3CDA0E3AC8B4E438E94F37D0A20FE71026B10D5@HOUEXC210.mgroupnet.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <C3CDA0E3AC8B4E438E94F37D0A20FE71026B10D5@HOUEXC210.mgroupnet.com>
	(Stephen C. Rigler's message of "Thu, 4 May 2006 12:29:54 -0500")
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
Content-Transfer-Encoding: 7bit
To: "Rigler, Stephen C." <srigler@marathonoil.com>
Cc: autofs mailing list <autofs@linux.kernel.org>, Ian Kent <raven@themaw.net>

==> Regarding RE: [autofs] [ANNOUNCE] autofs 5.0.0 beta1; "Rigler, Stephen C." <srigler@marathonoil.com> adds:

>> -----Original Message----- From: Jeff Moyer [mailto:jmoyer@redhat.com]
>> Sent: Thursday, May 04, 2006 8:56 AM To: Ian Kent Cc: Rigler, Stephen
>> C.; autofs mailing list Subject: Re: [autofs] [ANNOUNCE] autofs 5.0.0
>> beta1
>> 
raven> and /etc/auto.master exists with a +auto.master it
>> will probably get
raven> it wrong in a strange way. Maybe that's what is happening?
>> Yeah, I think this is the one exception to the nsswitch rule. I wonder
>> if it's the same if you have /etc/auto.foo that does a +auto.foo?  May
>> be worth testing that out on another UNIX box to see what happens.
>> 
>> -Jeff
>> 

srigler> Pretty much standard configuration here on Solaris and Irix is to
srigler> have "automount: files nis" in nsswitch.conf and "+auto.master" in
srigler> the local auto_master file.  I'm not aware if this is what the
srigler> standard automount behavior should be (it's documented in the Irix
srigler> man page for autofs), but we've gotten away with it for years if
srigler> it's not.

srigler> Another nice thing to see would be the "-null" option in
srigler> auto.master.  We have machines running clustered filesystems that
srigler> are also exported via NFS from one or two meta-data servers.  The
srigler> machines that see the filesystems locally should not automount the
srigler> fileystems and the "-null" would allow us to exclude them.

Well, you're in luck.  Give autofs5 a try, as it is supposed to handle
-null maps.

-Jeff
