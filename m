From: Robert Kuropkat <robert.a.kuropkat@saic.com>
Subject: Re: autofs-5.0.1-0.rc2.55.el5.3 core dump
Date: Wed, 23 Apr 2008 16:33:00 -0400
Message-ID: <480F9CFC.9040206@saic.com>
References: <47FF8D07.7080208@schrodinger.com>	<x49iqyo9x8i.fsf@segfault.boston.devel.redhat.com>	<47FF9443.4020305@schrodinger.com>	<1207970551.3138.9.camel@raven.themaw.net>
	<480E5E0A.2050702@saic.com>	<1208946658.3207.26.camel@raven.themaw.net>	<480F8D64.2070204@saic.com>
	<x49abjkic62.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49abjkic62.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>



Jeff Moyer wrote:
> Robert Kuropkat <robert.a.kuropkat@saic.com> writes:
> 
>> Ian,
>>
>> Ian Kent wrote:
>>> On Tue, 2008-04-22 at 17:52 -0400, Robert Kuropkat wrote:
>>>> Ian,
>>>>

<snip>

>>
>> and then of course, all entries end.  This does not seem very verbose.
>> Is there another log file somewhere I am missing?
> 
> Check out http://people.redhat.com/jmoyer for instructions on collecting
> debug information.  You need to tell syslog to put that stuff somewhere,
> is all, so look for the bits on setting up /etc/syslog.conf.
> 
> Cheers,
> 
> Jeff
> 

Done, thank you very much.  When it crashes again, I'll post the results.

Robert Kuropkat
