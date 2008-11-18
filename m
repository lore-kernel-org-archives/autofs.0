From: Joe Pruett <joey@clean.q7.com>
Subject: Re: hung server again
Date: Tue, 18 Nov 2008 08:39:34 -0800 (PST)
Message-ID: <alpine.LRH.2.00.0811180834450.18255@q7.q7.com>
References: <alpine.LRH.2.00.0811180725001.21620@q7.q7.com>
	<1227023859.3045.83.camel@zeus.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1227023859.3045.83.camel@zeus.themaw.net>
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

>> a few months back i had a situation where a child of automount wouldn't
>> exit properly and that would cause the parent to get locked up and all
>> automount would stop working.  if i could get onto the system, i could
>> strace the child automounts and watch them exit and eventually i'd hit the
>> one that was the cause and then everything would start working again.
>> there have been a number of kernel updates since and it looked like things
>> were working normally again.  but i was wrong, our web server locked up
>> last night from the same issue again.  given the length of time between
>> issues and the infeasibility of debugging this on a live server i want to
>> ask about my setup and see if i should change things.
>
> How about version of autofs and kernel?

sorry about that.  it's clear in my mind :-).

this is on centos 4 and 5.  using almost standard autofs5 (5.0.1-0.rc2.88) 
on both.  on centos 4 i have applied a patch from the list to correct the 
problem with finding local ip information with lots of interface for bind 
mounts to function correctly.  standard kernel as well.
