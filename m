From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: /net support
Date: Tue, 31 Oct 2006 10:04:11 -0500
Message-ID: <x493b948r2s.fsf@segfault.boston.devel.redhat.com>
References: <200610310014.k9V0ECNB027517@jetcar.spd.analog.com>
	<1162283489.7511.162.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1162283489.7511.162.camel@localhost> (Ian Kent's message of "Tue,
	31 Oct 2006 16:31:29 +0800")
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
Cc: autofs@linux.kernel.org, David Meleedy <david.meleedy@analog.com>

==> Regarding Re: [autofs] /net support; Ian Kent <raven@themaw.net> adds:

raven> On Mon, 2006-10-30 at 19:14 -0500, David Meleedy wrote:
>> 
>> > My system defaults to tcp nfs v3 if no options are specified.  Given that
>> > autofs now supports lazy mounts and unmounts, Is there a compelling reason
>> > not to use TCP and/or version 3 mounts for the LAN?
>> 
>> 
>> Well, my understanding of TCP is that it uses a sliding window/packet
>> acknowledgment system to transfer data.  I would imagine that this
>> would incur a bandwidth overhead vs. UDP.  So, given that it's more
>> efficient to use UDP on the LAN, that is the behavior I had wanted to
>> set up.

raven> That very much depends on usage.

raven> If you have a bunch of clients that typically open and load files of
raven> potentially several hundred megabytes then UDP retransmits can become a
raven> problem.

raven> But then if traffic is light there's not much to be gained and if there
raven> are traffic spikes possibly something to be lost.

>> 
>> > To answer your question directly, no, there isn't a way to specify mount
>> > options per server.
>> 
>> I didn't think there would be at the moment.  Perhaps there would
>> be a way to set this up with automounter variables, or some other
>> mechanism.  I guess what I had been hoping for is that automounter
>> could somehow detect how long it takes to contact a given server,
>> and then depending on the lag, it would set the mount to be UDP
>> for a short lag, or TCP version 3 for a long one.

raven> This is actually fairly hard to do as ping responses can be so variable
raven> for all sorts reasons. Not sure how to go about this one.

Well, perhaps if the WAN is a different subnet we could reuse some of the
code from the replicated server support.  But you are right, ping times
are highly unreliable for making such decisions.

-Jeff
