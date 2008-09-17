From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: latest autofs from centos 4
Date: Wed, 17 Sep 2008 12:47:51 -0400
Message-ID: <x49od2m7m88.fsf@segfault.boston.devel.redhat.com>
References: <alpine.LRH.2.00.0809161716010.13560@q7.q7.com>
	<1221621937.3001.3.camel@raven.themaw.net>
	<alpine.LRH.2.00.0809170858590.29177@q7.q7.com>
	<1221668372.3001.28.camel@raven.themaw.net>
	<alpine.LRH.2.00.0809170920230.12947@q7.q7.com>
	<1221669383.3001.35.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1221669383.3001.35.camel@raven.themaw.net> (Ian Kent's message
	of "Thu, 18 Sep 2008 00:36:23 +0800")
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

Ian Kent <raven@themaw.net> writes:

> On Wed, 2008-09-17 at 09:22 -0700, Joe Pruett wrote:
>> i am still having some kind of issue where at boot time, it can't seem to 
>> find a server or talk to mountd or something like that and then won't try 
>> again.  it looks like maybe this is the negative caching feature?  is that 
>> new as well?
>
> Jeff is more familiar with the RHEL-4 v4 code than I am, I'll have to
> leave this to him. In any case we'd need to see a debug log.

Yep, gather a debug log and include the other pertinent information
from:
  http://people.redhat.com/~jmoyer/

Thanks,

Jeff
