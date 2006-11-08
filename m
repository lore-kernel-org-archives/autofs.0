From: Peter Staubach <staubach@redhat.com>
Subject: Re: autofs illustrations
Date: Wed, 08 Nov 2006 08:25:54 -0500
Message-ID: <4551DAE2.1080704@redhat.com>
References: <200611071719.kA7HJSvl002639@cs.utexas.edu>
	<1162958395.3555.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1162958395.3555.8.camel@localhost>
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

Ian Kent wrote:
>
>   
>> Unprivileged ports and/or UDP are not viable options for us, so I am
>> forced to increase the timeout from 5 minutes to 24 hours, which in
>> practice means they are always mounted.  We have about 400 automounted
>> filesystems, so the only long term solution for us is to try to coalesce
>> them to less than 100.  Very painful.
>>     
>
> Understood. We had similar constraints at my last employer.
>
> I'm not aware of any work being actively done on this.
> Nobody that cares has any time at the moment.
>
>   

Actually, there is work on going to reduce the number of connections 
from the
client to the server from one per mount to one per client server 
combination.
Solaris has always done this and it works out quite well in practice.

       ps
