From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH] check nsswitch.conf for submounts
Date: Mon, 28 Feb 2005 09:10:22 -0500
Message-ID: <16931.9806.115239.891035@segfault.boston.redhat.com>
References: <421D05BF.5000206@redhat.com>
	<Pine.LNX.4.61.0502271124090.8184@donald.themaw.net>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.61.0502271124090.8184@donald.themaw.net>
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org, Chris Feist <cfeist@redhat.com>

==> Regarding Re: [autofs] [PATCH] check nsswitch.conf for submounts; raven@themaw.net adds:

raven> On Wed, 23 Feb 2005, Chris Feist wrote: Thanks Chris.

raven> This is a really useful bit of code.  Appart from addressing the
raven> default map problem, it is one of the pieces of code needed to move
raven> logic out of the init script.

raven> Howerver, we can't assume that maps are stored in "/etc".  This
raven> really should be a configure logical.

And why not?  Is this not precisely what the Sun automounter does?

-Jeff

>> This patch addresses the problem if a user has the following in one of
>> their automount maps: # auto.misc test -fstype=autofs auto.m2
>> 
>> Before it would automatically assume that auto.m2 was a yp/nis map.  The
>> patch now checks if the file exists in /etc/ (and if it's a file or
>> program map) or if it exists in yp (according to the order in
>> nsswitch.conf).
>> 
>> In the future we may want to include functionality in the lookup_xxx.so
>> modules so we can more easily detect if a certain map exists.
>> 
>> Thanks, Chris
>> 
>> 

raven> _______________________________________________ autofs mailing list
raven> autofs@linux.kernel.org
raven> http://linux.kernel.org/mailman/listinfo/autofs
