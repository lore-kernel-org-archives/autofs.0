From: raven@themaw.net
Subject: Re: [patch] Fix buffer overflow with large key lengths in
	file maps
Date: Sat, 30 Apr 2005 00:09:22 +0800 (WST)
Message-ID: <Pine.LNX.4.62.0504300008470.4049@donald.themaw.net>
References: <17010.21312.962838.364226@segfault.boston.redhat.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <17010.21312.962838.364226@segfault.boston.redhat.com>
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

> Hi Ian,
>
> I'm attempting to get the connectathon automount test suite running, and it
> turned up this bug.  Basically, we never do any bounds checking on the key
> array passed into read_one in lookup_file.c.   This patch fixes the problem
> in my environment.
>
> Thanks,
>
> Jeff
>
> --- autofs-4.1.4/modules/lookup_file.c.orig	2005-04-29 11:14:54.699437608 -0400
> +++ autofs-4.1.4/modules/lookup_file.c	2005-04-29 11:21:16.004470432 -0400
> @@ -157,6 +157,10 @@ static int read_one(FILE *f, char *key,
> 			break;
>
> 		case st_compare:
> +			if (kptr - key > KEY_MAX_LEN) {
> +				state = st_badent;
> +				break;
> +			}
> 			if (ch == '\n')
> 				state = st_begin;
> 			else if (isspace(ch) && !escape) {
>

Thanfs Jeff. I'll merge that.

Ian
