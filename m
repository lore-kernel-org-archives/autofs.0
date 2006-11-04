From: Ian Kent <raven@themaw.net>
Subject: Re: dead lock (autofs and/or mount)
Date: Sat, 04 Nov 2006 09:51:48 +0800
Message-ID: <1162605108.25017.14.camel@localhost>
References: <454B7750.9000307@infomaniak.ch>
	<x49wt6c1hrr.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49wt6c1hrr.fsf@segfault.boston.devel.redhat.com>
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
Cc: autofs <autofs@linux.kernel.org>

On Fri, 2006-11-03 at 13:56 -0500, Jeff Moyer wrote:
> ==> Regarding [autofs] dead lock (autofs and/or mount); cedric briner <work@infomaniak.ch> adds:
> 
> work> # ypcat -k auto_home_photom | grep carrier
> work> carrier -bg / obssb6:/export/diskA1/& /unsaved obssb6:/export/diskA2/&
> work>   /backup obssb13:/export/diskA2/backup/&
> 
> Never ever use the "-bg" option in an automount map.  Ian, do we filter
> that out in the new code?  If not, I'll make a note on my TODO list.

Yep. That was in the initial patch set merged into git for 4.1.5.

Ian
