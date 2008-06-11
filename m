From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: the debug info of the autofs
Date: Wed, 11 Jun 2008 10:11:25 -0400
Message-ID: <x49bq2883jm.fsf@segfault.boston.devel.redhat.com>
References: <5a26be460805281833i5ef9856cyd0986016a86cdf76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <5a26be460805281833i5ef9856cyd0986016a86cdf76@mail.gmail.com>
	(Binbin Wang's message of "Thu, 29 May 2008 09:33:49 +0800")
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
To: Binbin Wang <binbinwang118@gmail.com>
Cc: autofs@linux.kernel.org

"Binbin Wang" <binbinwang118@gmail.com> writes:

> Hi,
>
> I am using the autofs-4.1.3-155 (RHEL4.2). I have seen the man page.
>
> man automount
> -v, --verbose
>               Enables printing of general status and progress messages.
>
> -d, --debug
>               Enables printing of general status and progress messages as
> well as debug-
>               ing messages.
>
> I found that all these debug information have been writen to the system log
> file (/var/log/message)
>
> I wang to know that whether I can define the output file of the debug
> information. Thank you very much!

Sure.  See http://people.redhat.com/jmoyer/.

Cheers,

Jeff
