From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: automounter segfaults when using negative cache?
Date: Mon, 08 Dec 2008 10:08:35 +0100
Message-ID: <493CE413.5050905@s3group.cz>
References: <4937BBBC.9030305@s3group.cz>
	<x497i6e6291.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x497i6e6291.fsf@segfault.boston.devel.redhat.com>
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
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>


>> I thought all the negative caching is done in user space, but apparently
>> kernel has some influence here....
>> Any explanation?
>>     
>
> The negative caching is done in userspace.  I'm not sure I understand
> your question.
>
> Cheers,
> Jeff
>   


Hi Jeff,
Ok I was thinking this way:
I experience this only on U7 system running U4 kernel - on the same U7
system running U7 kernel I can not replicate this. If the negative
caching is done in the user space and there is a bug there which causes
the autofs to segfault, how is it possible that is won't segfault on the
U7 kernel?
I do not know I am still trying to find out if there is any connection
to the problem with the automounter hanging that I reported earlier as:
- in U7 system running U7 kernel, the autofs does not crash, but hangs
(after few days).
- in U7 system running U4 kernel, the autofs forks crash regularly but
otherwise it works fine (I mean at least the parent autofs fork continue
living...)
You know what I am trying to say?
Thanks,
Ondrej
