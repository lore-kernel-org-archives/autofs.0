From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: network timeout needed at startup
Date: Fri, 15 Sep 2006 10:17:39 -0400
Message-ID: <x49d59xuscc.fsf@segfault.boston.devel.redhat.com>
References: <44FEAD66.7060106@inria.fr>
	<Pine.LNX.4.64.0609151112500.5999@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0609151112500.5999@raven.themaw.net> (Ian Kent's
	message of "Fri, 15 Sep 2006 11:20:07 +0800 (WST)")
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

==> Regarding Re: [autofs] network timeout needed at startup; Ian Kent <raven@themaw.net> adds:

raven> On Wed, 6 Sep 2006, Guillaume Rousse wrote:
>> When using LDAP (and probably other network resources) to store master
>> map, the network has to be available at autofs daemon start. As Linux
>> distributions boot time is currently diminushing (hotplug replaced by
>> udev, various parallelisation effort), I see various race conditions
>> occuring: the network service finishes, but the actual network interface
>> is still in initialisation state, leading to autofs start failure.
>> 
>> The primary problem comes from network service implementation, and
>> should probably get fixed there, right. However, I also think than
>> having a configurable network timeout directly in autofs (aka: wait at
>> least 10 second before considering the server is down) may also help in
>> other scenarios. For instance, when you start various machine
>> simultaneously (for instance, after a general power down), and your
>> server takes longer to boot than your workstation.

raven> Are you talking about a wait at startup or extending the timeout on
raven> mounts or adding additional timeout processing for LDAP?

raven> Changing the timeout values for mounts would cause large delays,
raven> we've been there before with complains about how long it takes for
raven> mounts to unavailable servers to timeout.

Consider if your master map is stored in the ldap server.  It sounds to me
like the requested functionality is to be patient when obtaining the
initial map.

>> With autofs 4, I implemented this in service script. Now than everything
>> is handled by autoumout daemon, this should get implemented there I
>> think.

raven> At startup in the init script, checking map server availability, we
raven> could still do such a thing.

True, sounds like a hack, though.  ;)

-Jeff
