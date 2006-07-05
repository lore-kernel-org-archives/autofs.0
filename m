From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: autofs5: unable to locate ldap master map
Date: Wed, 05 Jul 2006 08:53:05 -0400
Message-ID: <x49irmc43im.fsf@segfault.boston.redhat.com>
References: <44A25311.2040501@inria.fr>
	<1151554184.2929.45.camel@raven.themaw.net>
	<44A3B6CD.5030403@inria.fr>
	<1151585997.3915.36.camel@raven.themaw.net>
	<44A4E38D.7020004@inria.fr>
	<Pine.LNX.4.64.0607020143300.11953@raven.themaw.net>
	<44A9216F.1030102@inria.fr>
	<1151943337.9183.44.camel@raven.themaw.net>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1151943337.9183.44.camel@raven.themaw.net> (Ian Kent's message
	of "Tue, 04 Jul 2006 00:15:37 +0800")
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

==> Regarding Re: [autofs] autofs5: unable to locate ldap master map; Ian Kent <raven@themaw.net> adds:
>> > use different locations to customise them. If it doesn't meet with your 
>> > approval then I'm sorry but I like it and it works well for me. And I 
>> > don't see any patch submissions from you for discussion so I guess you'll 
>> > just have to live with it.
>> I don't see the point of investing time to produce patches that will be
>> rejected, so I usually try to reach agreement before. Now, if all you
>> want is a patch, I can easily produce one, once we agree on the
>> following points:
>> - is is desirable to have distinct directories for automount
>> configuration and master map location (aka --with-confdir and
>> --with-mapdir switches) ?

raven> I think so.
raven> Certainly the map directory is different on different distributions so
raven> that's definitely a good thing to have. And your point above would imply
raven> having the configuration directory configurable is good as well.

If you're using a mixed environment (Linux and other Unix variants), then
you'll likely keep your maps in /etc/ for interoperability purposes.  As
such, I don't really see a reason to put maps elsewhere.

-Jeff
