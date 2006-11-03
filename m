From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: dead lock (autofs and/or mount)
Date: Fri, 03 Nov 2006 13:56:08 -0500
Message-ID: <x49wt6c1hrr.fsf@segfault.boston.devel.redhat.com>
References: <454B7750.9000307@infomaniak.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <454B7750.9000307@infomaniak.ch> (cedric briner's message of "Fri,
	03 Nov 2006 18:07:28 +0100")
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
To: cedric briner <work@infomaniak.ch>
Cc: autofs <autofs@linux.kernel.org>

==> Regarding [autofs] dead lock (autofs and/or mount); cedric briner <work@infomaniak.ch> adds:

work> # ypcat -k auto_home_photom | grep carrier
work> carrier -bg / obssb6:/export/diskA1/& /unsaved obssb6:/export/diskA2/&
work>   /backup obssb13:/export/diskA2/backup/&

Never ever use the "-bg" option in an automount map.  Ian, do we filter
that out in the new code?  If not, I'll make a note on my TODO list.

-Jeff
