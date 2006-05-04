From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta1
Date: Thu, 04 May 2006 09:57:36 -0400
Message-ID: <x49mzdxyjsf.fsf@redhat.com>
References: <C3CDA0E3AC8B4E438E94F37D0A20FE71026B10D2@HOUEXC210.mgroupnet.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <C3CDA0E3AC8B4E438E94F37D0A20FE71026B10D2@HOUEXC210.mgroupnet.com>
	(Stephen C. Rigler's message of "Thu, 4 May 2006 08:08:58 -0500")
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

>> -----Original Message----- From: Ian Kent [mailto:raven@themaw.net]
>> Sent: Thursday, May 04, 2006 7:29 AM To: Rigler, Stephen C.  Cc: autofs
>> mailing list Subject: RE: [autofs] [ANNOUNCE] autofs 5.0.0 beta1
>> 
>> What do you have in the nsswitch.conf automount: entry?

srigler> I had "automount: files nis"

>> You probably already know this but ...
>> 
>> The default master map is /etc/auto.master but that can be changed by
>> setting DEFAULT_MASTER_MAP_NAME in the config or giving it on the
>> command line for automount.
>> 
>> Setting
>> 
>> DEFAULT_MASTER_MAP_NAME=auto.master
>> 
>> and
>> 
>> automount: nis
>> 
>> should do the trick.
>> 
>> However if you had
>> 
>> automount: files nis
>> 

srigler> So far, the combination that's worked is only specifying "nis" in
srigler> nsswitch.conf and changing "DEFAULT_MASTER_MAP_NAME" to
srigler> "auto.master".  What's logged in messages when I use any other
srigler> combination is "master_read_master: no mounts in table".

You should also be able to keep your nsswitch the same (automount: files
nis) and simply remove /etc/auto.master.

-Jeff
