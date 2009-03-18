From: Ian Kent <raven@themaw.net>
Subject: Re: autofs5 early daemonization side effects
Date: Thu, 19 Mar 2009 00:59:35 +0900
Message-ID: <49C11A67.5000603@themaw.net>
References: <c2d0b6ec0903180710s63e5aaa7r567c66d1139dd718@mail.gmail.com>
	<x49sklahpfx.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49sklahpfx.fsf@segfault.boston.devel.redhat.com>
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
Cc: autofs@linux.kernel.org

Jeff Moyer wrote:
> Leonardo Chiquitto <leonardo.lists@gmail.com> writes:
> 
>> Hello,
>>
>> I've been doing some tests with AutoFS5 and I'd like to confirm that
>> the behavior I'm seeing during the daemon initialization is expected
>> or not.
>>
>> The problem: when the autofs initscript returns, autofs is not really
>> ready.
> 
> Strange.  I originally wrote the code to return a status via a pipe, so
> that the init script would not return status until the daemon was ready
> to service requests.  It also took care of the problem of the init
> script returning success when the daemon actually failed.
> 
> Ian, has this changed?

No, but there was a problem with the read size on x86_64, which has also 
been fixed. I'm not sure if that was a transcription error on my part or 
not.

The other possibility is that the handle_mounts() thread creation could 
be returning before it has completed its initialisation. But looking at 
the code I can't see that happening either, certainly not before the 
mount is done and the map read, if in fact it needs to be read (which, 
as you know, it isn't for the most common configuration).

Ian
