From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [ANNOUNCE] autofs 5.0.0 beta1
Date: Thu, 04 May 2006 09:56:09 -0400
Message-ID: <x49u085yjuu.fsf@redhat.com>
References: <C3CDA0E3AC8B4E438E94F37D0A20FE71026B10D0@HOUEXC210.mgroupnet.com>
	<Pine.LNX.4.64.0605042019420.3559@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605042019420.3559@raven.themaw.net> (Ian Kent's
	message of "Thu, 4 May 2006 20:29:00 +0800 (WST)")
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
To: Ian Kent <raven@themaw.net>
Cc: autofs mailing list <autofs@linux.kernel.org>

==> Regarding RE: [autofs] [ANNOUNCE] autofs 5.0.0 beta1; Ian Kent <raven@themaw.net> adds:

raven> On Thu, 4 May 2006, Rigler, Stephen C. wrote:
>> I have it installed on one FC5 machine running the vanilla 2.6.16.12
>> kernel patched with the autofs4-2.6.16-v5 patch.
>> 
>> Operationally everything seems good so far.  I like how the direct
>> mounts are ghosted (which is consistent behavior with the other unixes
>> we run).
>> 
>> The only issue I had was with parsing of auto.master.  We get our
>> auto.master from NIS and automount didn't seem to want to parse it even
>> when specifying "+auto.master" in /etc/auto.master.  I ended up
>> ypcat'ing auto.master

raven> What do you have in the nsswitch.conf automount: entry?

raven> You probably already know this but ...

raven> The default master map is /etc/auto.master but that can be changed
raven> by setting DEFAULT_MASTER_MAP_NAME in the config or giving it on the
raven> command line for automount.

raven> Setting

raven> DEFAULT_MASTER_MAP_NAME=auto.master

raven> and

raven> automount: nis

raven> should do the trick.

raven> However if you had

raven> automount: files nis

raven> and /etc/auto.master exists with a +auto.master it will probably get
raven> it wrong in a strange way. Maybe that's what is happening?

Yeah, I think this is the one exception to the nsswitch rule.  I wonder if
it's the same if you have /etc/auto.foo that does a +auto.foo?  May be
worth testing that out on another UNIX box to see what happens.

-Jeff
