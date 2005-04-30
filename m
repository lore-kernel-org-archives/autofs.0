From: raven@themaw.net
Subject: Re: [patch] fix multi maps that have an implied '/' entry
Date: Sat, 30 Apr 2005 23:12:56 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504302307230.2229@donald.themaw.net>
References: <17010.37023.613781.405203@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17010.37023.613781.405203@segfault.boston.redhat.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org

On Fri, 29 Apr 2005, Jeff Moyer wrote:

> This is apparently a legal format for a multi-mount map:
>
> g3b     segfault.boston.redhat.com:/export/automount/export5/testing/test \
>        /s1     segfault.boston.redhat.com:/export/automount/export2 \
>        /s2     segfault.boston.redhat.com:/export/automount/export3
>
> The first entry is an implied root level entry, or '/'.  Solaris handles
> this case just fine, and the automounter test sweet uses this as one of its
> tests.  The attached patch causes this map format to be recognized.  I
> think the patch could probably re-use the memory allocatd for "path" by the
> dequote function.  That's up to you, Ian, if you want to change that to be
> a little prettier.

I've already placed a patch on kernel.org for that.
Check out autofs-4.1.4-multi-parse-fix.patch and let me know what you 
think.

It also addresses the multi-mount recognition problem you mentioned 
a short while ago.

Ian
