From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Reports of huge CPU usage with 5.0.2
Date: Sun, 16 Sep 2007 20:50:55 -0400
Message-ID: <x49k5qqxggg.fsf@segfault.boston.devel.redhat.com>
References: <46ED96B6.8070305@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46ED96B6.8070305@inria.fr> (Guillaume Rousse's message of "Sun\,
	16 Sep 2007 22\:48\:54 +0200")
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

Guillaume Rousse <Guillaume.Rousse@inria.fr> writes:

> Hello.
>
> I have several reports from users having constant 20% cpu usage from
> automounter since 5.0.2 release, but I can't reproduce myself: see
> http://qa.mandriva.com/show_bug.cgi?id=32611
>
> Is anyone else here facing the same problem ?

Not that I know of, certainly not with that old kernel!  Can you get
an strace of the thread that is hogging the CPU?  Also, I didn't see a
debug log posted.  Please refer the users to my people page for
directions on enabling debugging:
  http://people.redhat.com/jmoyer

Cheers,

Jeff
