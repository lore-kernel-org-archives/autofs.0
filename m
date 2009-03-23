From: "michael@kmaclub.com" <michael@kmaclub.com>
Subject: Re: autofs5 early daemonization side effects
Date: Mon, 23 Mar 2009 13:42:39 -0700
Message-ID: <49C7F43F.7060704@kmaclub.com>
References: <c2d0b6ec0903180710s63e5aaa7r567c66d1139dd718@mail.gmail.com>	<x49sklahpfx.fsf@segfault.boston.devel.redhat.com>	<49C11A67.5000603@themaw.net>
	<c2d0b6ec0903181339o1bf5ea2cv3c16125fc702a572@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <c2d0b6ec0903181339o1bf5ea2cv3c16125fc702a572@mail.gmail.com>
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
To: Leonardo Chiquitto <leonardo.lists@gmail.com>
Cc: autofs@linux.kernel.org

Leonardo Chiquitto wrote:
>> Jeff Moyer wrote:
>>> Leonardo Chiquitto <leonardo.lists@gmail.com> writes:
>>>
>>>> Hello,
>>>>
>>>> I've been doing some tests with AutoFS5 and I'd like to confirm that
>>>> the behavior I'm seeing during the daemon initialization is expected
>>>> or not.
>>>>
>>>> The problem: when the autofs initscript returns, autofs is not really
>>>> ready.
>>> Strange.  I originally wrote the code to return a status via a pipe, so
>>> that the init script would not return status until the daemon was ready
>>> to service requests.  It also took care of the problem of the init
>>> script returning success when the daemon actually failed.
> 
> The Autofs code is completely right. The problem I'm seeing is being
> caused by startproc, a wrapper to start daemons that some distros
> (like openSUSE) use.
> 
> Applying the following pseudo-patch in the initscript makes everything
> work as it should:
> 
> -    /sbin/startproc $DAEMON $AUTOFS_OPTIONS
> +    $DAEMON $AUTOFS_OPTIONS
> 
> Ian and Jeff, thanks for the help and sorry for the noise. Michael,
> with luck this will be a valid workaround for you too!

Thanks,

That does seem to be working for me.

Michael
