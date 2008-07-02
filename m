From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: How can I synchronize among different nfs clients?
Date: Wed, 02 Jul 2008 09:45:11 -0400
Message-ID: <x49od5gpfh4.fsf@segfault.boston.devel.redhat.com>
References: <ec9e7ff10807010459q300bf6e4kc04a1abb500233aa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <ec9e7ff10807010459q300bf6e4kc04a1abb500233aa@mail.gmail.com>
	(Kun Niu's message of "Tue, 1 Jul 2008 19:59:04 +0800")
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
To: Kun Niu <haoniukun@gmail.com>
Cc: autofs@linux.kernel.org

"Kun Niu" <haoniukun@gmail.com> writes:

> Dear all,
> I'm using nfs among different computers which have ubuntu 8.04 installed.
> I found it worked fine until much of memory used by cache almost used
> my memory up.
> After that, the directory I made on one computer didn't appear on other ones.
> Are there any log I can track to solve the problem?
> Thanks in advance for any advice.

First, this post belongs on linux-fsdevel@vger.kernel.org.  Second,
you'll want to provide the kernel version you are using and a better
problem description.

Cheers,

Jeff
